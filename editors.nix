{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
  	extensions = with pkgs.vscode-extensions; [
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-intelephense-client";
          publisher = "bmewburn";
          version = "1.5.4";
          sha256 = "11a83vh8bch2pdpqa53bksiqpfkcw7mhv698pa0ddkd9hqwz4zn2";
        }
        {
          name = "base16-themes";
          publisher = "AndrsDC";
          version = "1.4.5";
          sha256 = "0qxxhhjr2hj60spy7cv995m1px5z6m2syhxsnfl1wj2aqkwp32cs";
        }
        {
          name = "intellij-idea-keybindings";
          publisher = "k--kato";
          version = "0.2.41";
          sha256 = "1xz3s2vj0h0f4s2j60qysz6f82h97b4xb7q1y872kyrq46h31a0f";
        }
        {
          name = "Nix";
          publisher = "bbenoist";
          version = "1.0.1";
          sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
        }
      ];
    userSettings = {
      workbench.colorTheme = "Base16 Dark Eighties";
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set nowritebackup
      set noswapfile
      
      set tabstop=4
      set shiftwidth=4
      set expandtab

      filetype on
      filetype plugin on
      filetype indent on
      set autoindent
      set smartindent

      set number
    '';
  };
}