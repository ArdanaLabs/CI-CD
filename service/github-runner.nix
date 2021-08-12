{pkgs, tokenFile}: {
  services = {
    github-runner = {
      enable = true;
      name = "Ardana-CI";
      url = "https://github.com/ArdanaLabs";
      extraPackages = with pkgs; [
        stack
        xz
        hlint
        haskellPackages.fourmolu
      ];
      inherit tokenFile;
    };
  };
}
