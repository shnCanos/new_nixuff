{
  description = "shnCanos' config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixvim-config.url = "github:shnCanos/myNixVimConfig";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      mkConfig = { system,
        # Path to $HOME
        homePath,

        # The name of the configuration
        configName,

        # Desktop or Laptop?
        isDesktop,

        # Desktop environments
        useSway, useHyprland, usePlasma,

        # Where this repo is located
        nixuffPath,

        # Path to wallpaper
        wallpaper }@systemArgs:

        let
          pkgs = import nixpkgs {
            system = system;
            config = { allowUnfree = true; };
            overlays = [
              (final: prev: {
                # My precious and necessary motivation
                shell-mommy =
                  final.callPackage ./derivations/shell-mommy.nix { };
              })
            ];
          };

          extraArgs = systemArgs // inputs // { inherit pkgs; };
        in lib.nixosSystem {
          inherit system;
          specialArgs = extraArgs;

          modules = [
            ./system
            "${./hosts}/${configName}.nix"
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = extraArgs;
                useGlobalPkgs = true;
                useUserPackages = true;

                users.canos = { ... }: {
                  imports = [ ./home-manager/home.nix ];
                };
              };
            }
          ];
        };
    in {
      nixosConfigurations.main = mkConfig rec {
        configName = "main";
        isDesktop = true;
        system = "x86_64-linux";
        homePath = "/home/canos";
        nixuffPath = "${homePath}/new_nixuff";
        wallpaper = ./home-manager/backgrounds/fusion.png;
        useHyprland = true;

        usePlasma = false;
        useSway = false;

      };

      nixosConfigurations.hpLaptop = mkConfig rec {
        configName = "hpLaptop";
        system = "x86_64-linux";
        homePath = "/home/canos";
        nixuffPath = "${homePath}/new_nixuff";
        wallpaper = ./home-manager/backgrounds/fusion.png;
        useHyprland = true;

        isDesktop = false;
        usePlasma = false;
        useSway = false;
      };

      nixosConfigurations.ideapadLaptop = mkConfig rec {
        configName = "ideapadLaptop";
        system = "x86_64-linux";
        homePath = "/home/canos";
        nixuffPath = "${homePath}/new_nixuff";
        wallpaper = ./home-manager/backgrounds/fusion.png;
        useHyprland = true;

        useSway = false;
        isDesktop = false;
        usePlasma = false;
      };
    };
}
