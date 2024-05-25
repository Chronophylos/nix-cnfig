# Home Manager Module for Hyprland
{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";
      exec-once = [
        "${pkgs.eww}/bin/eww open bar" # open bar
        "${pkgs.hypridle}/bin/hypridle" # run hypridle
      ];
      input.kb_layout = "de";
      "$mod" = "SUPER";
      bind =
        [
          ", Print, exec, grimblast copy area"
          "$mod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
          "$mod, R, exec, ${pkgs.tofi}/bin/tofi-run"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      xwayland.force_zero_scaling = true;
    };
    systemd.variables = ["--all"];
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = false;
      splash = true;
      preload = ["~/Documents/nix-config/wallpaper.jpg"];
      wallpaper = ["eDP-1,~/Documents/nix-config/wallpaper.jpg"];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  home.packages = with pkgs; [
    # Qt Wayland Support
    qt5.qtwayland
    qt6.qtwayland
  ];
}
