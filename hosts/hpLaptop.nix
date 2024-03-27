{ config, lib, pkgs, ... }:

{
  # boot = {
  # blacklistedKernelModules = [ "nouveau" ];
  # };

  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-29e02db6-57a3-4364-a6ec-5fada8cc05d1".device =
    "/dev/disk/by-uuid/29e02db6-57a3-4364-a6ec-5fada8cc05d1";
  boot.initrd.luks.devices."luks-29e02db6-57a3-4364-a6ec-5fada8cc05d1".keyFile =
    "/crypto_keyfile.bin";

  networking.hostName = "canos-hp-nixos"; # Define your hostname.

  # Enable fingerprint
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  # NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
