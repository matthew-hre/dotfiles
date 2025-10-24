{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libnotify
    nomacs
    obsidian
    vim

    (pkgs.writeShellScriptBin "rebuild" ''
      sudo nixos-rebuild switch --flake ~/nix-config#$HOSTNAME 2>&1 | nom
    '')
    (pkgs.writeShellScriptBin "rebuild-test" ''
      sudo nixos-rebuild test --flake ~/nix-config#$HOSTNAME 2>&1 | nom
    '')
  ];
}
