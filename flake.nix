{
  description = "Ciaran's hyprland config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
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
      config = (import ./testing) system self.outputs.nixosModules.hyprland;
    in {
      testing = nixpkgs.lib.nixosSystem config;
    };
  };
}
