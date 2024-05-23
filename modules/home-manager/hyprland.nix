# Home Manager Module for Hyprland
{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";
      input.kb_layout = "de";
      exec-once = [
        "${pkgs.swww}/bin/swww-daemon & sleep 0.1 & ${pkgs.swww}/bin/swww img ~/Documents/nix-config/wallpaper.webp"
      ];
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
      wayland.force_zero_scaling = true;
    };
    systemd.variables = ["--all"];
  };
}
