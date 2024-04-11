{ config, my-nixvim-config, homePath, nixuffPath, system, ... }:

{
  imports = [ ./modules ];

  home.packages = [ # pkgs.wakapi
    my-nixvim-config.packages."${system}".default
  ];

  home.username = "canos";
  home.homeDirectory = homePath;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      extraConfig = ''
        set -g default-terminal "screen-256color"
      '';
      # TODO: Configure better
    };
    # Shell history thing
    # atuin.enable = true;
    zellij = {
      enable = true;
      # enableBashIntegration = true;
      settings = {
        default_cwd = "~";
        # TODO: Panel stuff?
      };
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    configFile = {
      helix.source = config.lib.file.mkOutOfStoreSymlink
        "${nixuffPath}/home-manager/dotfiles/helix";
    };
  };

  home.stateVersion = "23.05"; # Please read the comment before changing.
}
