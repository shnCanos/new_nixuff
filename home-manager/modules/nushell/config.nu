
      def nupdate [] {
        nix flake update ${nixuffPath}
        nix flake update ~/myNixVimConfig
      }

      def update [] {
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
        }
