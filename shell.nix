#nixops broke in unstable for a little bit
#so a handy shell.nix to bring a 21.05 that works
#https://github.com/NixOS/nixpkgs/issues/147034


#with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz) {});
with (import (fetchTarball https://github.com/NixOS/nixpkgs/archive/refs/tags/21.05.tar.gz) {});
mkShell {
  buildInputs = [
    nixops
  ];
}
