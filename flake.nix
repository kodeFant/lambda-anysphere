{
  description = "Lambda Anysphere";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs = { self, nixpkgs, systems, flake-compat }:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: 
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        packageJson = builtins.fromJSON (builtins.readFile ./package.json);
      in
      {
        default = pkgs.stdenv.mkDerivation {
            name = packageJson.name;
            version = packageJson.version;
            description = packageJson.description;
            src = ./.;
            buildInputs = [ pkgs.vsce pkgs.nodejs ];
            buildPhase = ''
              vsce package
            '';
            installPhase = ''
              # The first *.vsix file in the current directory
              vsix_file=$(ls -1 *.vsix | head -n 1)
              mkdir -p $out
              cp $vsix_file $out/lambda-anysphere.vsix
            '';
            meta = with pkgs.lib; {
              description = "Lambda Anysphere";
              homepage = "https://github.com/anysphere/lambda";
              license = licenses.mit;
            };
          };
      });
      devShells = forEachSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        default = pkgs.mkShell {
          name = "lambda-anysphere-shell";
          src = ./.;
          packages = [ pkgs.nodejs pkgs.vsce pkgs.sops];
          shellHook = ''
            echo ""
            echo "-----------------------------------------------------------------"
            echo ""
            echo "  lambda-anysphere development shell"
            echo ""
            echo "  Commands:"
            echo "       vsce           Help for vsce"
            echo "       vsce package   Package the extension to a .vsix file"
            echo "       vsce publish   Publish the extension to the marketplace"
            echo "       nix build      Build the extension with nix"
            echo ""
            echo "-----------------------------------------------------------------"
            echo ""
          '';
        };
      });
    };
}
