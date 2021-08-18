{ config, pkgs, resources, ... }:
let
  inherit (builtins) filter foldl' all attrValues attrNames;

  # Collect keys from the Environment
  keys =
    { github-runner-token = {
        path = atRun "github-runner-token";
        contents = builtins.getEnv "GITHUB_RUNNER_TOKEN";
        permissions = "655";
      };

      cache-key = {
        path = atRun "cache-key";
        contents = builtins.getEnv "CACHE_KEY";
      };

      build-key = {
        path = atRun "build-key";
        contents = builtins.getEnv "BUILD_KEY";
      };
    };

  atRun = key: "/run/keys/${key}";

  foldWithKey = f: i: xs: foldl' (acc: x: f acc x xs.${x}) i (attrNames xs);

  # Assert we have all the keys we need
in assert all (key: key.contents != "") (attrValues keys);
{
  deployment = {
    targetHost = import ../../ip.nix;
    alwaysActivate = true;

    # Transform the keys set for Nixops
    keys = foldWithKey (acc: name: key: acc //
      { ${name} = {
          text = key.contents;
          permissions = key.permissions or "600";
        };
      }) {} keys;
  };

  # Merge configurations
  imports = [
    ../base.nix
    ./configuration.nix
    (import ../../service/nix.nix           { inherit pkgs; inherit (keys) cache-key; })
    (import ../../service/github-runner.nix { inherit keys pkgs foldWithKey; })
  ];

  # Provide CI with access to itself
  users.users.root.openssh.authorizedKeys.keys =
    # This is the public key for the build-key
    [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBW7m5/g+hC+KqUID/OQtXL+cGF8Y/6O63HwVFEFrqUo root@ardana-ci" ];
}
