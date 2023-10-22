{lib, config, ...}: let
  cfg = config.hyprland-config;
in {
  options.hyprland-config = {
    monitorConfig = lib.mkOption {
      description = "Monitor configuration for hyprland.conf";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = cfg.monitorConfig + ''
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
        
        # Kill Hyprland
        bind = $mainMod, M, exit, 
        
        # Kill window
        bind = $mainMod, Q, killactive, 
        
        # Make window fullscreen
        bind = $mainMod, F, fullscreen, 0
        
        # Move focus
        bind = $mainMod, K, layoutmsg, cycleprev
        bind = $mainMod, J, layoutmsg, cyclenext
        
        # Rearrange window stack
        bind = $mainMod SHIFT, K, layoutmsg, swapprev
        bind = $mainMod SHIFT, J, layoutmsg, swapnext
        bind = $mainMod, Space, layoutmsg, swapwithmaster
        
        # Adjust window split
        bind = $mainMod, H, splitratio, -0.1
        bind = $mainMod, L, splitratio, 0.1
        
        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
        bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
        bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
        bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
        bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
        bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
        bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
        bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
        bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
        bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
        
        # Rotate through existing workspaces
        bind = $mainMod, Semicolon, workspace, e+1
        bind = $mainMod, G, workspace, e-1
        
        # Switch to most recently viewed workspace
        bind = $mainMod, Tab, workspace, previous
        
        # Toggle current window floating
        bind = $mainMod SHIFT, F, togglefloating, active
        bind = $mainMod, mouse:274, toggleFloating, active
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
        
        # Pin active window
        bind = $mainMod, S, pin, active
        
        # Screen locker
        bindl=,switch:Lid Switch,exec,swaylock
        bind = $mainMod, X, exec, swaylock
        
        # Screen brightness
        bind = $mainMod, Minus, exec, brighter -i -10
        bind = $mainMod, Equal, exec, brighter -i 10
        
        # Toggle waybar
        bind = $mainMod, B, exec, killall -SIGUSR1 .waybar-wrapped
        
        # Screenshots
        bind = $mainMod, F11, exec, grim
        bind = $mainMod SHIFT, F11, exec, grim -g "$(slurp)"
        
        # Clipboard manager
        bind = $mainMod SHIFT, C, exec, cliphist list | wofi --show dmenu | cliphist decode | wl-copy
        
        # Launch programs
        bind = $mainMod, Return, exec, alacritty
        bind = $mainMod, R, exec, alacritty -e lf
        bind = $mainMod SHIFT, R, exec, alacritty -e htop
        bind = $mainMod, W, exec, chromium
        bind = $mainMod, D, exec, wofi --show run
        bind = $mainMod SHIFT, D, exec, discord
        bind = $mainMod SHIFT, S, exec, steam
        bind = $mainMod, C, exec, alacritty -t scratch-calc -e python3 -q
        bind = $mainMod SHIFT, P, exec, helvum
      '';
    };
  };
}
