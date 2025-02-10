#!/usr/bin/env fish

set selection (echo -e " Lock\n Reboot\n⏻ Shutdown" | fuzzel --dmenu -l 7 -p "󰚥 ")

switch $selection
    case "*Lock"
        hyprlock
    case "*Reboot"
        systemctl reboot
    case "*Shutdown"
        systemctl poweroff
end

