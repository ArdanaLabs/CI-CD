{pkgs, tokenFile}: {
  services = {
    github-runner = {
      enable = false;
      name = "Ardana-CI";
      url = "https://github.com/ArdanaLabs";
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
      inherit tokenFile;
    };
  };
}
