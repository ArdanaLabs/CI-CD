{ cache-key, pkgs }: with pkgs.lib; {
  nix = {

    # Enable serving the binary cache over SSH
    sshServe = {
      enable = true;
      keys =
        # Whitelist all ssh keys from users and public-keys.nix
        (import ../public-keys.nix) ++ concatMap (user: user.openssh.authorizedKeys.keys)
                                                 (attrValues (import ../users.nix));
    };

    # Set up the nix-store signing key
    extraOptions = ''
      secret-key-files = ${cache-key.path}
    '';

    # Keep things fast
    optimise.automatic = true;
    nrBuildUsers = 1000;

    # Let the CI server use some nice binary caches from IOHK
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

  # Keep all nix-store paths signed by signing the store every minute
  systemd = let name = "sign-all"; in {
    timers.${name} = {
      wantedBy = [ "timers.target" ];
      partOf = [ "${name}.service" ];
      timerConfig.OnCalendar = "minutely";
    };
    services.${name} = {
      serviceConfig.Type = "oneshot";
      path = [ pkgs.nix ];
      script = "nix sign-paths --all -k ${cache-key.path}";
    };
  };
}
