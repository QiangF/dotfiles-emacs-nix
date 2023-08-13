{ pkgs, ... }: {
  programs.zathura.enable = true;

  home.packages = with pkgs; [
    stow
    mtr
    procs
    ripgrep
    bottom
    rsync
    mpv
    gping
    qmk
    bfs
  ];
}
