{ config, my-nixvim-config, homePath, nixuffPath, system, ... }:

{
  imports = [ ./modules ];

  home.packages = [ my-nixvim-config.packages."${system}".default ];

  home.username = "canos";
  home.homeDirectory = homePath;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
    # Shell history thing
    # atuin.enable = true;
    zellij = {
      enable = true;
      # enableBashIntegration = true;
      settings = { default_cwd = "~"; };
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
