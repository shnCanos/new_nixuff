{ config, lib, pkgs, ... }:

{
  networking.hostName = "canos-main-nixos"; # Define your hostname.

  services.xserver.videoDrivers = [ "amdgpu" ];
}
