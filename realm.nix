let
  inherit (builtins) getEnv;
in {
  network = {
    description = "Ardana CI";
    enableRollback = true;
  };

  ardana-ci = { config, lib, resources, ... }: let
    pkgs = import ../pkgs.nix {};
  in {
    imports = [
      (import ./box/ardana-ci { inherit config pkgs resources; })
    ];
  };
}
