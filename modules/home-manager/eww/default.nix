# eww Module
{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
  ];
  programs.eww = {
    enable = true;
    configDir = ./config;
  };
}
