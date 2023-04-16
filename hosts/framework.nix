{ ... }:
{
  imports = [
    ../modules/dev.nix
    ../modules/dunst.nix
    ../modules/firefox.nix
    ../modules/keys.nix
    ../modules/pass.nix
    ../modules/shell.nix
    ../modules/syncthing.nix
    ../modules/terminal.nix
    ../modules/tools.nix
    ../modules/wayland.nix
  ];

  home = {
    username = "purplg";
    homeDirectory = "/home/purplg";
  };
}
