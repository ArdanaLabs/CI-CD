{
  nix = {
    sshServe.enable = true;
    optimise.automatic = true;
    nrBuildUsers = 1000;
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
    binaryCaches = [
      "https://cache.nixos.org"
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
    ];
  };
}
