default:
    @just build $HOSTNAME

# Build Configuration for HOST
build HOST: format commit push (nixos HOST)

# Build NixOS Configuration for HOST
nixos HOST:
    sudo nixos-rebuild switch --flake .#{{HOST}}

# Format Configuration
format:
    nix fmt

# Commit any Changes
commit:
    git add -A
    git commit -m "update"

# Push Changes to remmote
push:
    git push