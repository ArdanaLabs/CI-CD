{ config, pkgs, resources, ... }:
let github-runner-token-name = "github-runner-token";
    github-runner-token-contents = builtins.getEnv "GITHUB_RUNNER_TOKEN";
in assert github-runner-token-contents != ""; {
  deployment = {
    targetHost = "138.68.57.54";
    alwaysActivate = true;
    keys.${github-runner-token-name} = {
      text = github-runner-token-contents;
      permissions = "655";
    };
  };
  imports = [
    ../base.nix
    ./configuration.nix
    ../../service/nix.nix
    (import ../../service/github-runner.nix {
      tokenFile = "/run/keys/${github-runner-token-name}";
      inherit pkgs;
    })
  ];
}
