{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza -la --octal-permissions --git";
      cat = "bat";
      grep = "grep -n --color";
      mkdir = "mkdir -pv";
      lg = "lazygit";
      rebuild = "~/nix-config/nixos-rebuild.sh";
      ".." = "cd ..";
      ":q" = "exit";
      weather = "curl -s v2.wttr.in/72034";
      copy = "xclip -selection clipboard";
    };
    oh-my-zsh = {
      enable = true;
      theme = "theunraveler"; # strug
      plugins = [
        "git"
        "npm"
        "history"
        "node"
      ];
    };
    initExtra = ''
      if [[ -z "$ZELLIJ" ]]; then
          if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
              zellij attach -c
          else
              zellij
          fi

          if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
              exit
          fi
      fi

      source <(fzf --zsh)
      HISTFILE=~/.zsh_history
      HISTSIZE=100000
      SAVEHIST=100000
      setopt appendhistory
      export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

      zellij_tab_name_update() {
        if [[ -n $ZELLIJ ]]; then
          tab_name=$(basename "$PWD")
          if [[ $PWD == $HOME ]]; then
              tab_name="~"
          else
              tab_name=''${tab_name}
          fi
          command nohup zellij action rename-tab "$tab_name" >/dev/null 2>&1
        fi
      }

      autoload -U add-zsh-hook
      add-zsh-hook precmd zellij_tab_name_update

      export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
