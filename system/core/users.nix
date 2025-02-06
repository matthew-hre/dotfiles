{pkgs, ...}: {
  users.users.matthew_hre = {
    isNormalUser = true;
    home = "/home/matthew_hre";
    description = "Matthew Hrehirchuk";
    extraGroups = ["wheel" "networkmanager" "docker"];
    shell = pkgs.fish;
  };

  users.defaultUserShell = pkgs.fish;
}
