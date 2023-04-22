{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      kb-row-down = "Down,Control+n,Control+j";
      kb-row-up = "Up,Control+p,Control+k";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "";
    };
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
