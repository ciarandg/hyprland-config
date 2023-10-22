{pkgs, lib, config, ...}: let
  cfg = config.hyprland-config;
in {
  imports = [
    ./hyprland
    ./hyprpaper
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
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.grim
      pkgs.slurp
      pkgs.wofi
      pkgs.wl-clipboard
      pkgs.cliphist
      # cpkgs.brighter
    ];
  };
}
