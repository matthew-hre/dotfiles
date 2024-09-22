let colors = {
  background-darker = "rgba(30, 31, 41, 230)";
  background = "#282a36";
  selection = "#44475a";
  foreground = "#f8f8f2";
  comment = "#6272a4";
  cyan = "#8be9fd";
  green = "#50fa7b";
  orange = "#ffb86c";
  pink = "#ff79c6";
  purple = "#bd93f9";
  red = "#ff5555";
  yellow = "#f1fa8c";
};
in
{
  programs.waybar = with colors; {
    enable = true;
    systemd.enable = true;

    style = ''
      
      window#waybar {
        background: transparent;
        color: ${foreground};
        border-bottom: none;
      }

      * {
        border: none;
        border-radius: 0;
        font-size: 14px;
        min-height: 0;
        font-family: "Work Sans", sans-serif;
      }

      #window {
        font-weight: bold;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background-image: linear-gradient(0deg, ${selection}, ${background-darker});
      }

      #workspaces button.active {
        background-image: linear-gradient(0deg, ${purple}, ${selection});
      }

      #workspaces button.urgent {
        background-image: linear-gradient(0deg, ${red}, ${background-darker});
      }

      #taskbar button.active {
        background-image: linear-gradient(0deg, ${selection}, ${background-darker});
      }

      #clock, #tray, #pulseaudio, #network, #battery {
        padding: 0 8px;
        margin: 0 2px;
        color: ${foreground};
        background: transparent;
      }
    '';

    settings = [{
      height = 24;
      layer = "top";
      position = "top";
      tray = { spacing = 10; };
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "battery"
        "clock"
        "tray"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}  ";
        format-icons = [ " " " " " " " " " " ];
        format-plugged = "{capacity}%  ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid}  ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = " ";
          default = [ " " " " " " ];
          handsfree = "";
          headphones = " ";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "  {volume}%  ";
        format-source-muted = " ";
        on-click = "pavucontrol";
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        tooltip = "";
        all-outputs = true;
        format-icons = {
          active = " ";
          default = " ";
        };
      };
    }];
  };
}
