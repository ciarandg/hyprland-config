{pkgs, lib, config, ...}: let
  cfg = config.hyprland-config;
in {
  imports = [];
  options = {
    hyprland-config.monitors = lib.mkOption {
      description = "A list of monitor names";
      type = lib.types.listOf lib.types.str;
    };
    hyprland-config.monitorConfig = lib.mkOption {
      description = "Monitor configuration for hyprland.conf";
      type = lib.types.str;
    };
  };
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = cfg.monitorConfig + builtins.readFile ./hyprland.conf;
    };

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
        map (monitor: "wallpaper = ${monitor},${./desktop.png}\n") cfg.monitors
      );
    in ''
      preload = ${./desktop.png}
    '' + wallpapers;
  };
}
