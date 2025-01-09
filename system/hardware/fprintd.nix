{pkgs, ...}: {
  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
}
