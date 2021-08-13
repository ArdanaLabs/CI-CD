{pkgs, tokenFile}: let token = "/runner-token"; in
{ containers = builtins.foldl' (acc: num: acc // { ${"Ardana-CI-Container-${num}"} = {
      autoStart = true;
      bindMounts.${token} = {
        hostPath = tokenFile;
        isReadOnly = true;
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
               ];
               tokenFile = token;
             };
           };
        };
      };
    }) {} (map toString (pkgs.lib.lists.range 0 10));
}
