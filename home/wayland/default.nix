{pkgs, ...}: {
  imports = [
    ./dunst
    ./gtk.nix
    ./hypridle
    ./hyprlock
    ./niri
    ./waybar
  ];

  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    hyprpicker

    networkmanagerapplet
    brightnessctl

    xwayland-satellite
  ];
}
