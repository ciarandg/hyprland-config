{
  config,
  lib,
  ...
}: let
  cfg = config.hyprland-config;
in {
  config = lib.mkIf (cfg.enable) {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          margin-top = 10;
          margin-left = 10;
          margin-right = 10;
          height = 30;
          output = cfg.monitors;
          modules-left = [
            "hyprland/workspaces"
            "tray"
            # "hyprland/window"
          ];
          modules-center = [];
          modules-right = [
            "network"
            "memory"
            "backlight"
            "battery"
            "clock"
          ];
          "wlr/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };
          tray = {
            spacing = 10;
          };
          network = {
            # Extra spaces to cope with botched kerning :(
            format-wifi = "  {essid} {ipaddr}";
            format-disconnected = " ";
          };
          memory = {
            format = "  {used}GiB / {total}GiB";
          };
          backlight = {
            format = "  {percent}%";
          };
          battery = {
            format = "{icon}  {capacity}%";
            format-icons = let 
              empty = "";
              mostlyEmpty = "";
              halfFull = "";
              almostFull = "";
              full = "";
            in [
              empty
              empty # < 10%
              empty
              mostlyEmpty # < 20%
              mostlyEmpty
              mostlyEmpty # < 30%
              mostlyEmpty
              halfFull # < 40%
              halfFull
              halfFull # < 50%
              halfFull
              halfFull # < 60%
              almostFull
              almostFull # < 70%
              almostFull
              almostFull # < 80%
              full
              full # < 90%
              full
              full # <= 100%
            ];
            format-time = "{H}h {M}m";
            states = {
              warning = 30;
              critical = 15;
            };
            interval = 15;
          };
          clock = {
            interval = 1;
            format = "{:%a %b %d %I:%M:%S %p}";
          };
        };
      };
      style = builtins.readFile ./waybar.css;
    };
  };
}
