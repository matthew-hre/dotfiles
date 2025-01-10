{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          monitor = "";
          path = "~/Pictures/wallpaper.png";
          blur_passes = 3;
          blur_size = 12;
          noise = "0.2";
        }
      ];

      input-field = [
        {
          monitor = "eDP-1";

          size = "300, 50";
          valign = "bottom";
          position = "0%, 10%";

          outline_thickness = 1;

          font_color = "rgb(248, 248, 242)";

          outer_color = "rgba(139, 233, 253, 0.5)";
          inner_color = "rgba(80, 250, 123, 0.1)";
          check_color = "rgba(241, 250, 140, 0.5)";
          fail_color = "rgba(255, 85, 85, 0.5)";

          fade_on_empty = false;
          placeholder_text = "Enter Password";

          dots_spacing = 0.2;
          dots_center = true;
          dots_fade_time = 100;

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = ''
            cmd[update:1000] echo "<span font-weight='ultralight' >$(date +'%H %M %S')</span>"
          '';
          font_size = 200;
          font_family = "Work Sans";

          color = "rgb(248, 248, 242)";

          position = "0%, 2%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}
