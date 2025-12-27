{ vscode-with-extensions
, cppSupport ? false
, haskellSupport ? false
, pythonSupport ? false
}:


let
  vscodeExt = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions;
      [ bbenoist.nix eamodio.gitlens timonwong.shellcheck ]
      ++ lib.optionals (cppSupport) [ ms-vscode.cpptools ]
      ++ lib.optionals (pythonSupport) [
        ms-python.python
        ms-python.vscode-pylance
      ] ++ lib.optionals (haskellSupport) [
        haskell.haskell
        justusadam.language-haskell
      ] ++ vscode-utils.extensionsFromVscodeMarketplace ([{
        name = "emacs-mcx";
        publisher = "tuttieee";
        version = "0.41.2";
        sha256 = "LCnPyvl0YLPgIaBODwJGQ1Nubx1rhASexIKbuijJq1M=";
      }] ++ lib.optionals (cppSupport) [
        {
          name = "cmake";
          publisher = "twxs";
          version = "0.0.17";
          sha256 = "CFiva1AO/oHpszbpd7lLtDzbv1Yi55yQOQPP/kCTH4Y=";
        }
        {
          name = "cmake-tools";
          publisher = "ms-vscode";
          version = "1.10.5";
          sha256 = "T57uCK1rGe3dBnYbK7QhN2NG3NwTEZm0/EY8S1Pyf7I=";
        }
      ] ++ lib.optionals (pythonSupport) [{
        name = "restructuredtext";
        publisher = "lextudio";
        version = "135.0.0";
        sha256 = "yjPS9fZ628bfU34DsiUmZkOleRzW6EWY8DUjIU4wp9w=";
      }] ++ lib.optionals (haskellSupport) [ ]);
  };
in
symlinkJoin {
  name = "konex-config-vscode" + lib.optionalString (cppSupport) "-with-c"
    + lib.optionalString (haskellSupport) "-with-hs"
    + lib.optionalString (pythonSupport) "-with-py";
  paths = [ emacs-noxExt ];
  postBuild = "echo vscode in one destination";
}

