{ pkgs, keys, foldWithKey }:

# GitHub Runners can only run one job at a time, so we build some nix containers each holding a runner
# so we can get jobs running concurrently
{ containers = builtins.foldl' (acc: num: acc // { ${"Ardana-CI-Container-${num}"} = {
    # Ensure the containers start and stay clean by themselves
    autoStart = true;
    ephemeral = true;

    # Binding to /nix allows for sharing of the nix-store as well as the nix daemon since it's just a unix socket
    bindMounts = {
      "/nix" = {
        hostPath = "/nix";
        isReadOnly = false;
      };

      # provide each key to the container, since it might need to deploy CI (there by requiring all keys)
    } // foldWithKey (acc: name: key: acc // { "/${name}-raw".hostPath = key.path; }) {} keys;

    config = _:
      { nix = {
          package = pkgs.nixUnstable;
          extraOptions = ''
            experimental-features = nix-command flakes
          '';
        };
        services = {

          # Enable the GitHub Runner systemd module
          github-runner = {
            enable = true;
            name = "Ardana-CI-${num}";
            url = "https://github.com/ArdanaLabs";
            replace = true;

            # Provide some packages to the runner context
            extraPackages = with pkgs; [
              bash
              coreutils
              gnutar
              glibc
              gzip
              git
              curl
              stack
              xz
              hlint
              haskellPackages.fourmolu
              openssh
              nixops
              which
            ];

            # Provide the token file as it will be placed inside the container
            tokenFile = "/github-runner-token-raw";
          };

          # Give the container itself as a knonw host
          openssh.knownHosts.${import ../ip.nix}.publicKey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJkX4gVJdpVGFYOmdRCj8lgho14DhSEzaViWXYM3em31";

        };
        systemd.services.build-key-permissions = {
          serviceConfig.Type = "oneshot";
          wantedBy = [ "default.target" ];

          # Ensure that the github-runner user is available
          after = [ "github-runner.service" ];

          # Make a copy of each key so the github-runner user can access it
          script = pkgs.lib.concatMapStringsSep "\n" (name: ''
            cp /${name}-raw /${name}
            chown github-runner /${name}
            chmod 600 /${name}
          '') (builtins.attrNames keys);
        };
      };
    };

  # Make N Containers
  }) {} (map toString (pkgs.lib.lists.range 0 10));
}
