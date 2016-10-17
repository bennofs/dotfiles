with (import <nixpkgs> {}); with lib; with builtins;

let
  units = import ./units.nix;
  mkName = x: if length (splitString "." x) == 1 then x + ".service" else x;
  makeUnit = name: unit: '' echo '${unit}' > "${mkName name}"'';
  linkUnit = name: _   : '' ln -s $out/${mkName name} $out/default.target.wants/${mkName name} '';
in stdenv.mkDerivation {
  name = "services";
  buildCommand = ''
    mkdir -p $out/default.target.wants
    cd $out
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList makeUnit units)};
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList linkUnit units)};
  '';
}
