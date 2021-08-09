{ pkgs }: {
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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7pc5sIRQ9Ou9BXBQVPDJcbUZ2g2+YYTFZphHDSRiKReCP8xyFkGto0zOMs17aj6OzuzjEGR8B1Hcr84d2/H0fiOK7hXqTbksknyTkPvLxSUiLb2Glmnuzr6TIVPfiHC9dQ3QNa4f5+/y0xzsjAtK7B/h15mL0Mpac6x+LwwxxeUCKrEJePhekgyCXpRr2hrPUEbmCQ3MDF/BcH/einXsZoOL9khk/Vc68Nf9VmRbm3abS0JwLl1xCDIly16bHh7QpmY5Jg7LuBkf/YSR02y9Xk1Iz81AvsCyHv+8daipRrLwtCAp/AsL0ZkrJTADY2E8tN485/QjLQkMEShHlWx9OmKeEwn9Y0yhFQBfFEKyRRzm+I6KZAc11Mdb1V3Zr2ilehpTctoRc4IdisjgEAoScdj7PpVWOu8ZzH/9yKA9sqvzjIC4q/lfvGuIWCUXhNlldDifdZiCr1Ax5GgsJx9obdDCQtlxlOZGu3bqNBW4eucljOSlNkV1/WoOt9EUnL/5vzC/LedUnYNm3KaCtw8qIqfJm7PBsxBThBZ1AphCgQrwCB+utByTX+C6dxxzagyLBU9sqRFYCw1+SoFhin8g9xS/tBuG784LYZqIfxRcFh2ltz6V+zaYX/aYGb+j4tq36BHoCqfBqEBLsK9X8j0WaNScsgbvD4MfL+s4oeq69Ow== morgan.a.s.thomas@gmail.com"
    ];
  };
}
