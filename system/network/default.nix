{
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      wifi.scanRandMacAddress = false;
    };
  };

  firewall.enable = true;
}
