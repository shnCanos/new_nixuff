{ config, pkgs, nixuffPath, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  services.emacs = {
    client.enable = false; # This is only the desktop file
    # TODO - does this work?
    # Emacs is bugged... :(
    # socketActivation.enable = true;
    # startWithUserSession = true;
  };

  home.sessionPath = [ "${config.home.homeDirectory}/.config/emacs/bin" ];
  xdg = {
    desktopEntries = {
      doomEmacs = {
        name = "Doom Emacs";
        genericName = "JOE MAMA! HAHA, GOTTEM!";
        exec = "emacsclient -c -a emacs";
        terminal = false;
        categories = [ "Development" ];
        icon = ./doomemacsicon.png;
      };

      emacsdaemon = {
        name = "Emacs (Daemon)";
        genericName = "Start the emacs daemon";
        exec = "emacs --daemon";
        terminal = false;
        icon = "emacs";
      };
    };

    configFile.doom.source = config.lib.file.mkOutOfStoreSymlink
      "${nixuffPath}/home-manager/modules/emacs/doom";
  };

}
