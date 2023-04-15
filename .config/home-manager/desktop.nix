{ pkgs, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "zsh";
        font = "JetBrainsMono:size=10";
      };
      colors = {
        foreground = "dcdccc";
        background = "111111";
      };
    };
  };

  programs.rofi = {
    enable = true;
    pass.enable = true;
    pass.extraConfig = ''
      help_color="#FF0000"
    '';
  };

  programs.gpg = {
    enable = true;
  };

  home.packages = with pkgs; [
    dunst
    wl-clipboard
    jetbrains-mono
  ];

  services = {
    dunst.enable = true;
    gpg-agent.enable = true;
    gpg-agent.enableSshSupport = true;
    gpg-agent.pinentryFlavor = "curses";
    # gpg-agent.grabKeyboardAndMouse = false;
  };

  systemd.user.services.dunst.Service.wantedBy = [ "default.target" ];
}
