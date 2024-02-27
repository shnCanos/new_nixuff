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

      mkConfig =
        { system, extraSystemImports, extraHomeManagerImports, ... }@systemArgs:
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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = extraArgs;
                useGlobalPkgs = true;
                useUserPackages = true;

                users.canos = { ... }: {
                  imports = [ ./home-manager/home.nix ]
                    ++ extraHomeManagerImports;
                };
              };
            }
          ] ++ extraSystemImports;
        };
    in {
      nixosConfigurations.main = mkConfig rec {
        configName = "main";
        isDesktop = true;
        system = "x86_64-linux";
        homePath = "/home/canos";
        nixuffPath = "${homePath}/new_nixuff";
        wallpaper = {
          file = ./home-manager/backgrounds/fusion.png;
          isVideo = false;
        };
        useHyprland = true;

        usePlasma = false;
        useSway = false;

        extraSystemImports = [ "${./hosts}/${configName}.nix" ];
        extraHomeManagerImports = [ ];
      };

      nixosConfigurations.hpLaptop = mkConfig rec {
        configName = "hpLaptop";
        system = "x86_64-linux";
        homePath = "/home/canos";
        nixuffPath = "${homePath}/new_nixuff";
        wallpaper = {
          file = ./home-manager/backgrounds/fusion.png;
          isVideo = false;
        };
        usePlasma = true;

        isDesktop = false;
        useHyprland = true;
        useSway = false;

        extraSystemImports = [ "${./hosts}/${configName}.nix" ];
        extraHomeManagerImports = [ ];
      };

      nixosConfigurations.ideapadLaptop = mkConfig rec {
        configName = "ideapadLaptop";
        system = "x86_64-linux";
        homePath = "/home/canos";
        nixuffPath = "${homePath}/new_nixuff";
        wallpaper = {
          file = ./home-manager/backgrounds/fusion.png;
          isVideo = false;
        };
        useHyprland = true;

        useSway = false;
        isDesktop = false;
        usePlasma = false;

        extraSystemImports = [ "${./hosts}/${configName}.nix" ];
        extraHomeManagerImports = [ ];
      };
    };
}
