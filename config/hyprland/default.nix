{lib, config, ...}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config = {
    monitorConfig = lib.mkOption {
      description = "Monitor configuration for hyprland.conf";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = cfg.monitorConfig + builtins.readFile ./hyprland.conf;
    };
  };
}
