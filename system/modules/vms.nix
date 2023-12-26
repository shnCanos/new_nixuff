{ ... }: {
  virtualisation = {
    waydroid.enable = false; # For now

    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        runAsRoot = true;
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
