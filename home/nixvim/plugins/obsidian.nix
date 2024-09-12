{
  enable = true;
  settings = {
    ui = {
      enable = true;

      checkboxes = {
        " " = {
          char = "󰄱";
          hl_group = "ObsidianTodo";
        };
        "x" = {
          char = "";
          hl_group = "ObsidianDone";
        };
        ">" = {
          char = "";
          hl_group = "ObsidianRightArrow";
        };
        "~" = {
          char = "󰰱";
          hl_group = "ObsidianTilde";
        };
        "!" = {
          char = "";
          hl_group = "ObsidianImportant";
        };
      };

      external_link_icon = {
        char = "";
        hl_group = "ObsidianExtLinkIcon";
      };
    };
    workspaces = [
      {
        name = "personal";
        path = "~/University/Obsidian/matthew_hre";
      }
    ];
  };
}
