{ ... }:
{
  imports = [
    ../modules/dev.nix
    ../modules/keys.nix
    ../modules/shell.nix
    ../modules/terminal.nix
    ../modules/tools.nix
  ];

  home = {
    username = "whit";
    homeDirectory = "/home/whit";
  };
}
