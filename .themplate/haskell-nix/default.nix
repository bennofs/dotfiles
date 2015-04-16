{ haskellngPackages ? (import <nixpkgs> {}).haskellngPackages }:
let
  nativePkgs = import <nixpkgs> {};
  cabalExpr = nativePkgs.stdenv.mkDerivation ({
    name = "project.nix";
    buildCommand = ''
      ${nativePkgs.haskellngPackages.cabal2nix}/bin/cabal2nix ${./.} > $out
    '';
  } // nativePkgs.lib.optionalAttrs nativePkgs.stdenv.isLinux {
    LANG = "en_US.UTF-8";
    LOCALE_ARCHIVE = "${nativePkgs.glibcLocales}/lib/locale/locale-archive";
  });
  hs = haskellngPackages.override (old: {
    overrides = self: oldsuper: let super = oldsuper // (old.overrides or (_:_:{})) self oldsuper; in super // {
    };
  });
  pkg = hs.callPackage (import cabalExpr) {};
in pkg.env // { override = f: (pkg.override f).env; build = pkg; }
