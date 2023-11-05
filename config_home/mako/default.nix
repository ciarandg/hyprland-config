{
  config,
  lib,
  ...
}: let
  cfg = config.hyprland-config;
in {
  config = lib.mkIf (cfg.enable) {
    services.mako = {
      enable = true;
      font = "JetBrainsMono Nerd Font";
    };
  };
}
