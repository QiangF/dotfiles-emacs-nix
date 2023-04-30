{ pkgs, ... }: {
  home.packages = with pkgs; [
    yuzu-mainlain
  ];
}
