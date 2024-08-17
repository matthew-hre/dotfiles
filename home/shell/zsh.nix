{config, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza -la --octal-permissions --git";
      z = "zoxide";
      cat = "bat";
      lg = "lazygit";
      rebuild = "sudo nixos-rebuild switch";
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
}
