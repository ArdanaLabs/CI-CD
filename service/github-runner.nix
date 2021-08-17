{pkgs, tokenFile, buildFile}:
let token = "/runner-token";
    build-raw = "/build-key-raw";
    build = "/build-key";
in
{ containers = builtins.foldl' (acc: num: acc // { ${"Ardana-CI-Container-${num}"} = {
      autoStart = true;
      bindMounts = {
        ${token}.hostPath = tokenFile;
        ${build-raw}.hostPath = buildFile;
        "/nix" = {
          hostPath = "/nix";
          isReadOnly = false;
        };
      };
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
              ];
              tokenFile = token;
            };
          };
          systemd.services.build-key-permissions = {
            serviceConfig.Type = "oneshot";
            wantedBy = [ "default.target" "github-runner.service" ];
            script = ''
              cat ${build-raw} > ${build}
              chown github-runner ${build}
            '';
          };
        };
      };
    }) {} (map toString (pkgs.lib.lists.range 0 10));
}
