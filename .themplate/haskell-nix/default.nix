{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:
haskellPackages.buildLocalCabal ./. "{{$$project.name$$}}"
