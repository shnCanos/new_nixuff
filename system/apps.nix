{ pkgs, ... }:

# TODO: Restructure this
let
  apps = with pkgs; {
    mainApps = [
      # Apps
      mpv
      teamspeak5_client
      discover
      discord
      kcalc
      sioyek
    ];

    cliUtils = [
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
    ];
    neovimStuff = [
      neovim

      # LSPs, formatters and linters
      # Lua
      lua-language-server
      stylua
      # Rust
      rust-analyzer
      # C
      clang-tools
      ccls
      cppcheck
      cmake
      astyle
      # cmake_lint
      # Bash
      nodePackages.bash-language-server
      shfmt
      # Python
      nodePackages.pyright
      ruff-lsp
      python311Packages.black
      python311Packages.isort
      # nix
      nil
      nixd
      statix
      nixfmt-rfc-style
      deadnix
      markdownlint-cli
      # normal text
      ltex-ls
      # Assembly
      asm-lsp

      # Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      tree-sitter

      # Other
      unzip
      nodejs # npm
      fzf
    ];

    devStuff = [
      # Rust
      rustup
      # C
      gcc
      cmake
      gdb
      gdbgui
      valgrind
      glibc
      astyle
      uncrustify
      python310Packages.lizard
      astyle
      lld
      ninja
      # Flutter
      flutter
      # PROLOG
      swiProlog
      # LUA
      lua
      # Other
      zip
      icdiff
    ];

    other = [
      # python311
      (python311.withPackages (
        ps: with ps; [
          # Doom
          pyflakes
          pipenv
          nose
          pytest

          # Jupyter
          notebook

          # I don't know
          pynvim
        ]
      ))
    ];
  };
in
{
  environment.systemPackages = builtins.concatLists (builtins.attrValues apps);
}
