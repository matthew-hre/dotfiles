{pkgs, ...}: {
  environment.systemPackages = [pkgs.git]; # needed for flakes

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
}
