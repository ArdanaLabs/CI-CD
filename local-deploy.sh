source env.sh

export NIXOPS_STATE=$(mktemp -t tmp.XXXXXXXXX.nixops)
chmod o-rwx $NIXOPS_STATE
chmod g-rwx $NIXOPS_STATE

nixops create -d ardana-ci realm.nix 
nixops deploy -d ardana-ci -I nixpkgs=https://github.com/nixinator/nixpkgs/archive/07802314390347535970f665e61cc85f1e662e24.tar.gz

