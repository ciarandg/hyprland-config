{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config.hyprpaper = {
    wallpaperPath = lib.mkOption {
      description = "Path to wallpaper (PNG)";
      type = lib.types.path;
    };
    configPath = lib.mkOption {
      description = "";
      type = lib.types.path;
      readOnly = true;
      default = let
        mkWallpaperLine = (
          monitor: "wallpaper = ${monitor},${cfg.hyprpaper.wallpaperPath}\n"
        );
        wallpapers = lib.strings.concatStrings (map mkWallpaperLine cfg.monitors);
        config = "preload = ${cfg.hyprpaper.wallpaperPath}\n" + wallpapers;
      in builtins.toFile "hyprpaper.conf" config;
    };
  };
}
