{ ... }:
{
  imports = [
    ../modules/apps.nix
    ../modules/dev.nix
    ../modules/firefox.nix
    ../modules/keys.nix
    ../modules/shell.nix
    ../modules/terminal.nix
    ../modules/wayland.nix
  ];

  home = {
    username = "whit";
    homeDirectory = "/home/whit";
  };
}
