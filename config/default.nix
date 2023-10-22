{pkgs, lib, config, ...}: let
  cfg = config.hyprland-config;
in {
  imports = [
    ./hyprland
  ];

  options = {
    hyprland-config = {
      enable = lib.mkEnableOption {
        description = "Whether to enable hyprland-config";
        default = false;
      };
      monitors = lib.mkOption {
        description = "A list of monitor names";
        type = lib.types.listOf lib.types.str;
      };
      wallpaperPath = lib.mkOption {
        description = "Path to wallpaper (PNG)";
        type = lib.types.path;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpaper
      pkgs.grim
      pkgs.slurp
      pkgs.wofi
      pkgs.wl-clipboard
      pkgs.cliphist
      # cpkgs.brighter
    ];

    home.file.".config/hypr/hyprpaper.conf".text = let
      wallpapers = lib.strings.concatStrings (
        map (monitor: "wallpaper = ${monitor},${cfg.wallpaperPath}\n") cfg.monitors
      );
    in ''
      preload = ${cfg.wallpaperPath}
    '' + wallpapers;
  };
}
