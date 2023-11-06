{
  description = "Ciaran's hyprland config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: let
    system = "x86_64-linux";
  in {
    packages.${system} = {
      hyprland = nixpkgs.legacyPackages.${system}.hyprland;
    };

    nixosModules = {
      hyprland = import ./config_nixos;
      hyprlandConfigHome = import ./config_home;
    };

    nixosConfigurations = let
      config = (import ./testing) self system home-manager;
    in {
      testing = nixpkgs.lib.nixosSystem config;
    };
  };
}
