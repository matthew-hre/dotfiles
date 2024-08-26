{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = "q";
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 50000;

    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      prefix-highlight
      dracula
      better-mouse-mode
      vim-tmux-navigator
      yank
    ];

    extraConfig = ''
      set -g @dracula-show-powerline true
      set -g @dracula-fixed-location "Calgary"
      set -g @dracula-plugins "weather"
      set -g @dracula-show-flags true
      set -g @dracula-show-left-icon session
      set -g status-position top
    '';
  };
}
