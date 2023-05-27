{ pkgs, ... }: {
  home.packages = with pkgs; [
    pantalaimon
  ];

  services.pantalaimon-headless.instances.me.enabled = true;
}
