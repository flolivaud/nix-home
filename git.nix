{ pkgs, ...}:

{
   programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userEmail = "olivaud.florent@gmail.com";
    userName = "Florent OLIVAUD";
    extraConfig = {
      credential.helper = "libsecret";
      merge."composer" = {
        name = "composer JSON file merge driver";
        driver = "~/.config/composer/vendor/bin/composer-git-merge-driver %O %A %B %L %P";
        recursive = "binary";
      };
    };
    includes = [ { path = "~/.gitconfig.local"; } ];
  }; 
}
