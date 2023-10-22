{lib, config, ...}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config.bindings = {
    keyboard = lib.mkOption {
      default = [
        [ "bind" "SUPER" "M" "exit" "" ]
        [ "bind" "SUPER" "Q" "killactive" "" ]
        [ "bind" "SUPER" "F" "fullscreen" "0" ]
        [ "bind" "SUPER" "K" "layoutmsg" "cycleprev" ]
        [ "bind" "SUPER" "J" "layoutmsg" "cyclenext" ]
        [ "bind" "SUPER SHIFT" "K" "layoutmsg" "swapprev" ]
        [ "bind" "SUPER SHIFT" "J" "layoutmsg" "swapnext" ]
        [ "bind" "SUPER" "Space" "layoutmsg" "swapwithmaster" ]
        [ "bind" "SUPER" "H" "splitratio" "-0.1" ]
        [ "bind" "SUPER" "L" "splitratio" "0.1" ]
        [ "bind" "SUPER" "1" "workspace" "1" ]
        [ "bind" "SUPER" "2" "workspace" "2" ]
        [ "bind" "SUPER" "3" "workspace" "3" ]
        [ "bind" "SUPER" "4" "workspace" "4" ]
        [ "bind" "SUPER" "5" "workspace" "5" ]
        [ "bind" "SUPER" "6" "workspace" "6" ]
        [ "bind" "SUPER" "7" "workspace" "7" ]
        [ "bind" "SUPER" "8" "workspace" "8" ]
        [ "bind" "SUPER" "9" "workspace" "9" ]
        [ "bind" "SUPER" "0" "workspace" "10" ]
        [ "bind" "SUPER SHIFT" "1" "movetoworkspacesilent" "1" ]
        [ "bind" "SUPER SHIFT" "2" "movetoworkspacesilent" "2" ]
        [ "bind" "SUPER SHIFT" "3" "movetoworkspacesilent" "3" ]
        [ "bind" "SUPER SHIFT" "4" "movetoworkspacesilent" "4" ]
        [ "bind" "SUPER SHIFT" "5" "movetoworkspacesilent" "5" ]
        [ "bind" "SUPER SHIFT" "6" "movetoworkspacesilent" "6" ]
        [ "bind" "SUPER SHIFT" "7" "movetoworkspacesilent" "7" ]
        [ "bind" "SUPER SHIFT" "8" "movetoworkspacesilent" "8" ]
        [ "bind" "SUPER SHIFT" "9" "movetoworkspacesilent" "9" ]
        [ "bind" "SUPER SHIFT" "0" "movetoworkspacesilent" "10" ]
        [ "bind" "SUPER" "Semicolon" "workspace" "e+1" ]
        [ "bind" "SUPER" "G" "workspace" "e-1" ]
        [ "bind" "SUPER" "Tab" "workspace" "previous" ]
        [ "bind" "SUPER SHIFT" "F" "togglefloating" "active" ]
        [ "bind" "SUPER" "mouse:274" "toggleFloating" "active" ]
        [ "bind" "SUPER" "S" "pin" "active" ]
        [ "bind" "SUPER" "X" "exec" "swaylock" ]
        [ "bind" "SUPER" "Minus" "exec" "brighter -i -10" ]
        [ "bind" "SUPER" "Equal" "exec" "brighter -i 10" ]
        [ "bind" "SUPER" "B" "exec" "killall -SIGUSR1 .waybar-wrapped" ]
        [ "bind" "SUPER" "F11" "exec" "grim" ]
        [ "bind" "SUPER SHIFT" "F11" "exec" "grim -g \"$(slurp)\"" ]
        [ "bind" "SUPER SHIFT" "C" "exec" "cliphist list | wofi --show dmenu | cliphist decode | wl-copy" ]
        [ "bind" "SUPER" "Return" "exec" "alacritty" ]
        [ "bind" "SUPER" "R" "exec" "alacritty -e lf" ]
        [ "bind" "SUPER SHIFT" "R" "exec" "alacritty -e htop" ]
        [ "bind" "SUPER" "W" "exec" "chromium" ]
        [ "bind" "SUPER" "D" "exec" "wofi --show run" ]
        [ "bind" "SUPER SHIFT" "D" "exec" "discord" ]
        [ "bind" "SUPER SHIFT" "S" "exec" "steam" ]
        [ "bind" "SUPER" "C" "exec" "alacritty -t scratch-calc -e python3 -q" ]
        [ "bind" "SUPER SHIFT" "P" "exec" "helvum" ]
      ];
    mouse = lib.mkOption {
      default = [
        [ "bindm" "SUPER" "mouse:272" "movewindow" "" ]
        [ "bindm" "SUPER" "mouse:273" "resizewindow" "" ]
      ];
    };
    switches = lib.mkOption {
      default = [
        [ "bindl" "" "switch:Lid Switch" "exec" "swaylock" ]
      ];
    };
    };
    translated = {
      keyboard = lib.mkOption {
        description = "Your hyprland keyboard bindings, in the format that hyprland.conf expects";
        readOnly = true;
        default = let
          columns = ["command" "mods" "key" "dispatcher" "params"];
          rawBindings = cfg.bindings;
          bindingAttrs = map (bindingRow:
          lib.lists.foldl (a: b: a // b) {} (
            lib.lists.zipListsWith (col: bind: {${col} = bind;}) columns bindingRow)
          ) rawBindings;
          configLines = map (
            bind: "${bind.command} = ${bind.mods}, ${bind.key}, ${bind.dispatcher}, ${bind.params}"
          ) bindingAttrs;
        in lib.strings.concatStringsSep "\n" configLines;
      };
    };
  };

  config = lib.mkIf cfg.enable {
  };
}
