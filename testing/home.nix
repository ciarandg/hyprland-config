{pkgs, hyprlandModule, ...}: {
  imports = [hyprlandModule];

  config = {
    home.stateVersion = "23.05";
    hyprland-config = {
      enable = true;
      monitors = [];
      hyprland.monitorConfig = "";
      hyprpaper.wallpaperPath = ./desktop.png;
    };
  };
}
