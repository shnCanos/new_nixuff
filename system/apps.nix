{ config, pkgs, ... }:

# TODO: Restructure this
let
  apps = with pkgs;
  # [
  #   cosmic-bg
  #   cosmic-osd
  #   cosmic-term
  #   cosmic-edit
  #   cosmic-comp
  #   cosmic-randr
  #   cosmic-panel
  #   cosmic-icons
  #   cosmic-files
  #   cosmic-session
  #   cosmic-greeter
  #   cosmic-applets
  #   cosmic-settings
  #   cosmic-launcher
  #   cosmic-protocols
  #   cosmic-screenshot
  #   cosmic-applibrary
  #   cosmic-notifications
  #   cosmic-settings-daemon
  #   cosmic-workspaces-epoch
  #   xdg-desktop-portal-cosmic
  # ] ++ 
    [ # Apps
      mpv
      teamspeak5_client
      discover
      discord
      kcalc
      sioyek
      neovim
    ] ++

    # Cool stuff
    [
      # Icon theme
      tela-icon-theme

      # CLI utils
      cowsay
      lolcat
      fortune
      sl
      neofetch
      ncdu
      distrobox
      ani-cli
      btop
      cava
      playerctl
      yt-dlp
      shell-mommy # Custom derivation
      killall
      git
      jq
      pciutils
      tree
      ffmpeg
      wget
      openssl # hmm
      ripgrep
      fzf
      dust
      bat
      tldr

      # Virtual machine
      virt-manager
      win-virtio

      # Other
      showmethekey

      # Do I even need this?
      gamescope
      showmethekey
    ] ++
    # Dev stuff
    [
      # Flutter
      flutter

      # PROLOG
      swiProlog

      # LUA
      lua

      # Rust
      cargo
      gcc

      # Dependencies
      lld
      ninja
      cmake

      #ah
      gdb
      gdbgui
    ] ++ [ # python311
      (python311.withPackages (ps:
        with ps; [
          # Doom
          black
          pyflakes
          isort
          pipenv
          nose
          pytest

          # Jupyter
          notebook

          # I don't know
          pynvim
        ]))
    ];
in { environment.systemPackages = apps; }
