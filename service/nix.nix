{ cache-key, pkgs }: with pkgs.lib; {
  nix = {
    sshServe = {
      enable = true;
      keys =
          # Oleg Prutz
        [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRbUolirg06Wy9mOUcV+2f3Gq+d+D5QzEuI5icycm70VXjYMs0ua52jrBtAW8Ik3xsVp2GrA8Qo8ymRfvdsUgJYw3UR/w/FDYDgRkg6sOumQ34bCBlIFbGuU251Qef4v5ABbeziAjurGxTPXc0HBnjGkwYLVXLWL4Fy0kgAo73n3RJ99BeMynig7WSeq62sn1yy654S7zJ0qM4XrNstU11P/iIR7D2iEsVjEJ/WvFT2nbQRtapXqkLMlcER85ouQo9Zmax6YK4322FzPN3S/ZqPxGs4Kl7YeyHARX7YbToBfWSDkg93SROmdGsS3g0fdGwMwVz+2fowdAGDVyRzNHVuqX2x69Af+jkepLGdL+DRI1VCZP+re+7iqDJiYbHV4VqlBpQhYGZq+hHsoTJLaup7JYlCjrE18NYHPoQcO8KNt6NDTBv2luaIAqtz2kVuERwuEojLFeeA3I2yuDujzjhxgp22FHOw7pO/lfhJpEv0e2KKSlROACEcP6yJeC2+PE= oleg@nixos-dev-machine"
          # Andrzej Swatowski
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKrbeDkKs4yjkBUIhpJV9yjuYP6RZ/wX1fcdJyFCF8/S"
          # Marcin Bugaj
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIygdL7zVacyc1Wh6CvRb1Rh20Jcm9ULK/6qb9lJLUiC marcin@mlabs.city"
          # Ben Hard
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCe2GmcIGvLCyH8D81ZaZ3y9xh0pm4U4y5j1VEtAs2H1GaXLPyc6sgj9echehaTEdd6QqGP8jgGLJaLJB7+JuyjwP+lId3HO5dAE7F17aGJFtArsQ48pDYrR2Zlj7DCf9VRLe3Gsv3kC4q5j/XBwOyvo5aghiQYKMJXpdzep+xXobz25ojFxsBUae9Fr4gJu2wBTaomnLziHWWIZts/vbuvKSvp1dPNWYxBxYA/XsgGqUROui5du5GWqpDp+bb/3bger2YZHYnD+c2sKXJ9E4159PCDQoWrZatHXiYzQym9k+bxCl60DZOSle4yB5HbotrEFMYwCEZCpq40w5wYLl3Qta6XYhU7AlHOzZQWvJjyodGTXeor0esVod0Npw8BuMVmHm41wImKO8uHsK9Gul3Wch9LAGsCztzV8UBTFj8kdp4sBB8cKUYnTAdXyco+gmmbabZ8Ja+knqXOBRLV4mE3lXesLnMmJPq/QfiXQZJAdvJxsxCTmlAZ3LEKCSyV5wE= ben@beast-arch"
          # Ryan Kelker
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQA8RUWB10pnL4diJJKMV4ujkUV+d3ThxMXyv7HQiJQZxZwspSUuChsXo8JXq9rvfGJEBCt1oTzkzFhJ+oWD+THbDq2z4pZSz0DMMnABj+gNCx1AsmKt/kL8ewjDXOxXXVI9atxDrlAnONZmWLlVC2ZJ8v/YPJR2L10BwXX8MlP+bQQNNRuJztWPwNgVb+nBaQFrUie4GWf89nxT9rjgH9axs6abFK5dhXqoboV7zoKQCbVKqj2RaocoRP97FA42Aq/rq86+tXcuhN1iZqvyejDzRUoufU8u7yfq4HGPMuKraA3dU5G54tJWVR1Y9OKiYYCq8wyTkg7AjQr68nbPGoAx08O6SkGAqOwyczltrpfY2wamHXpbBmsGuHYYYH9LVQ+E+K23EcCxk3j93k/HLvokjkzPnI8uyRThA7s88hz6GEJozh7ovT7Mm5HqqkfOs//M94HKRGDvPJLIc0/SjV8K4vWpRf6B22c2Ta5VUq5LhEkDnwyhsrDIQkwVPjPCs= on@machine"
        ]
        ++ concatMap (user: user.openssh.authorizedKeys.keys)
                       (attrValues (import ../users.nix));
    };
    extraOptions = ''
      secret-key-files = ${cache-key}
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
      script = "nix sign-paths --all -k ${cache-key}";
    };
  };
}
