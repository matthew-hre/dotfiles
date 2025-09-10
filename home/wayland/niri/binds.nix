{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    sh = spawn "sh" "-c";
  in {
    "Mod+Space".action.spawn = ["fuzzel"];
    "Mod+Return".action.spawn = ["ghostty" "+new-window"];
    "Mod+Q".action = close-window;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+G".action = toggle-window-floating;
    "Mod+C".action = center-column;
    "Mod+V".action = sh "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";

    "Mod+L".action.spawn = ["hyprlock"];

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";

    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    "Mod+Left".action = focus-column-left;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;
    "Mod+Right".action = focus-column-right;

    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Down".action = move-window-down;
    "Mod+Shift+Up".action = move-window-up;
    "Mod+Shift+Right".action = move-column-right;

    "Mod+Shift+Ctrl+Left".action = consume-or-expel-window-left;
    "Mod+Shift+Ctrl+Right".action = consume-or-expel-window-right;

    "Mod+Shift+S".action = screenshot;
    "Print".action = screenshot;
    "Alt+Print".action = screenshot-window;

    "Mod+Shift+Slash".action = show-hotkey-overlay;

    "Ctrl+Alt+Delete".action.spawn = ["~/nix-config/scripts/fuzzel_power.sh"];

    "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "--limit" "1.0"];
    "XF86AudioRaiseVolume".allow-when-locked = true;
    "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
    "XF86AudioLowerVolume".allow-when-locked = true;
    "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
    "XF86AudioMute".allow-when-locked = true;
    "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
    "XF86AudioMicMute".allow-when-locked = true;
    "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
    "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];

    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    # waiting for sodiboo/niri-flake#1018 to be fixed
    "Mod+Shift+1".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "1"];
    "Mod+Shift+2".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "2"];
    "Mod+Shift+3".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "3"];
    "Mod+Shift+4".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "4"];
    "Mod+Shift+5".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "5"];
    "Mod+Shift+6".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "6"];
    "Mod+Shift+7".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "7"];
    "Mod+Shift+8".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "8"];
    "Mod+Shift+9".action.spawn = ["niri" "msg" "action" "move-column-to-workspace" "9"];

    "Mod+Z".action = toggle-overview;
  };
}
