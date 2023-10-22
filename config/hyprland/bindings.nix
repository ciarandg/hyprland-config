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
        ["bindl" "" "switch:Lid Switch" "exec" "swaylock"]
      ];
    };
    translated = {
      full = lib.mkOption {
        description = "Your hyprland bindings, in the format that hyprland.conf expects";
        readOnly = true;
        default = lib.strings.concatStringsSep "\n" (
          cfg.bindings.translated.partials.keyboard ++ cfg.bindings.translated.partials.mouse
        );
      };
      partials = {
        keyboard = lib.mkOption {
          description = "Your hyprland keyboard bindings, in the format that hyprland.conf expects";
          readOnly = true;
          default = let
            columns = ["mods" "key" "dispatcher" "params"];
            rawBindings = cfg.bindings.keyboard;
            bindingAttrs =
              map (
                bindingRow:
                  lib.lists.foldl (a: b: a // b) {} (
                    lib.lists.zipListsWith (col: bind: {${col} = bind;}) columns bindingRow
                  )
              )
              rawBindings;
            configLines =
              map (
                bind: "bind = ${bind.mods}, ${bind.key}, ${bind.dispatcher}, ${bind.params}"
              )
              bindingAttrs;
          in
            configLines;
        };
        mouse = lib.mkOption {
          description = "Your hyprland mouse bindings, in the format that hyprland.conf expects";
          readOnly = true;
          default = let
            columns = ["mods" "key" "dispatcher"];
            rawBindings = cfg.bindings.mouse;
            bindingAttrs =
              map (
                bindingRow:
                  lib.lists.foldl (a: b: a // b) {} (
                    lib.lists.zipListsWith (col: bind: {${col} = bind;}) columns bindingRow
                  )
              )
              rawBindings;
            configLines =
              map (
                bind: "bindm = ${bind.mods}, ${bind.key}, ${bind.dispatcher}"
              )
              bindingAttrs;
          in
            configLines;
        };
      };
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
