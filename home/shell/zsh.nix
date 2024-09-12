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
