source env.sh

export NIXOPS_STATE=$(mktemp -t tmp.XXXXXXXXX.nixops)
chmod o-rwx $NIXOPS_STATE
chmod g-rwx $NIXOPS_STATE

nixops create -d ardana-ci realm.nix 
nixops deploy -d ardana-ci -I nixpkgs=https://github.com/nixinator/nixpkgs/archive/f12d631026a1d2a70a4ccdfb0cca02748f1641c0.tar.gz

