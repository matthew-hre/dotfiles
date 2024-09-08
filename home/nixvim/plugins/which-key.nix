#let
#  inherit (import ../utils/_icons.nix) icons;
#in
{
  enable = true;
  settings.icons.group = "";
  settings.win.border = "single";

  # Disable which-key when in neo-tree or telescope
  settings.disable.ft = [
    "TelescopePrompt"
    "neo-tree"
    "neo-tree-popup"
  ];

  # Customize section names (prefixed mappings)
  #    registrations = {
  #      "<leader>b".name = "${icons.Tab} Buffers";
  #      "<leader>bs".name = "${icons.Sort} Sort Buffers";
  #      "<leader>d".name = "${icons.Debugger} Debugger";
  #      "<leader>f".name = "${icons.Search} Find";
  #      "<leader>g".name = "${icons.Git} Git";
  #      "<leader>l".name = "${icons.ActiveLSP} Language Tools";
  #      "<leader>m".name = " Markdown";
  #      "<leader>s".name = "${icons.Session} Session";
  #      "<leader>t".name = "${icons.Terminal} Terminal";
  #      "<leader>u".name = "${icons.Window} UI/UX";
  #    };
}
