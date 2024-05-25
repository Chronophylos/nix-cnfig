# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  outputs,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules._1password
    outputs.homeManagerModules.hyprland
    outputs.homeManagerModules.eww
    outputs.homeManagerModules.nushell
    outputs.homeManagerModules.thunar

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "chrono";
    homeDirectory = "/home/chrono";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    nnn # terminal file manager

    # archiving
    zip
    xz
    unzip

    # utils
    ripgrep # grep on steroids and rust
    jq # json processor
    yq-go # yaml processor
    fzf # fuzzy finder

    # networking
    mtr # network diagnostics
    iperf3
    ldns # drill the modern dig
    nmap # network discovery because memorizing ips is hard
    socat # replacement of openbsd-netcat

    # misc
    file
    which
    gnused
    gnutar
    zstd
    gnupg

    # nix related
    nix-output-monitor # replace nix. better log output

    # top
    btop
    iotop
    iftop

    # system calls
    strace # system calls
    ltrace # libary calls
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # viewers
    zathura
    feh
    mpv

    # browsers
    brave
    firefox
    thunderbird
    vscode

    # communication
    chatterino2
    telegram-desktop

    # music
    spotify
    spicetify-cli

    # other
    unstable.obsidian

    # TODO: move to develop shell
    nil
    just

    # fonts
    vollkorn # fancy
    fira-code-nerdfont # programming
    inconsolata-nerdfont # terminal

    # rice
    swww
    polkit-kde-agent
    tofi
  ];

  programs = {
    neovim.enable = true;

    git = {
      enable = true;
      userName = "Nikolai Zimmermann";
      userEmail = "nikolai@chronophylos.com";
      includes = [{path = "~/Documents/nix-config/home-manager/git.config";}];
    };

    # alacritty - the best terminal emulator (if it had ligatures)
    alacritty = {
      # TODO: set color theme
      enable = true;
      settings = {
        font.normal.family = "Inconsolata Nerd Font Mono";
      };
    };

    ssh = {
      enable = true;
      forwardAgent = true;
    };

    # let home manager install and manage itself
    home-manager.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    NIXOS_OZONE_WL = "1"; # Tell nixos Wayland is available
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Tell electron to check for wayland
    QT_QPA_PLATFORM = "wayland;xcb"; # Tell qt to try wayland and then x11
  };

  # Make Electron Apps use Wayland
  xdg.configFile."electron-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=WebRTCPipeWireCapturer
  '';
  xdg.configFile."code-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=WebRTCPipeWireCapturer
  '';

  # Enable Keyring
  services.gnome-keyring.enable = true;

  # Enable KDE Authentication Agent
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    Unit = {
      Description = "KDE Authentication Agent for polkit";
      WantedBy = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
