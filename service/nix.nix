{ cache-key, pkgs }: with pkgs.lib; {
  nix = {
    sshServe = {
      enable = true;
      keys =
        (import ../public-keys.nix) ++ concatMap (user: user.openssh.authorizedKeys.keys)
                                                 (attrValues (import ../users.nix));
    };
    extraOptions = ''
      secret-key-files = ${cache-key.path}
    '';
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
