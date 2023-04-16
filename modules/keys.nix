{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    pass.enable = true;
    pass.extraConfig = ''
      help_color="#FF0000"
    '';
  };

  programs.gpg.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
  ];

  services = {
    gpg-agent.enable = true;
    gpg-agent.enableSshSupport = true;
    gpg-agent.pinentryFlavor = "curses";
    # gpg-agent.grabKeyboardAndMouse = false;
  };
}
