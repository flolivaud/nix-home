{ pkgs, ... }: 

{
  home.packages = with pkgs; [
    gnome3.dconf-editor
  ];

  # user-theme
  home.file.".local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com".source = builtins.fetchzip {
    url = "https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v41.shell-extension.zip";
  };

  # permanent-notification
  home.file.".local/share/gnome-shell/extensions/permanent-notifications@bonzini.gnu.org".source = builtins.fetchGit {
    url = "https://github.com/bonzini/gnome-shell-permanent-notifications";
  };

  # dash-to-dock
  home.file.".local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com".source = builtins.fetchGit {
    url = "https://github.com/micheleg/dash-to-dock";
  };
  
  # topicons-plus
  home.file.".local/share/gnome-shell/extensions/TopIcons@phocean.net".source = builtins.fetchGit {
    url = "https://github.com/phocean/TopIcons-plus";
  };

  dconf.settings = {
      "org/gnome/terminal/legacy/keybindings" = {
        paste = "<Primary>v"; 
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        custom-theme-shrink = false;
        dash-max-icon-size = 32;
        dock-fixed = false;
        dock-position = "BOTTOM";
        extend-height = false;
        force-straight-corner = true;
        multi-monitor = true;
        preferred-monitor = 2;
        show-show-apps-button = false;
      };
      "org/gnome/shell/extensions/topicons" = {
        tray-pos = "right";
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Arc-Dark";
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "ubuntu-appindicators@ubuntu.com"
          "ubuntu-dock@ubuntu.com"
          "permanent-notifications@bonzini.gnu.org"
          "TopIcons@phocean.net"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "google-chrome.desktop"
          "slack.desktop"
          "teams.desktop"
          "org.gnome.Terminal.desktop"
        ];
      };
  };
}
