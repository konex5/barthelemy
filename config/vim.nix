{ symlinkJoin
, vim_configurable
, vimPlugins
}:

let
  vimExt = vim_configurable.customize {
    name = "vim";
    vimrcConfig = {
      customRC = ''
        set number
        set background=dark
        syntax enable
      '';
      packages.myVimPackage = with vimPlugins; {
        start = [ fugitive ]; #youcompleteme
      };
    };
  };
in
symlinkJoin {
  name = "konex-config-vim";
  paths = [ vimExt ];
  postBuild = "echo vim in one destination";
}
