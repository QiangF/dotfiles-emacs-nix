{ ... }:
{
  imports = [
    ../modules/dev.nix
    ../modules/firefox.nix
    ../modules/keys.nix
    ../modules/shell.nix
    ../modules/terminal.nix
    ../modules/tools.nix
    ../modules/wayland.nix
  ];

  home = {
    username = "whit";
    homeDirectory = "/home/whit";
  };
}
