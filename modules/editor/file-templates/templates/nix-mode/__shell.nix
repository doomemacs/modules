{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    ${0:`yas-selected-text`}
  ];
}