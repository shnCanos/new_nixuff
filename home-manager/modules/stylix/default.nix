{ stylix, wallpaper, pkgs, ... }:

let
  nerdFontPackage = name: (pkgs.nerdfonts.override { fonts = [ name ]; });
  nerdFont = name: {
    name = "${name} Nerd Font";
    package = nerdFontPackage name;
  };
  firaCode = nerdFont "FiraCode";
  jetBrainsMono = nerdFont "JetBrainsMono";
  gohuFont = {
    name = "GohuFont 14 Nerd Font";
    package = nerdFontPackage "Gohu";
  };
in {
  # imports = [ inputs.stylix.nixosModules.stylix ];
  imports = [ stylix.homeManagerModules.stylix ];

  stylix = {
    base16Scheme =
      # ./pastel.yaml;
      "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    # "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = wallpaper.file;

    fonts = {
      serif = jetBrainsMono;
      sansSerif = jetBrainsMono;
      monospace = firaCode;
      sizes = {
        terminal = 13; # FiraCode terminal font size
        # terminal = 17; # Gohu terminal font size
        applications = 10;
      };
    };
    cursor = {
      name = "Reisen cursors";
      package = pkgs.reisen-cursors;
      size = 16;
    };
  };
}
