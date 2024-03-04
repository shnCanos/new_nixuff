{ config, nixuffPath, configName, ... }: {
  programs = {
    bash = {
      enable = true;
      initExtra = builtins.readFile ./startup.sh;
      historyIgnore = [
        # Miscellaneous
        "ls"
        "ls"
        "cd"
        "exit"

        # Shutdown and reboot
        "BandanaDeeIsTheGreatestOfAllTime"
        "shutdown"
        "reboot"

        # Projects
        # "python"
        # "cargo"
        # "emacs"
        # "nvim"
        # "vim"
        # "nrs"
        "nix-shell"

        # other
        "update"
        "neofetch"
      ];
    };
  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      TERM = config.home.sessionVariables.TERMINAL;

      # My precious and necessary motivation
      SHELL_MOMMYS_LITTLE = "cute little anime πx developer";
      SHELL_MOMMYS_PRONOUNS = "his";
      SHELL_MOMMYS_ROLES = "peidro-kun";
    };

    shellAliases = {
      nrs =
        "sudo nixos-rebuild switch --flake ${nixuffPath}#${configName} --impure";
      nrb =
        "sudo nixos-rebuild boot --flake ${nixuffPath}#${configName} --impure";
      BandanaDeeIsTheGreatestOfAllTime = "systemctl poweroff";
      shUwUtdOwOn = "systemctl poweroff";
      xobs = "QT_QPA_PLATFORM=xcb flatpak run com.obsproject.Studio";
      ls = "ls -Alh";
      jupy-note = "jupyter notebook";
      update = ''
        # Nixos
        nupdate # Update flake inputs
        nrb # nixos-rebuild boot

        # Fedora
        # sudo dnf update -y

        # Home-manager
        # nix-channel --update
        # hrs

        # Flatpak
        flatpak update -y

        # Doom
        # doom sync
        # doom upgrade
        # doom sync

        # Rustup
        rustup update
      '';
      py = "python";
      vim = "nix run ~/myNixVimConfig"; # HACK
      nupdate =
        "nix flake update ${nixuffPath} && nix flake update ~/myNixVimConfig/";
      xcode = "code --ozone-platform=x11";
    };
  };
}
