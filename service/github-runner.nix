{ pkgs, keys, foldWithKey }:
{ containers = builtins.foldl' (acc: num: acc // { ${"Ardana-CI-Container-${num}"} = {
    autoStart = true;
    bindMounts = {
      "/nix" = {
        hostPath = "/nix";
        isReadOnly = false;
      };
    } // foldWithKey (acc: name: key: acc // { "/${name}-raw".hostPath = key.path; }) {} keys;
    config = _:
      { services = {
          github-runner = {
            enable = true;
            name = "Ardana-CI-${num}";
            url = "https://github.com/ArdanaLabs";
            replace = true;
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
            tokenFile = "/github-runner-token";
          };
          openssh.knownHosts.${import ../ip.nix}.publicKey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJkX4gVJdpVGFYOmdRCj8lgho14DhSEzaViWXYM3em31";
        };
        systemd.services.build-key-permissions = {
          serviceConfig.Type = "oneshot";
          wantedBy = [ "default.target" "github-runner.service" ];
          script = pkgs.lib.concatMapStringsSep "\n" (name:
          ''
            cp ./${name}-raw ./${name}
            chown github-runner ./${name}
            chmod 600 ./${name}
          '') (builtins.attrNames keys);
        };
      };
    };
  }) {} (map toString (pkgs.lib.lists.range 0 10));
}
