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
    amberol
    (celluloid.override {youtubeSupport = true;})
    file-roller
    loupe
    nautilus
    pwvucontrol

    wl-clipboard
    cliphist
    hyprpicker

    networkmanagerapplet
    brightnessctl

    xwayland-satellite
  ];
}
