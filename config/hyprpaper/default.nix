{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config = {
    wallpaperPath = lib.mkOption {
      description = "Path to wallpaper (PNG)";
      type = lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpaper
    ];

    home.file.".config/hypr/hyprpaper.conf".text = let
      wallpapers = lib.strings.concatStrings (
        map (monitor: "wallpaper = ${monitor},${cfg.wallpaperPath}\n") cfg.monitors
      );
    in
      ''
        preload = ${cfg.wallpaperPath}
      ''
      + wallpapers;
  };
}
