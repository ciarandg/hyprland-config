self: system: home-manager: {
  inherit system;
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager
    self.nixosModules.hyprland
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.test = import ./home.nix;
      home-manager.extraSpecialArgs = {
        hyprlandModule = self.nixosModules.hyprlandConfigHome;
      };
    }
  ];
  specialArgs = {};
}
