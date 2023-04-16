{ pkgs, ... }: {
  home.packages = with pkgs; [
    passExtensions.pass-otp
    wl-clipboard
  ];

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };
}
