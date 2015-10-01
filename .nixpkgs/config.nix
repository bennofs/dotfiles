with (import <nixpkgs/lib>); with builtins; let
  inherit (builtins) getEnv;
  ignoredDirectories = [".git" ".hg" "build" "dist"];
  preservedEnvvars = [
    "CURL_CA_BUNDLE"
    "GIT_SSL_CAINFO"
    "OPENSS_X509_CERT_FILE"
    "NIX_REMOTE" "NIX_PATH" "EDITOR"
    "GTK_PATH"
    "GTK2_RC_FILES"
    "LANG" "LOCALE_ARCHIVE"
    "NIX_SHELL_PROJECT"
    "TERM" "TERMINFO" "TERMINFO_DIRS"
  ];
  devPkgs = pkgs: with pkgs; [
    less git mercurial fish gitAndTools.hub utillinux bc man manpages
    nano openssh haskellPackages.cabal-bounds vimHugeX nix haskellPackages.ghc-mod
    haskellPackages.cabal-install
  ];
  setupEnv = concatStringsSep "\n" (map (x: "export ${x}=${getEnv x}") preservedEnvvars);
  localSourceFilter = path: type:
    let base = baseNameOf path;
    in type != "unknown" &&
         (  type != "directory"
         || !elem base ignoredDirectories
         && !hasPrefix "result" base
         );
  systemConf = import /etc/nixos/conf/nixpkgs.nix;
in systemConf // {
  allowBroken = true;

  haskellPackageOverrides = self: super: {
    localPackage = s: self.callPackage (import s {}).expr;
  };

  packageOverrides = pkgs: systemConf.packageOverrides pkgs // rec {
    stdenv = pkgs.stdenv // rec {
      mkDerivation = args:
        let
          localSrc = (args ? src) && !isDerivation args.src;
          extraArgs = optionalAttrs localSrc localOverrides;
          filterLocal = x: if isStorePath x then x else filterSource localSourceFilter x;
          baseEnv = args.passthru.env or args.env or result;
          localOverrides = { 
            src = filterLocal args.src;
            passthru.env = overrideDerivation baseEnv (baseArgs: {
              buildInputs = devPkgs pkgs ++ baseArgs.buildInputs or [];
              src = null;
              shellHook = ''
                ${baseArgs.shellHook or ""}
                ${setupEnv}
              '';
            });
            passthru.baseEnv = baseEnv;
          };
          result = pkgs.stdenv.mkDerivation (recursiveUpdate args extraArgs);
        in result;
    };
  }; 
}

