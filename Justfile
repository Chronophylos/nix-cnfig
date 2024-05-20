default:
    @just build $USER $HOSTNAME

# Build Configuration for USER on HOST
build USER HOST: format commit push (home-manager USER HOST) (nixos HOST)

# Build Home-Manager Configuration for USER on HOST
home-manager USER HOST:
    home-manager switch --flake .#{{USER}}@{{HOST}}

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
