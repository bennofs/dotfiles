{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:
let
  nativePkgs = import <nixpkgs> {};
  expr = nativePkgs.stdenv.mkDerivation ({
    name = "project.nix";
    src = ./.;
    buildCommand = ''
      ${nativePkgs.haskellPackages.cabal2nix}/bin/cabal2nix $src > $out
    '';
  } // nativePkgs.lib.optionalAttrs nativePkgs.stdenv.isLinux {
    LANG = "en_US.UTF-8";
    LOCALE_ARCHIVE = "${nativePkgs.glibcLocales}/lib/locale/locale-archive";
  });
  inherit (haskellPackages) lib;
  hs = haskellPackages.override (old: {
    overrides = self: oldsuper: let super = oldsuper // (old.overrides or (_:_:{})) self oldsuper; in super // {
    };
  });
  pkg = hs.callPackage (import expr) {};
in pkg // { inherit hs expr; }
