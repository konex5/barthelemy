# konex config

Use the following to build or enter the environment :

```bash
nix-build --dry-run --arg cppSupport true --arg pythonSupport true --arg haskellSupport true -A inputDerivation
nix-shell --arg cppSupport true --arg pythonSupport true --arg haskellSupport true
```

Use the following to use the software :

```bash
command -v emacs
printf %q $PATH
```

## build specific software

Example for emacs:

```bash
nix-build --dry-run --expr 'with import ( builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/4d2b37a84fad1091b9de401eb450aae66f1a741e.tar.gz"; sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";}) {}; callPackage ./emacs.nix { cppSupport = true; haskellSupport = true; latexSupport = true; pythonSupport = true; }'
```

Example for vscode:
```bash
nix-build --expr 'with import ( builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/4d2b37a84fad1091b9de401eb450aae66f1a741e.tar.gz"; sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";}) { config.allowUnfree = true; }; callPackage ./vscode.nix { cppSupport = true; haskellSupport = true; pythonSupport = true; }'
```
