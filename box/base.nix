{ pkgs, config, resources, ... }: let
  users = import ../users.nix;

  inherit (pkgs.lib.attrsets) mapAttrsToList;
  inherit (pkgs.lib.strings) concatMapStringsSep;
  inherit (pkgs.lib.lists) foldl unique flatten;
  inherit (pkgs.lib) mkForce mkDefault mkOverride;
  inherit (builtins) concatMap fetchTarball;

  shellInit = ''
    # Prevent profile processing from being interrupted
    trap "" 1 2 3 15
    # Automatically log out after 2 minutes
    export TMOUT=120
    readonly TMOUT
    export TERM=xterm
  '';
in {
  imports = [
    <nixpkgs/nixos/modules/profiles/headless.nix>
  ];

  boot.cleanTmpDir = true;

  time.timeZone = mkDefault "Etc/UTC";

  deployment.owners = mkDefault [ "isaac.shapira@platonic.systems" ];

  programs.bash = {
    enableCompletion = true;
    inherit shellInit;
  };

  environment.systemPackages = with pkgs; [ htop vim git ];

  security = {
    sudo = {
      wheelNeedsPassword = false;
      extraConfig = mkDefault ''
        Defaults  env_reset,timestamp_timeout=0
      '';
    };
    audit = mkDefault {
      enable = true;
      rules = [
        # Printk on errors
        "-f 1"
        # Watch for writes and attribute changes
        "-w /etc/passwd -p wa -k passwd_changes"
        # Report renaming/deletion of files by any UID >= 1000
        "-a always,exit -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k all_fschanges"
      ];
    };
  };

  services = {
    openssh                    = {
      enable                 = true;
      passwordAuthentication = mkDefault false;
    };
    locate.enable = true;
    # fail2ban = mkDefault {
    #   enable = true;
    #   ignoreIP = unique (users.publicIPs ++ mapAttrsToList (_: v: v.deployment.targetHost) resources.machines);
    # };
    timesyncd                  = {
      enable                 = true;
      servers                = [
        "time.nist.gov"
        "time-a-b.nist.gov"
        "time-b-b.nist.gov"
        "time-c-b.nist.gov"
        "time-d-b.nist.gov"
        "utcnist.colorado.edu"
        "utcnist2.colorado.edu"
      ];
    };
  };

  users = {
    mutableUsers = mkDefault false;
    users = {
      root.openssh.authorizedKeys.keys = mkDefault (flatten (mapAttrsToList (_: v: v.openssh.authorizedKeys.keys or []) users));
    } // users;
    motd = mkDefault ''

      ┎
      ┃    UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED
      ┃
      ┃    You must have explicit, authorized permission to access or configure this
      ┃    device. Unauthorized attempts and actions to access or use this system may
      ┃    result in civil and/or criminal penalties. All activities performed on this
      ┃    device are logged and monitored.
      ┃
      ┃    Ardana Labs | Platonic.Systems
      ┖

    '';
  };

  nix.extraOptions = mkDefault ''
    trusted-users = [ @wheel ]
  '';
}
