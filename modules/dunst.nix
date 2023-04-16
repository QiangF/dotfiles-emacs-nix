{ pkgs, ... }: {
  home.packages = [ pkgs.dunst ];

  services.dunst.enable = true;

  systemd.user.services.dunst.Service.wantedBy = [ "default.target" ];
}
