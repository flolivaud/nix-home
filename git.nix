{ pkgs, ...}:

{
   programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userEmail = "olivaud.florent@gmail.com";
    userName = "Florent OLIVAUD";
    extraConfig = {
      credential.helper = "libsecret";
      commit.gpgsign = true;
      merge."composer" = {
        name = "composer JSON file merge driver";
        driver = "~/.config/composer/vendor/bin/composer-git-merge-driver %O %A %B %L %P";
        recursive = "binary";
      };
      pull = {
        rebase = true;
      };
      status = {
        submoduleSummary = true;
      };
      submodule = {
        recurse = true;
      };
      core = {
        editor = "vim";
      };
    };
    includes = [ { path = "~/.gitconfig.local"; } ];
  }; 
}
