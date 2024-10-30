set -o allexport
source <(sops --decrypt secrets/secret.env)
set +o allexport

vsce publish
