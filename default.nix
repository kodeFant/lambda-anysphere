{ pkgs ? import <nixpkgs> { } }:
let
  packageJson = builtins.fromJSON (builtins.readFile ./package.json);
in
pkgs.stdenv.mkDerivation {
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
}
