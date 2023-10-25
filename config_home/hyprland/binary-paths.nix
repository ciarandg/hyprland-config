lib: pkgs: {
  swaylock = lib.getExe pkgs.swaylock;
  killall = "${pkgs.psmisc}/bin/killall";
  grim = lib.getExe pkgs.grim;
  cliphist = lib.getExe pkgs.cliphist;
  wofi = lib.getExe pkgs.wofi;
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  brightnessctl = lib.getExe pkgs.brightnessctl;
  waybar = lib.getExe pkgs.waybar;
  hyprpaper = lib.getExe pkgs.hyprpaper;
}
