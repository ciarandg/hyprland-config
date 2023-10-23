{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland-config;
in {
  imports = [./bindings.nix];

  options.hyprland-config = {
    monitorConfig = lib.mkOption {
      description = "Monitor configuration for hyprland.conf";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig =
        cfg.monitorConfig
        + ''
          # Execute your favorite apps at launch
          exec-once = waybar & hyprpaper & wl-paste --watch cliphist store

          # Source a file (multi-file configs)
          # source = ~/.config/hypr/myColors.conf

          # Some default env vars.
          env = XCURSOR_SIZE,24

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

              drop_shadow = yes
              shadow_range = 4
              shadow_render_power = 3
              col.shadow = rgba(1a1a1aee)
          }

          animations {
              enabled = no
          }

          master {
              mfact = 0.8
              new_is_master = true
              no_gaps_when_only = false
              inherit_fullscreen = true
          }

          $mainMod = SUPER

          # Window rules
          windowrule = float,title:scratch-calc
          windowrule = pin,title:scratch-calc
          windowrule = size 600 400,title:scratch-calc
          windowrule = center,title:scratch-calc
        ''
        + cfg.bindings.translated;
    };
  };
}
