{pkgs, ...}: let
  spotify-player = pkgs.spotify-player.override {
    withStreaming = true;
    withDaemon = true;
    withMediaControl = true;
    withLyrics = false;
    withImage = false;
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
