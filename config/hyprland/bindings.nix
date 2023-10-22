{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config.bindings = {
    keyboard = lib.mkOption {
      default = [
        ["SUPER" "M" "exit" ""]
        ["SUPER" "Q" "killactive" ""]
        ["SUPER" "F" "fullscreen" "0"]
        ["SUPER" "K" "layoutmsg" "cycleprev"]
        ["SUPER" "J" "layoutmsg" "cyclenext"]
        ["SUPER SHIFT" "K" "layoutmsg" "swapprev"]
        ["SUPER SHIFT" "J" "layoutmsg" "swapnext"]
        ["SUPER" "Space" "layoutmsg" "swapwithmaster"]
        ["SUPER" "H" "splitratio" "-0.1"]
        ["SUPER" "L" "splitratio" "0.1"]
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
        ["SUPER" "Semicolon" "workspace" "e+1"]
        ["SUPER" "G" "workspace" "e-1"]
        ["SUPER" "Tab" "workspace" "previous"]
        ["SUPER SHIFT" "F" "togglefloating" "active"]
        ["SUPER" "mouse:274" "toggleFloating" "active"]
        ["SUPER" "S" "pin" "active"]
        ["SUPER" "X" "exec" "swaylock"]
        ["SUPER" "Minus" "exec" "brighter -i -10"]
        ["SUPER" "Equal" "exec" "brighter -i 10"]
        ["SUPER" "B" "exec" "killall -SIGUSR1 .waybar-wrapped"]
        ["SUPER" "F11" "exec" "grim"]
        ["SUPER SHIFT" "F11" "exec" "grim -g \"$(slurp)\""]
        ["SUPER SHIFT" "C" "exec" "cliphist list | wofi --show dmenu | cliphist decode | wl-copy"]
        ["SUPER" "Return" "exec" "alacritty"]
        ["SUPER" "R" "exec" "alacritty -e lf"]
        ["SUPER SHIFT" "R" "exec" "alacritty -e htop"]
        ["SUPER" "W" "exec" "chromium"]
        ["SUPER" "D" "exec" "wofi --show run"]
        ["SUPER SHIFT" "D" "exec" "discord"]
        ["SUPER SHIFT" "S" "exec" "steam"]
        ["SUPER" "C" "exec" "alacritty -t scratch-calc -e python3 -q"]
        ["SUPER SHIFT" "P" "exec" "helvum"]
      ];
    };
    mouse = lib.mkOption {
      default = [
        ["SUPER" "mouse:272" "movewindow"]
        ["SUPER" "mouse:273" "resizewindow"]
      ];
    };
    switches = lib.mkOption {
      default = [
        ["" "switch:Lid Switch" "exec" "swaylock"]
      ];
    };
    translated = let
      mkPartial = commandName: rawBindings:
        map (binds: "${commandName}=" + (lib.strings.concatStringsSep "," binds)) rawBindings;
    in lib.mkOption {
      description = "Your hyprland bindings, in the format that hyprland.conf expects";
      readOnly = true;
      default = lib.strings.concatStringsSep "\n" (
        (mkPartial "bind" cfg.bindings.keyboard)
        ++ (mkPartial "bindm" cfg.bindings.mouse)
        ++ (mkPartial "bindl" cfg.bindings.switches)
      );
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
