{
  "chloe.kever" = {
    description = "Chloe Kever";
    extraGroups = [ "wheel" ];  # Wheel is required for deploy
    isNormalUser = true;
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMaYwUX4MK8kWv0EW0ALvNMDAgIMvaLehvTSN28gf4R chloe@chloe-nixos01"
    ];
  };
  "isaac.shapira" = {
    description = "Isaac Shapira";
    extraGroups = [ "wheel" ];  # Wheel is required for deploy
    isNormalUser = true;
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZzKmSxSVqol+YNsGr5Cts5Cr/eIHqCm/KISHsluVtJ isaac@dunlap"
    ];
  };
  "ben.sima" = {
    description = "Ben Sima";
    extraGroups = [ "wheel" ];  # Wheel is required for deploy
    isNormalUser = true;
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFwELhge1RDopmPyiUpz7yK1JUlt6kywIsQVhTuCeFGr ben.sima@platonic.systems"
    ];
  };
  "morgan.thomas" = {
    description = "Morgan Thomas";
    extraGroups = [ "wheel" ];  # Wheel is required for deploy
    isNormalUser = true;
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4QHH0bsyIcuSQDBUBtgmqlRHlfdO8PBY+5ReaXj/7N morgan@ripley"
      "sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0olgOUsA5OjNlRHMsIqaXMWA2/7FfkUl8MvCNYqmcC morgan@morgan-ThinkPad-E15"
    ];
  };
  "lee.hughes" = {
    description = "Lee Hughes";
    extraGroups = [ "wheel" ];  # Wheel is required for deploy
    isNormalUser = true;
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbfyNtj4t5GvRbFBkIMzK14oyOs5fRSDJARTR49ooXruS6Uf7Lh03anVYod8wIrc4O4arY+5Ect7Ilu96WqhJ2GCwsHv19J93NbXdU6BwO35tO35oXG2tsHfe/2mpS8C3Tm4xbk8vbxHPXiRd6c0mK2i1Cn26E7bFMUIr45QEGlOA3PvwEpPcIX7ica4dWDhTIyhPxPPgDshbhLSmymCiCqUJ4p61U0e1qcOO5nxogH0Ld6JCzEvPQsBI5KVOltHteePA6PISFk79735e5HSdqGtAjqcWXwMtSfRI2jfayh84TJh9P2HLlb+MEYm+3VqqcA+ffN246Idf2//n6siF3 l33@nixos"
    ];
  };
}
