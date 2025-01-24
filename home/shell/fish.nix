{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set --universal pure_enable_nixdevshell true
      set --universal pure_symbol_nixdevshell_prefix " "
      zoxide init fish | source
    '';
    shellAliases = {
      ls = "eza -la --octal-permissions --git";
      cat = "bat";
      grep = "grep -n --color";
      mkdir = "mkdir -pv";
      lg = "lazygit";
      ".." = "cd ..";
      ":q" = "exit";
      weather = "curl -s v2.wttr.in";
      copy = "xclip -selection clipboard";
      man = "tldr";
      fzf = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    };
    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
