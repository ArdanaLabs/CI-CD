{ config, pkgs, resources, ... }:
let

  github-runner-token = rec {
    name = "github-runner-token";
    path = atRun name;
    contents = builtins.getEnv "GITHUB_RUNNER_TOKEN";
  };

  cache-key = rec {
    name = "cache-key";
    path = atRun name;
    contents = builtins.getEnv "CACHE_KEY";
  };

  build-key = rec {
    name = "build-key";
    path = atRun name;
    contents = builtins.getEnv "BUILD_KEY";
  };

  atRun = key: "/run/keys/${key}";

in assert github-runner-token.contents != "";
   assert cache-key.contents != "";
   assert build-key.contents != "";
{
  deployment = {
    targetHost = "138.68.57.54";
    alwaysActivate = true;
    keys = {
      ${github-runner-token.name} = {
        text = github-runner-token.contents;
        permissions = "655";
      };
      ${cache-key.name} = {
        text = cache-key.contents;
        permissions = "600";
      };
      ${build-key.name} = {
        text = build-key.contents;
        permissions = "600";
      };
    };
  };
  imports = [
    ../base.nix
    ./configuration.nix
    (import ../../service/nix.nix {
      cache-key = cache-key.path;
      inherit pkgs;
    })
    (import ../../service/github-runner.nix {
      tokenFile = github-runner-token.path;
      buildFile = build-key.path;
      inherit pkgs;
    })
  ];
  users.users.root.openssh.authorizedKeys.keys = [ build-key.contents ];
}
