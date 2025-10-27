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

  home-manager.users.matthew_hre.home = {
    bat.enable = true;
    btop.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    fuzzel.enable = true;
    garbage.enable = true;
    git.enable = true;
    ssh.enable = true;
    vicinae.enable = true;

    editors.helix.enable = true;
    editors.nvf.enable = true;
    editors.vscode.enable = true;

    shell.fish.enable = true;
    shell.ghostty.enable = true;

    wayland.enable = true;
  };

  services.hibernation = {
    enable = true;
    swapDeviceUUID = "773e93e2-0dd1-48f1-95a8-7f8acb4fb177";
    lidAction = "suspend-then-hibernate";
    hibernateDelay = "30m";
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
