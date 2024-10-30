{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [ pkgs.nodejs pkgs.vsce ];
  shellHook = ''
    vsce
  '';
}
