{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      # proggyfonts -> It seems to collide with dina fonts when doing the workaround
      emacs-all-the-icons-fonts
      # nerdfonts
      symbola
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Gohu" ]; })
    ];
    fontDir.enable = true;
  };
}
