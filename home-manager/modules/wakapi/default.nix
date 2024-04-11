{ pkgs, ... }:

{
  home.packages = with pkgs; [ wakapi ];

  systemd.user.services.wakapi = {
    Unit.Description = "Auto start wakapi";
    Install.WantedBy = [ "default.target" ];
    Service = {
      # Type = "simple";
      ExecStart = "${pkgs.wakapi}/bin/wakapi -config ${./wakapi.yml}";
      Restart = "on-failure";
      RestartSec = 90;

      # Security hardening
      # PrivateTmp = true;
      # PrivateUsers = true;
      # NoNewPrivileges = true;
      # ProtectSystem = "full";
      # ProtectHome = true;
      # ProtectKernelTunables = true;
      # ProtectKernelModules = true;
      # ProtectKernelLogs = true;
      # ProtectControlGroups = true;
      # PrivateDevices = true;
      # CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      # ProtectClock = true;
      # RestrictSUIDSGID = true;
      # ProtectHostname = true;
      # ProtectProc = "invisible";
    };
  };

  home.file.".wakatime.cfg".source = ./wakapi.cfg;
}
