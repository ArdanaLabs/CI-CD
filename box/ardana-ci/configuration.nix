{ lib, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    <nixpkgs/nixos/modules/virtualisation/digital-ocean-config.nix>
  ];

  networking.hostName = "ardana-ci";
}
