{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    disko,
    home-manager,
    # nixos-facter-modules,
    ...
  }: {
    # Use this for all other targets
    # nixos-anywhere --flake .#generic-nixos-facter --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
    nixosConfigurations = {
      soup = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          ./user.nix
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
  };
}
