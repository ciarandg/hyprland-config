{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.hyprland-config;
in {
  imports = [./bindings.nix];

  options.hyprland-config.hyprland = {
    monitorConfig = lib.mkOption {
      description = "Monitor configuration for hyprland.conf";
      type = lib.types.str;
    };
    execOnce = lib.mkOption {
      description = "A list of commands to run at startup";
      type = lib.types.listOf lib.types.str;
      default = let
        bin = import ./binary-paths.nix lib pkgs;
      in [
        bin.waybar
        "${bin.hyprpaper} --config ${cfg.hyprpaper.configPath}"
        "${bin.wl-paste} --watch ${bin.cliphist} store"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.wl-clipboard];

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };

    wayland.windowManager.hyprland = let
      execOnce = lib.strings.concatStrings (
        map (cmd: "exec-once = ${cmd}\n") cfg.hyprland.execOnce
      );
    in {
      enable = true;
      extraConfig =
        cfg.hyprland.monitorConfig
        + execOnce
        + ''
          # Source a file (multi-file configs)
          # source = ~/.config/hypr/myColors.conf

          input {
              kb_layout = us
              kb_variant =
              kb_model =
              kb_options = caps:escape
              kb_rules =

              follow_mouse = 1

              touchpad {
                  disable_while_typing = yes
                  natural_scroll = yes
          	scroll_factor = 1.0
          	middle_button_emulation = false
          	tap-to-click = true
          	drag_lock = false
              }

              sensitivity = 0.6 # [-1.0, 1.0]
          }

          binds {
              # https://github.com/hyprwm/Hyprland/issues/2691
              allow_workspace_cycles = yes
          }

          general {
              gaps_in = 5
              gaps_out = 20
              border_size = 5
              col.active_border = rgba(005577ee)
              col.inactive_border = rgba(444444ee)

              layout = master
          }

          decoration {
              rounding = 0

              blur {
                enabled = yes
                size = 3
                passes = 1
                new_optimizations = on
              }

              shadow {
                enabled = yes
                range = 4
                render_power = 3
                color = rgba(1a1a1aee)
              }
          }

          animations {
              enabled = no
          }

          master {
              mfact = 0.8
              new_status = master
              inherit_fullscreen = true
          }

          $mainMod = SUPER

          # Window rules
          windowrule = float,title:scratch-calc
          windowrule = pin,title:scratch-calc
          windowrule = size 600 400,title:scratch-calc
          windowrule = center,title:scratch-calc
        ''
        + cfg.hyprland.bindings.translated;
    };
  };
}
