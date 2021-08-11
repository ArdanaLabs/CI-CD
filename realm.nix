{
  network = {
    description = "Ardana CI";
    enableRollback = true;
  };

  ardana-ci = { config, lib, resources, pkgs, ... }:
  {
    imports = [
      (import ./box/ardana-ci { inherit config pkgs resources; })
    ];
  };
}
