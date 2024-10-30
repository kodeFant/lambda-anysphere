{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [ pkgs.nodejs pkgs.vsce pkgs.sops];
  shellHook = ''
    vsce --version
  '';
}
