{ pkgs ? import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/4d2b37a84fad1091b9de401eb450aae66f1a741e.tar.gz";
      sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";
    })
    { config.allowUnfree = true; }
, cppSupport ? true
, latexSupport ? true
, haskellSupport ? true
, pythonSupport ? true
}:

with pkgs;
let

  mygitconfig = writeTextFile {
    name = "mygitconfig";
    text = ''
      cat > ~/.gitconfig << EOF
          [init]
              defaultBranch = master
          [user]
              name = konex5
              email = fix@konex.dev
          [core]
              editor = emacs
      EOF'';
    executable = true;
    destination = "/bin/mygitconfig";
  };

  emacsExt = callPackage ./emacs.nix { };
  # vimExt = ;
  vscodeExt = callPackage ./vscode.nix { };
  together =
    symlinkJoin {
      name = "konex-config" + lib.optionalString (cppSupport) "-with-c"
        + lib.optionalString (haskellSupport) "-with-hs" + lib.optionalString (pythonSupport) "-with-py"
      ;
      paths = [
        bash-completion
        bashInteractive
        cacert
        curl
        git
        glibcLocales
        gnumake
        less
        mygitconfig
        nixpkgs-fmt
        # sublime
        # sublime-merge
        # typora
        emacsExt
        vscodeExt
      ] ++ lib.optionals (hostPlatform.isLinux) [ ]
      ++ lib.optionals (cppSupport) [ clang-tools cmakeCurses ]
      ++ lib.optionals (haskellSupport) [ ormolu ]
      ++ lib.optionals (pythonSupport) [ black ]
      ;
      postBuild = "echo all configs/links in one destination";
    };
in
stdenv.mkDerivation {
  name = "konex-config";
  nativeBuildInputs = [ together ];
  LANG = "en_US.UTF-8";

  shellHook = ''
    mkdir -p $(pwd)/.trash_config
    export HOME=$(pwd)/.trash_config
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';
}

