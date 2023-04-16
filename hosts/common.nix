{ pkgs, ... }:
{
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "22.11";

  home.packages = [ pkgs.cachix ];
}
