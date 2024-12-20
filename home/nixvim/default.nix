{...}: {
  imports = [
    ./completion.nix
    ./keymaps.nix
    ./lsp.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    enableMan = false;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    clipboard = {
      providers.xsel.enable = true;

      register = "unnamedplus";
    };

    colorschemes.dracula = {
      enable = true;
      settings.colorterm = false;
    };

    opts = {
      breakindent = true;
      cmdheight = 0;
      completeopt = ["menu" "menuone" "noselect"];
      conceallevel = 2;
      confirm = true;
      copyindent = true;
      cursorline = true;
      expandtab = true;
      fillchars = {eob = " ";};
      # enable fold with all code unfolded
      foldcolumn = "1";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      ignorecase = true;
      inccommand = "split";
      infercase = true;
      linebreak = true;
      list = true;
      listchars = "tab:‒▶,trail:·,multispace:·,lead: ,nbsp:⎕";
      mouse = "a";
      number = true;
      preserveindent = true;
      pumheight = 10;
      relativenumber = true;
      shiftwidth = 2;
      showmode = false;
      showtabline = 2;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      title = true;
      undofile = true;
      wrap = false;
      writebackup = false;
    };

    performance.combinePlugins.enable = true;
  };
}
