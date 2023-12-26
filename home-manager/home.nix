{ config, homePath, nixuffPath, inputs, system, ... }:

{
  imports = [ ./modules ];

  home.packages = [ inputs.my-nixvim-config.packages."${system}".default ];

  home.username = "canos";
  home.homeDirectory = homePath;
  targets.genericLinux.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
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
