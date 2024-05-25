{pkgs, ...}: {
  # Thunar file manager
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
      ];
    };
    xfconf.enable = true; # XFCE Config
  };
  services = {
    tumbler.enable = true; # Thumbnail support for images
    gvfs.enable = true; # Automounting
    udisks2.enable = true;
    devmon.enable = true;
  };
}
