system: hyprland: {
  inherit system;
  modules = [
    ./configuration.nix
    hyprland
  ];
  specialArgs = {};
}
