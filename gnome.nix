{ pkgs, ... }: 

let 
  ge-dash-to-dock = pkgs.stdenv.mkDerivation {
    pname = "ge-dash-to-dock";
    version = "0.0.1";
    buildInputs = [
      pkgs.glib
    ];
    src = fetchGit {
  	  url = "https://github.com/micheleg/dash-to-dock";
      ref= "extensions.gnome.org-v65";
	};
    makeFlags = [ "INSTALLBASE=$(out)" ];
  };

  ge-user-theme = pkgs.stdenv.mkDerivation {
    pname = "ge-user-theme";
    version = "0.0.2";
    src = pkgs.fetchzip {
      url = "https://extensions.gnome.org/extension-data/user-theme%40gnome-shell-extensions.gcampax.github.com.v34.shell-extension.zip";
      sha256 = "1m218y7ypyz75fj1hkbqhkzvn23g8yl6bwhvwvq9iwcqszadxs4i";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out
      cp -r . $out
    '';
  };

  ge-notification-center = pkgs.stdenv.mkDerivation {
    pname = "ge-notification-center";
    version = "0.0.1";
    src = pkgs.fetchzip {
      url = "https://extensions.gnome.org/extension-data/notification-centerSelenium-H.v18.shell-extension.zip";
      sha256 = "0m6a4fvqdh0yjsm5lkfgvf95vhxba902ailp19a38ccjxw15nhkf";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out
      cp -r . $out
    '';
  };

  ge-screenshot-tool = pkgs.stdenv.mkDerivation {
    pname = "ge-screenshot-tool";
    version = "0.0.1";
    src = pkgs.fetchzip {
      url = "https://extensions.gnome.org/extension-data/gnome-shell-screenshotttll.de.v43.shell-extension.zip";
      sha256 = "0h54lgj4bzkafqgy940359pz7vbgj68paif8j9648d0x2r7y2dm4";
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

    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix-Blue-Dark";
    };
  }; 

  home.packages = with pkgs; [
    gnome3.dconf-editor
  ];

  # user-theme
  home.file.".local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com".source = ge-user-theme;

  # permanent-notification
  home.file.".local/share/gnome-shell/extensions/permanent-notifications@bonzini.gnu.org".source = builtins.fetchGit {
    url = "https://github.com/bonzini/gnome-shell-permanent-notifications";
  } + "/permanent-notifications@bonzini.gnu.org" ;

  # notification-center
  home.file.".local/share/gnome-shell/extensions/notification-center@Selenium-H".source = ge-notification-center;

  # dash-to-dock
  home.file.".local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com".source = ge-dash-to-dock + "/dash-to-dock@micxgx.gmail.com";

  #screenshot-tool
  home.file.".local/share/gnome-shell/extensions/gnome-shell-screenshot@ttll.de".source = ge-screenshot-tool;
  
  # topicons-plus
  home.file.".local/share/gnome-shell/extensions/TopIcons@phocean.net".source = builtins.fetchGit {
    url = "https://github.com/phocean/TopIcons-plus";
    ref = "v22";
  };
 
  # user-theme
 # home.file.".local/share/gnome-shell/extensions/TopIcons@phocean.net".source = builtins.fetchGit {
 #   url = "https://gitlab.gnome.org/GNOME/gnome-shell-extensions";
 # } + "/ extensions/user-theme" ;

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
