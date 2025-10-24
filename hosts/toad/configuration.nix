{pkgs, ...}: let
  system = ../../system;
in {
  imports = [
    ./hardware-configuration.nix
    "${system}/core"
    "${system}/shared"
    "${system}/hardware/bluetooth.nix"
    "${system}/hardware/fprintd.nix"
    "${system}/hardware/fwupd.nix"
    "${system}/network"
    "${system}/programs/discord.nix"
    "${system}/programs/fonts.nix"
    "${system}/programs/libre.nix"
    "${system}/programs/niri.nix"
    "${system}/programs/steam.nix"
    "${system}/programs/xdg.nix"
    "${system}/services/boot.nix"
    "${system}/services/docker.nix"
    "${system}/services/greetd.nix"
    "${system}/services/openssh.nix"
    "${system}/services/openvpn.nix"
    "${system}/services/pipewire.nix"
    "${system}/services/power.nix"
  ];

  users.matthew_hre = {
    enable = true;
    configs = {
      bat = true;
      btop = true;
      direnv = true;
      fastfetch = true;
      fuzzel = true;
      garbage = true;
      git = true;
      ssh = true;
      vicinae = true;
      helix = true;
      nvf = true;
      
      shell = {
        enable = true;
        fish = true;
        ghostty = true;
      };
      
      wayland = {
        enable = true;
        dunst = true;
        gtk = true;
        hypridle = true;
        hyprlock = true;
        niri = true;
        waybar = true;
        wlsunset = true;
      };
    };
  };

  networking.hostName = "toad";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
