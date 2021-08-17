{pkgs, tokenFile, buildFile}:
let token = "/runner-token";
    build = "/build-key";
in
{ containers = builtins.foldl' (acc: num: acc // { ${"Ardana-CI-Container-${num}"} = {
      autoStart = true;
      bindMounts = {
        ${token} = {
          hostPath = tokenFile;
          isReadOnly = true;
        };
        ${build} = {
          hostPath = buildFile;
          isReadOnly = true;
        };
        "/nix" = {
          hostPath = "/nix";
          isReadOnly = false;
        };
      };
      config = _:
        {  services = {
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
        };
      };
    }) {} (map toString (pkgs.lib.lists.range 0 10));
}
