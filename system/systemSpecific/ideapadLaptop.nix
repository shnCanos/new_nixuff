{ config, lib, pkgs, usePlasma, ... }:

{
  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-566064f4-23d7-43f9-ae89-58725ded8228".device =
    "/dev/disk/by-uuid/566064f4-23d7-43f9-ae89-58725ded8228";
  boot.initrd.luks.devices."luks-566064f4-23d7-43f9-ae89-58725ded8228".keyFile =
    "/crypto_keyfile.bin";

  networking.hostName = "canos-ideapad-laptop";

  # Fingerprint (Probably not going to do anything, however)
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # services.blueman.enable = true;

  # tlp does not like plasma
  services.tlp.enable = !usePlasma;

  services.throttled.enable =
    true; # Workaround for intel cpu issues, or something?

  # To make tpl work in newer thinkpads (might not be needed)
  # boot = {
  #   kernelModules = [ "acpi_call" ];
  #   extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  # };
}
