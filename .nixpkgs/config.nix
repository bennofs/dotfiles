with (import <nixpkgs/lib>); with builtins; let
  inherit (builtins) getEnv;
  ignoredDirectories = [".git" ".hg" "build" "dist" ".nix"];
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
    haskellPackages.cabal-install patchutils haskellPackages.hscolour perl time linuxPackages.perf
    haskellPackages.hlint haskellPackages.profiteur
    gdb utillinuxCurses gettext bazaar
  ];
  setupEnv = ''
    ${concatStringsSep "\n" (map (x: "export ${x}=${getEnv x}") preservedEnvvars)};
    export PATH=/home/bin:$PATH
  '';
  localSourceFilter = path: type:
    let base = baseNameOf path;
    in type != "unknown" &&
         (  type != "directory"
         || !elem base ignoredDirectories
         && !hasPrefix "result" base
         );
  systemConf = import /etc/nixos/conf/nixpkgs.nix;
  haskellOverrides = self: super: {
    localPackage = s: self.callPackage (import s {}).expr;
  };
in systemConf // {
  allowBroken = true;

  haskellPackageOverrides = haskellOverrides;
  packageOverrides = pkgs: systemConf.packageOverrides pkgs // rec {
    localSource = builtins.filterSource localSourceFilter;
    nixUnstable = (import /data/code/nix/release.nix {}).build.${currentSystem};
    haskell = pkgs.haskell // {
      packages = mapAttrs
        (name: value: value.override { overrides = haskellOverrides; })
        pkgs.haskell.packages;
    };
    stdenv = pkgs.stdenv // rec {
      mkDerivation = args:
        let
          localSrc = (args ? src) && !isList args.src && !isFunction args.src && !isDerivation args.src;
          extraArgs = optionalAttrs localSrc localOverrides;
          baseEnv = args.passthru.env or args.env or result;
          localOverrides = {
            src = if !(args ? src) || args.src == null || isStorePath args.src
              then args.src
              else localSource args.src;
          };
          envArgs = {
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
          result = pkgs.stdenv.mkDerivation (recursiveUpdate args (extraArgs // envArgs));
        in result;
    };
  }; 
}

