{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libnotify
    nomacs
    obsidian
    vim
  ];
}
