# Ciaran's Hyprland Config

This is very much a work in progress, not even worth looking at yet

## Testing VM

The output `.#nixosConfigurations.testing` is a configuration that you
can use to test this config in a VM. Run:

1. `nixos-rebuild build-vm --flake .#testing`
2. `./result/bin/run-nixos-vm`
