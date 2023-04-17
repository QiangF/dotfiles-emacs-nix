{
  description = "PurplGs dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv/latest";
  };

  outputs = inputs:
    {
      imports = [
      ];

      defaultPackage.x86_64-linux = inputs.home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = {
        desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/common.nix
            ./hosts/desktop.nix
          ];
        };
        framework = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/common.nix
            ./hosts/framework.nix
          ];
        };
        work = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/common.nix
            ./hosts/work.nix
          ];
        };
      };
    };
}
