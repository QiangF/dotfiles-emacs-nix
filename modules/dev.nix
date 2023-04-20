{ pkgs, ... }: {
  programs = {
    direnv.enable = true;
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
    cachix
    nodePackages.bash-language-server
  ];
}
