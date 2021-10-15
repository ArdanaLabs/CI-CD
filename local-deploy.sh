source env.sh

export NIXOPS_STATE=$(mktemp -t tmp.XXXXXXXXX.nixops)
chmod o-rwx $NIXOPS_STATE
chmod g-rwx $NIXOPS_STATE

nixops create -d ardana-ci realm.nix 
nixops deploy -d ardana-ci -I nixpkgs=https://github.com/nixinator/nixpkgs/archive/0866fee90937ccffb3a28565fa5f9e5b49783ff4.tar.gz

