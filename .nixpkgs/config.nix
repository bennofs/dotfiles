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
    "LANG"
    "NIX_SHELL_PROJECT"
    "TERM" "TERMINFO" "TERMINFO_DIRS"
  ];
  devPkgs = pkgs: with pkgs; [
    less git mercurial fish gitAndTools.hub utillinux bc man manpages
    nano openssh
  ];
  setupEnv = concatStringsSep "\n" (map (x: "export ${x}=${getEnv x}") preservedEnvvars);
  inNixShell = getEnv "IN_NIX_SHELL" == "1";
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
  packageOverrides = pkgs: systemConf.packageOverrides pkgs // rec {
    stdenv = pkgs.stdenv // {
      mkDerivation = args:
        let
          shellHook = old: ''
            ${old.shellHook or ""}
            ${setupEnv}
          '';
          noLocalSrc = !(args ? src) || pkgs.lib.isDerivation args.src;
          newArgs =
            if noLocalSrc then args else args // {
              src = builtins.filterSource localSourceFilter args.src;
              passthru.env = let oldEnv = args.passthru.env or result; in
               pkgs.lib.overrideDerivation oldEnv (envArgs: {
                buildInputs = devPkgs pkgs ++ oldEnv.buildInputs or [];
                shellHook = shellHook oldEnv;
               }
              ) // { build = result; };
            };
          result = pkgs.stdenv.mkDerivation newArgs;
        in result;
    };
    haskellngPackages = pkgs.haskellngPackages.override (old: { pkgs = old.pkgs // { inherit stdenv; }; });
  };
}

