{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.hyprland-config;
in {
  config = lib.mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      notify = true;
      tray = "auto";
      automount = true;
    };
    home.packages = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
