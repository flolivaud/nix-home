{ pkgs, ... }: 

let 
  ge-notification-center = pkgs.stdenv.mkDerivation {
    pname = "ge-notification-center";
    version = "0.0.2";
    src = pkgs.fetchzip {
      url = "https://extensions.gnome.org/extension-data/notification-centerSelenium-H.v20.shell-extension.zip";
      sha256 = "01f9pjny35cw62zrffhjhmsg863xz294d2hn5nqf7n3995qziz4m";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out
      cp -r . $out
    '';
  };

  ge-screenshot-tool = pkgs.stdenv.mkDerivation {
    pname = "ge-screenshot-tool";
    version = "0.0.2";
    src = pkgs.fetchzip {
      url = "https://extensions.gnome.org/extension-data/gnome-shell-screenshotttll.de.v56.shell-extension.zip";
      sha256 = "07bg3fgg9k7wqyd746w75a12vzm93dn4wr3l1czd6864f4pmalpd";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out
      cp -r . $out
    '';
  };
in
{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
  }; 

  home.packages = with pkgs; [
    gnome3.dconf-editor
  ];

  # permanent-notification
  home.file.".local/share/gnome-shell/extensions/permanent-notifications@bonzini.gnu.org".source = builtins.fetchGit {
    url = "https://github.com/bonzini/gnome-shell-permanent-notifications";
  } + "/permanent-notifications@bonzini.gnu.org" ;

  # notification-center
  home.file.".local/share/gnome-shell/extensions/notification-center@Selenium-H".source = ge-notification-center;

  #screenshot-tool
  home.file.".local/share/gnome-shell/extensions/gnome-shell-screenshot@ttll.de".source = ge-screenshot-tool;
  
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
      "org/gnome/shell/extensions/notification-center" = {
		autohide = 0;
		banner-pos = "center";
		indicator-pos = "right";
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "ubuntu-appindicators@ubuntu.com"
          "ubuntu-dock@ubuntu.com"
          "permanent-notifications@bonzini.gnu.org"
          "TopIcons@phocean.net"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "notification-center@Selenium-H"
          "gnome-shell-screenshot@ttll.de"
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
