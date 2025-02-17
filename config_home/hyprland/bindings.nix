{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config.hyprland.bindings = {
    keyboardBase = let
      bin = import ./binary-paths.nix lib pkgs;
    in
      lib.mkOption {
        description = "The base keyboard bindings for working with Hyprland and system utils";
        default = [
          # Kill Hyprland
          ["SUPER" "M" "exit" ""]

          # Kill window
          ["SUPER" "Q" "killactive" ""]

          # Make window fullscreen
          ["SUPER" "F" "fullscreen" "0"]

          # Move focus
          ["SUPER" "K" "layoutmsg" "cycleprev"]
          ["SUPER" "J" "layoutmsg" "cyclenext"]

          # Rearrange window stack
          ["SUPER SHIFT" "K" "layoutmsg" "swapprev"]
          ["SUPER SHIFT" "J" "layoutmsg" "swapnext"]
          ["SUPER" "Space" "layoutmsg" "swapwithmaster"]

          # Adjust window split
          ["SUPER" "H" "splitratio" "-0.1"]
          ["SUPER" "L" "splitratio" "0.1"]

          # Switch between workspaces
          ["SUPER" "1" "workspace" "1"]
          ["SUPER" "2" "workspace" "2"]
          ["SUPER" "3" "workspace" "3"]
          ["SUPER" "4" "workspace" "4"]
          ["SUPER" "5" "workspace" "5"]
          ["SUPER" "6" "workspace" "6"]
          ["SUPER" "7" "workspace" "7"]
          ["SUPER" "8" "workspace" "8"]
          ["SUPER" "9" "workspace" "9"]
          ["SUPER" "0" "workspace" "10"]

          # Move active window between workspaces
          ["SUPER SHIFT" "1" "movetoworkspacesilent" "1"]
          ["SUPER SHIFT" "2" "movetoworkspacesilent" "2"]
          ["SUPER SHIFT" "3" "movetoworkspacesilent" "3"]
          ["SUPER SHIFT" "4" "movetoworkspacesilent" "4"]
          ["SUPER SHIFT" "5" "movetoworkspacesilent" "5"]
          ["SUPER SHIFT" "6" "movetoworkspacesilent" "6"]
          ["SUPER SHIFT" "7" "movetoworkspacesilent" "7"]
          ["SUPER SHIFT" "8" "movetoworkspacesilent" "8"]
          ["SUPER SHIFT" "9" "movetoworkspacesilent" "9"]
          ["SUPER SHIFT" "0" "movetoworkspacesilent" "10"]

          # Rotate through existing workspaces
          ["SUPER" "Semicolon" "workspace" "e+1"]
          ["SUPER" "G" "workspace" "e-1"]

          # Switch to most recently viewed workspace
          ["SUPER" "Tab" "workspace" "previous"]

          # Toggle current window floating
          ["SUPER SHIFT" "F" "togglefloating" "active"]
          ["SUPER" "mouse:274" "toggleFloating" "active"]

          # Pin active window
          ["SUPER" "S" "pin" "active"]

          # Screen locker
          ["SUPER" "X" "exec" bin.swaylock]

          # Screen brightness
          ["SUPER" "Minus" "exec" "${bin.brightnessctl} s 10%-"]
          ["SUPER" "Equal" "exec" "${bin.brightnessctl} s +10%"]

          # Toggle waybar
          ["SUPER" "B" "exec" "${bin.killall} -SIGUSR1 .waybar-wrapped"]

          # Screenshots
          ["SUPER" "F11" "exec" bin.grim]
          ["SUPER SHIFT" "F11" "exec" "${bin.grim} -g \"$(${bin.slurp})\""]

          # Clipboard manager
          ["SUPER SHIFT" "C" "exec" "${bin.cliphist} list | ${bin.rofi} -dmenu | ${bin.cliphist} decode | ${bin.wl-copy}"]

          # Program launcher
          ["SUPER" "D" "exec" "${bin.rofi} -show drun"]
        ];
      };
    keyboard = lib.mkOption {
      description = "Extra keyboard bindings, split from base bindings for convenience";
      default = [
        # Launch programs
        ["SUPER" "Return" "exec" "alacritty"]
        ["SUPER" "R" "exec" "alacritty -e yazi"]
        ["SUPER SHIFT" "R" "exec" "alacritty -e htop"]
        ["SUPER" "W" "exec" "chromium"]
        ["SUPER SHIFT" "D" "exec" "discord"]
        ["SUPER SHIFT" "S" "exec" "steam"]
        ["SUPER" "C" "exec" "alacritty -t scratch-calc -e python3 -q"]
        ["SUPER SHIFT" "P" "exec" "helvum"]
      ];
    };
    mouse = lib.mkOption {
      default = [
        # Move/resize windows with mouse
        ["SUPER" "mouse:272" "movewindow"]
        ["SUPER" "mouse:273" "resizewindow"]
      ];
    };
    switches = lib.mkOption {
      default = [
        # Screen locker
        ["" "switch:Lid Switch" "exec" "swaylock"]
      ];
    };
    translated = let
      mkPartial = commandName: rawBindings:
        map (binds: "${commandName}=" + (lib.strings.concatStringsSep "," binds)) rawBindings;
    in
      lib.mkOption {
        description = "Your hyprland bindings, in the format that hyprland.conf expects";
        readOnly = true;
        default = lib.strings.concatStringsSep "\n" (
          (mkPartial "bind" cfg.hyprland.bindings.keyboardBase)
          ++ (mkPartial "bind" cfg.hyprland.bindings.keyboard)
          ++ (mkPartial "bindm" cfg.hyprland.bindings.mouse)
          ++ (mkPartial "bindl" cfg.hyprland.bindings.switches)
        );
      };
  };
}
