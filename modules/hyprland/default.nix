{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  session = {
    command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
    user = "klvdmyyy";
  };

  workspaces = builtins.concatLists (builtins.genList (
    x: let
      ws = let
        c = (x + 1) / 10;
      in
        builtins.toString (x + 1 - (c * 10));
    in [
      "$mod, ${ws}, workspace, ${toString (x + 1)} "
      "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)} "
    ]
  ) 10);
in {
  imports = [
    #inputs.hyprland.nixosModules.default
  ];

  # Greetd UWSM
  services = {
    greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };
  };

  # Hyprland
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;

      # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [];

      settings = {
        "$mod" = "SUPER";

        env = [
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          #"HYPRCURSOR_THEME,${cursorName}"
          #"HYPRCURSOR_SIZE,${toString 16}"
          # See https://github.com/hyprwm/contrib/issues/142
          #"GRIMBLAST_NO_CURSOR,0"
        ];

        exec-once = [
          "uwsm finalize"
        ];

        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 1;
          "col.active_border" = "rgba(88888888)";
          "col.inactive_border" = "rgba(00000088)";

          allow_tearing = true;
          resize_on_border = true;
        };

        decoration = {
          rounding = 10;
          rounding_power = 3;
          blur = {
            enabled = true;
            brightness = 1.0;
            contrast = 1.0;
            noise = 0.01;

            vibrancy = 0.2;
            vibrancy_darkness = 0.5;

            passes = 4;
            size = 7;

            popups = true;
            popups_ignorealpha = 0.2;
          };

          shadow = {
            enabled = true;
            color = "rgba(00000055)";
            ignore_window = true;
            offset = "0 15";
            range = 100;
            render_power = 2;
            scale = 0.97;
          };
        };

        animations.enabled = true;

        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];

        group = {
          groupbar = {
            font_size = 10;
            gradients = false;
            text_color = "rgb(b6c4ff)";
          };

          "col.border_active" = "rgba(35447988)";
          "col.border_inactive" = "rgba(dce1ff88)";
        };

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:win_space_toggle";

          # focus change on cursor move
          follow_mouse = 1;
          accel_profile = "flat";
          tablet.output = "current";
        };

        dwindle = {
          # keep floating dimentions while tiling
          pseudotile = true;
          preserve_split = true;
        };

        misc = {
          force_default_wallpaper = 0;

          # disable dragging animation
          animate_mouse_windowdragging = false;

          # enable variable refresh rate (effective depending on hardware)
          vrr = 1;
        };

        render.direct_scanout = true;

        # touchpad gestures
        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = true;
        };

        xwayland.force_zero_scaling = true;

        debug.disable_logs = false;
        
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];

        bind = [
          "$mod SHIFT, E, exec, pkill Hyprland"
          "$mod, Q, killactive,"
          "$mod, F, fullscreen,"
          "$mod, R, togglesplit,"
          "$mod, T, togglefloating,"
          "$mod, p, pseudo,"

          "$mod, Return, exec, uwsm app -- emacsclient -c"
          "$mod, W, exec, uwsm app -- zen"
        ] ++ workspaces;
      };
    };
  };

  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
