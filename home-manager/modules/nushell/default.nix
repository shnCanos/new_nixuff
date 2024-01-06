{ nixuffPath, configName, config, ... }: {
  programs.nushell = {
    enable = true;
    environmentVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      TERM = config.home.sessionVariables.TERMINAL;

      # My precious and necessary motivation
      SHELL_MOMMYS_LITTLE = "'cute little anime πx developer'";
      SHELL_MOMMYS_PRONOUNS = "his";
      SHELL_MOMMYS_ROLES = "peidro-kun";
    };

    configFile.source = ./config.nu;

    shellAliases = {
      nrs =
        "sudo nixos-rebuild switch --flake ${nixuffPath}#${configName} --impure";
      nrb =
        "sudo nixos-rebuild boot --flake ${nixuffPath}#${configName} --impure";
      BandanaDeeIsTheGreatestOfAllTime = "systemctl poweroff";
      shUwUtdOwOn = "systemctl poweroff";
      xobs = "QT_QPA_PLATFORM=xcb flatpak run com.obsproject.Studio";
      ls = "ls -Alh";
      py = "python";
      vim = "nix run ~/myNixVimConfig"; # HACK
    };
  };

  programs = {
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      # enable = true; # For now
      settings = {
        add_newline = true;
        # command_timeout = 1000;

        directory = {
          home_symbol = "󰋞 ~";
          read_only = "  ";
        };
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
