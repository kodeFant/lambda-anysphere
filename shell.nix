{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "lambda-anysphere-shell";
  src = ./.;
  packages = [ pkgs.nodejs pkgs.vsce pkgs.sops];
  shellHook = ''
    vsce 
  '';
}
