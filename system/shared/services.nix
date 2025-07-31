{...}: {
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
