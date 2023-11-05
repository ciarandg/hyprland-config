{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.hyprland-config;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
