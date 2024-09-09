{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza -la --octal-permissions --git";
      cat = "bat";
      lg = "lazygit";
      rebuild = "~/nix-config/nixos-rebuild.sh";
      ".." = "cd ..";
    };
    oh-my-zsh = {
      enable = true;
      theme = "nicoulaj"; # strug
      plugins = [
        "git"
        "npm"
        "history"
        "node"
      ];
    };
    initExtra = ''
      if [[ "$(tty)" == "/dev/tty1" ]]; then
        Hyprland > /dev/null 2>&1;
      fi

      zellij_tab_name_update() {
        if [[ -n $ZELLIJ ]]; then
          tab_name='''
          if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
              tab_name+=$(basename "$(git rev-parse --show-toplevel)")/
              tab_name+=$(git rev-parse --show-prefix)
              tab_name=''${tab_name}
          else
              tab_name=$PWD
              if [[ $tab_name == $HOME ]]; then
                  tab_name="~"
              else
                  tab_name=''${tab_name}
              fi
          fi
          command nohup zellij action rename-tab "$tab_name" >/dev/null 2>&1
        fi
      }

      autoload -U add-zsh-hook
      add-zsh-hook precmd zellij_tab_name_update
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
