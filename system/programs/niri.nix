{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swww # needs to be installed at the system level
    polkit_gnome
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # shoutout @CodedNil on gh for the fix
  # waiting on https://github.com/YaLTeR/niri/pull/1923 for a real fix
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings.global = {
        overload_tap_timeout = 200; #ms
      };
      settings.main = {
        compose = "layer(meta)";
        leftmeta = "overload(meta, macro(leftmeta+z))";
      };
    };
  };

  # turns out i've been using this the whole time!
  # i believe niri uses this automatically, but it doesn't hurt to set it
  services.gnome.gnome-keyring.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
