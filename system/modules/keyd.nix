{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            # capslock = "leftcontrol";
            esc = "capslock";
            # leftcontrol = "tab";
            # tab = "esc";
          };
        };
      };
    };
  };
}
