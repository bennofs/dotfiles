{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:
let
  nativePkgs = import <nixpkgs> {};
  isCabalFile = name: _: nativePkgs.lib.hasSuffix ".cabal" name;
  expr = nativePkgs.stdenv.mkDerivation ({
    name = "project.nix";
    src = builtins.filterSource isCabalFile ./.;
    buildCommand = ''
      cp $src src -r --no-preserve=all
      cd src
      sed -e 's/^benchmark /executable /' -i *.cabal
      ${nativePkgs.haskellngPackages.cabal2nix}/bin/cabal2nix ./. > $out
    '';
  } // nativePkgs.lib.optionalAttrs nativePkgs.stdenv.isLinux {
    LANG = "en_US.UTF-8";
    LOCALE_ARCHIVE = "${nativePkgs.glibcLocales}/lib/locale/locale-archive";
  });
  h = nativePkgs.haskell.lib;
  hs = haskellPackages.override (old: {
    overrides = self: oldsuper: let super = oldsuper // (old.overrides or (_:_:{})) self oldsuper; in super // {
    };
  });
  pkg = hs.callPackage (import expr) {};
in pkg // { inherit hs expr; }
