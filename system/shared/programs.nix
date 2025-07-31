{...}: {
  programs = {
    firefox = {
      enable = true;
    };
    fish.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["matthew_hre"];
    };
  };
}
