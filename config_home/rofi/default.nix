{
  config,
  lib,
  ...
}: let
  cfg = config.hyprland-config;
  inherit (config.programs.rofi) configPath;
  windowConfig = "window { width: 50%; }";
in lib.mkIf cfg.enable {
  programs.rofi = {
    enable = true;
    location = "top";
    font = "JetBrainsMono Nerd Font 12";
    theme = "gruvbox-dark";
    extraConfig = {
      disable-history = true;
    };
  };

  # Fortunately, this text gets appended to the config file
  home.file."${configPath}".text = windowConfig;
}
