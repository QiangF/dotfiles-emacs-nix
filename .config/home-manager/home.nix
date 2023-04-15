{ pkgs, ... }: {
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ./apps.nix
    ./desktop.nix
    ./dev.nix
    ./shell.nix
    ./wayland.nix
  ];

  home = {
    username = "purplg";
    homeDirectory = "/home/purplg";
    stateVersion = "22.11";
  };

  home.packages = [ pkgs.cachix ];
}
