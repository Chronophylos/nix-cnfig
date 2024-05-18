# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

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
    eza # modern ls
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
    nil

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

    # passwords
    _1password-gui
    _1password

    # music
    spotify
    spicetify-cli
  ];

  programs = {
    neovim.enable = true;

    git = {
      enable = true;
      userName = "Nikolai Zimmermann";
      userEmail = "nikolai@chronophylos.com";
      includes = [{path = "~/Documents/nix-config/home-manager/git.config";}];
    };

    starship = {
      enable = true;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    # alacritty - the best terminal emulator (if it had ligatures)
    alacritty.enable = true;

    zsh = {
      enable = true;
      enableCompletion = false; # enabled in oh-my-zsh
      shellAliases = {
        ls = "eza";
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "systemd"];
        theme = "robbyrussel";
      };
    };

    ssh = {
      enable = true;
      forwardAgent = true;
      extraConfig = ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
    };

    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["chrono"];
    };

    # let home manager install and manage itself
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
