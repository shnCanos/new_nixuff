{ pkgs, ... }: {
  users.users = {
    canos = {
      isNormalUser = true;
      description = "canos";
      # shell = pkgs.nushell;
      extraGroups = [
        # Default
        "networkmanager"
        "wheel"
        "users"

        # Virtual Machines
        "libvirtd"
        "kvm"
        "qemu-libvirtd"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment.localBinInPath = true;

  hardware = {
    opengl = {
      # Mesa
      enable = true;

      # Vulkan
      driSupport = true;
      driSupport32Bit = true;
    };

    steam-hardware.enable = true;
    opentabletdriver.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/London";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  networking = {
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
    };
    firewall.enable = true;
  };

  services = {
    openssh = { enable = true; };
    resolved.enable = true;
    gnome.gnome-keyring.enable = true;
    printing.enable = true;
    flatpak.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  # Enable sound with pipewire.
  sound = { enable = true; };
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Japanese input
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [
    pkgs.fcitx5-mozc # pkgs.fcitx5-gtk pkgs.fcitx5-configtool
  ];

  # Would normally set this to fcitx, but kitty only supports ibus, and fcitx
  # provides an ibus interface. Can't use ibus for e.g. QT_IM_MODULE though,
  # because that at least breaks mumble
  # environment.variables.GLFW_IM_MODULE = "ibus";

  system.stateVersion = "23.05";
}
