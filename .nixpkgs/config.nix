with (import <nixpkgs/lib>); let
  inherit (builtins) getEnv;
  ignoredDirectories = [".git" ".hg" "build" "dist"];
  preservedEnvvars = [
    "CURL_CA_BUNDLE"
    "GIT_SSL_CAINFO"
    "OPENSS_X509_CERT_FILE"
    "NIX_REMOTE"
    "GTK_PATH"
    "GTK2_RC_FILES"
    "LANG" "LOCALE_ARCHIVE"
    "NIX_SHELL_PROJECT"
    "TERM" "TERMINFO" "TERMINFO_DIRS"
  ];
  devPkgs = pkgs: with pkgs; [
    less git mercurial fish gitAndTools.hub utillinux bc man manpages
    nano openssh haskellPackages.cabal-bounds neovim
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
          shellHook = old: ''
            ${old.shellHook or ""}
            ${setupEnv}
          '';
          noLocalSrc = !(args ? src) || pkgs.lib.isDerivation args.src;
          newArgs =
            if noLocalSrc then args else args // {
              src =
                if hasPrefix builtins.storeDir (builtins.toString args.src)
                  then args.src
                  else builtins.filterSource localSourceFilter args.src;
              passthru = (args.passthru or {}) // {
                oldEnv = args.passthru.env;
                env = let oldEnv = args.passthru.env or result; in
                 pkgs.lib.overrideDerivation oldEnv (envArgs: {
                  buildInputs = devPkgs pkgs ++ oldEnv.buildInputs or [];
                  src = null;
                  shellHook = shellHook oldEnv;
                 }
                 ) // {
                   build = result;
                   override = f: (result.override f).build;
                   env = result.env;
                 };
              };
            };
          result = pkgs.stdenv.mkDerivation newArgs;
        in result;
    };
    haskellPackages = pkgs.haskellPackages.override (old: { pkgs = old.pkgs // { inherit stdenv; }; });
    haskellngPackages = haskellPackages;
  };
}

