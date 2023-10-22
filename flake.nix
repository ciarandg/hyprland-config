{
  description = "Ciaran's hyprland config";

  outputs = { self, nixpkgs }: {
    nixosModules = {
      hyprlandConfigHome = import ./config;
    };
  };
}
