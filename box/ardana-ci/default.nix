{ config, pkgs, resources, ... }:
let github-runner-token-name = "github-runner-token";
    github-runner-token-contents = builtins.getEnv "GITHUB_RUNNER_TOKEN";
    cache-key-name = "cache-key";
    cache-key-contents = builtins.getEnv "CACHE_KEY";
in assert github-runner-token-contents != ""; {
  deployment = {
    targetHost = "138.68.57.54";
    alwaysActivate = true;
    keys.${github-runner-token-name} = {
      text = github-runner-token-contents;
      permissions = "655";
    };
    keys.${cache-key-name} = {
      text =cache-key-contents;
      permissions = "600";
    };
  };
  imports = [
    ../base.nix
    ./configuration.nix
    (import ../../service/nix.nix {
      cache-key = "/run/keys/${cache-key-name}";
      inherit pkgs;
    })
    (import ../../service/github-runner.nix {
      tokenFile = "/run/keys/${github-runner-token-name}";
      inherit pkgs;
    })
  ];
}
