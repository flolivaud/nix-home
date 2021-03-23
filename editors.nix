{ pkgs, ... }:

{
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
