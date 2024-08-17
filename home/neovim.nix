{config, pkgs, lib, ...}:
{
  programs.neovim = {
    vimAlias = true;
    viAlias = true;
  };
  
  programs.nixvim = {
    enable = true;

    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      termguicolors = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-fzf
      nvim-fzf-commands
    ];
  };
}
