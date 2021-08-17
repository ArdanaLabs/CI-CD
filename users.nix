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
}
