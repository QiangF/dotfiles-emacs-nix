{ pkgs, ... }: {
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
    fd
  ];
}
