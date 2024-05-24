# Home Manager Module for Hyprland
{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";
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
      wallpaper = [",~/Documents/nix-config/wallpaper.jpg"];
    };
  };
}
