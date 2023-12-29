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
      system = "x86_64-linux";
      homePath = "/home/canos";
      nixuffPath = "${homePath}/new_nixuff";
      wallpaper = ./home-manager/backgrounds/fusion.png;
      usePlasma = false;
      useHyprland = true;
      useSway = false; # WIP

      pkgs = import nixpkgs {
        system = system;
        config = { allowUnfree = true; };
        overlays = [
          (final: prev: {
            # My precious and necessary motivation
            shell-mommy = final.callPackage ./derivations/shell-mommy.nix { };
          })
        ];
      };

      mkConfig = configName:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs pkgs homePath nixuffPath wallpaper usePlasma
              useHyprland useSway;
          };

          modules = [
            ./system
            # HACK: so I can use configName like that
            "${nixuffPath}/system/systemSpecific/${configName}.nix"
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs homePath nixuffPath wallpaper configName system
                    useHyprland useSway;
                };
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
      nixosConfigurations.main = mkConfig "main";
      nixosConfigurations.hpLaptop = mkConfig "hpLaptop";
      nixosConfigurations.ideapadLaptop = mkConfig "ideapadLaptop";
    };
}
