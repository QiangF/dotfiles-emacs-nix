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

  home.packages = [ pkgs.jetbrains-mono ];
}
