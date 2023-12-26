{ inputs, wallpaper, pkgs, ... }:

let
  nerdFont = name: {
    name = "${name} Nerd Font";
    package = (pkgs.nerdfonts.override { fonts = [ name ]; });
  };
  firaCode = nerdFont "FiraCode";
  jetBrainsMono = nerdFont "JetBrainsMono";
in {
  # imports = [ inputs.stylix.nixosModules.stylix ];
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = wallpaper;

    fonts = {
      serif = firaCode;
      sansSerif = firaCode;
      monospace = jetBrainsMono;
      sizes = {
        terminal = 12;
        applications = 10;
      };
    };
    cursor = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };
  };
}
