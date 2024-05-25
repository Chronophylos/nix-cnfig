{pkgs, ...}: {
  services.hypridle = {
    enable = true;
    settings = let
      lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
      suspend_cmd = "systemctl suspend || loginctl suspend"; # fuck nvidia
    in {
      general = {
        lock_cmd = lock_cmd;
        before_sleep_cmd = lock_cmd;
      };
      listener = [
        {
          timeout = 180; # 3mins
          on-timeout = lock_cmd;
        }
        {
          timeout = 240; # 4mins
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 540; # 9mins
          on-timeout = suspend_cmd;
        }
      ];
    };
  };
}
