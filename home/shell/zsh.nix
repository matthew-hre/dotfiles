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
      theme = "strug";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
      ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
