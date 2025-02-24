{pkgs, ...}: let
  spotify-player = pkgs.spotify-player.override {
    withStreaming = true;
    withDaemon = true;
    withMediaControl = true;
    withImage = true;
    withNotify = true;
    withSixel = false;
    withFuzzy = true;
  };
in {
  programs.spotify-player = {
    enable = true;
    package = spotify-player;
  };
}
