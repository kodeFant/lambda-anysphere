{
  description = "Lambda Anysphere";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems }:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: 
      let 
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        default = pkgs.callPackage ./default.nix { inherit pkgs; };
      });
      devShells = forEachSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        default = pkgs.callPackage ./shell.nix { inherit pkgs; };
      });
    };
}
