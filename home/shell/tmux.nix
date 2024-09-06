{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 50000;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      dracula
    ];

    extraConfig = ''
      set -g mouse on
      set -g status-position top
      set -g @dracula-plugins "battery network time weather"
      set -g @dracula-show-location false
      set -g @dracula-show-powerline true
      set -g @dracula-show-left-sep 
      set -g @dracula-show-right-sep 
      set -g @dracula-refresh-rate 10
      set -g @dracula-network-bandwidth wlan0
      set -g @dracula-show-fahrenheit false

      bind -r source-file "$HOME/.config/tmux/tmux.conf"
    '';
  };
}
