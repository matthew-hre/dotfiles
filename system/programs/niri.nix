{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    amberol
    (celluloid.override {youtubeSupport = true;})
    file-roller
    loupe
    nautilus
    pwvucontrol
    swww
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # shoutout @CodedNil on gh for the fix
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
