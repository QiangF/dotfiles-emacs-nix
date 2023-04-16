{ ... }: {
  programs.bash = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
    };
  };
  programs.zsh = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
    };
    # envExtra = ''
    #   MOZ_ENABLE_WAYLAND=1
    #   QT_QPA_PLATFORM=wayland
    # '';
  };
}
