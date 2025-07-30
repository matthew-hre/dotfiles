{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swww # needs to be installed at the system level
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # shoutout @CodedNil on gh for the fix
  # waiting on https://github.com/YaLTeR/niri/pull/1923 for a real fix
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings.global = {
        overload_tap_timeout = 200; #ms
      };
      settings.main = {
        compose = "layer(meta)";
        leftmeta = "overload(meta, macro(leftmeta+z))";
      };
    };
  };
}
