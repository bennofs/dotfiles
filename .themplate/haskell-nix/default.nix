{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let

  util = import /home/expr/util.nix;

in

haskellPackages.callPackage (import ./{{$$project.name$$}}.nix) {
  cabal = util.cabalCustom haskellPackages (old : {
    src = 
      let 
        ignoredDirs = [ ".git" ".cabal-sandbox" "dist" ];
	ignoredFiles = [ "cabal.sandbox.config" ];
	
	predicate = path: type: 
	  !( type == "unknown" 
	  || type == "directory" && builtins.elem (baseNameOf path) ignoredDirs 
	  || type == "regular" && builtins.elem (baseNameOf path) ignoredFiles
	   );
      in builtins.filterSource predicate old.src;
  });
}

