{ pkgs ? import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/4d2b37a84fad1091b9de401eb450aae66f1a741e.tar.gz";
      sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";
    })
    { }
}:

with pkgs;

let
  mygitconfig = pkgs.writeTextFile {
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

  together = symlinkJoin {
    name = "konex-config-minimal";
    paths = [
      bash-completion
      bashInteractive
      cacert
      curl
      emacs-nox
      git
      glibcLocales
      gnumake
      less
      mygitconfig
    ];
    postBuild = "echo all configs/links in one destination";
  };
in
stdenv.mkDerivation {
  name = "konex-config-minimal";
  nativeBuildInputs = [ together ];
  LANG = "en_US.UTF-8";

  shellHook = ''
    mkdir -p $(pwd)/.trash_config
    export HOME=$(pwd)/.trash_config
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';
}
