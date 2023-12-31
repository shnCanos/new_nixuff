{ config, pkgs, ... }:

let
  apps = with pkgs;
    [ # Apps
      mpv
      teamspeak5_client
      discover
      kcalc
    ] ++

    # Cool stuff
    [
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
