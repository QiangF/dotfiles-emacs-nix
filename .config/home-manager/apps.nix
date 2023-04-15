{ pkgs, ... }: {
  home.packages = with pkgs; [
    syncthing
    passExtensions.pass-otp
    firefox
    stow
    mtr
    procs
    ripgrep
    bottom
    rsync
  ];

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };
}
