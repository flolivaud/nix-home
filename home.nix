{ config, pkgs, ... }:

let

  # A random Nixpkgs revision *before* the default glibc
  # was switched to version 2.27.x.
  oldpkgsSrc = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "0252e6ca31c98182e841df494e6c9c4fb022c676";
    sha256 = "1sr5a11sb26rgs1hmlwv5bxynw2pl5w4h5ic0qv3p2ppcpmxwykz";
  };

  oldpkgs = import oldpkgsSrc {};

in
{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
      ./gnome.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.sessionVariables = {
    LOCALE_ARCHIVE_2_11 = "${oldpkgs.glibcLocales}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "olivaudf";
  home.homeDirectory = "/home/olivaudf";


  nixpkgs.config = { allowUnfree = true; allowBroken = true; };

  # Enable settings that make home manager work better on Linux distribs other than NixOS
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    tmux
    zsh
    fzf
    oh-my-zsh
    teams
    slack-dark
    powerline
    jetbrains.phpstorm
    php
    php73Packages.composer 
    remmina
    arc-theme
    flat-remix-icon-theme 
    parcellite
    ripgrep
    fd
    meld
    pssh
  ];

  programs.bash.enable = true;
  xsession.enable = true;
  xsession.windowManager.command = "true";
  xdg.enable = true;
  xdg.mime.enable = true;

  xdg.configFile."parcellite/parcelliterc".text = ''
    [rc]
	RCVersion=1
	use_copy=true
	use_primary=false
	synchronize=false
	save_history=true
	history_pos=false
	history_x=1
	history_y=1
	history_limit=25
	data_size=0
	item_size=5
	automatic_paste=true
	auto_key=true
	auto_mouse=false
	key_input=false
	restore_empty=false
	rc_edit=false
	type_search=false
	case_search=false
	ignore_whiteonly=false
	trim_wspace_begend=false
	trim_newline=false
	hyperlinks_only=false
	confirm_clear=true
	current_on_top=true
	single_line=true
	reverse_history=false
	item_length=50
	persistent_history=false
	persistent_separate=false
	persistent_on_top=false
	persistent_delim=\\n
	nonprint_disp=false
	ellipsize=2
	multi_user=false
	icon_name=parcellite
	menu_key=<Ctrl><Alt>P
	history_key=<Ctrl><Shift>V
	phistory_key=<Ctrl><Alt>X
	actions_key=<Ctrl><Alt>A 
  '';

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

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    extensions = [
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # grammarly
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "bcjindcccaagfpapjjmafapmmgkkhgoa" # json formatter
    ];
  };

  
  programs.gnome-terminal = {
    enable = true;
    profile = {
      "b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
        visibleName = "Florent";
        default = true;
        customCommand = "tmux";
      };
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userEmail = "florent.olivaud@amersports.com";
    userName = "Florent OLIVAUD";
    extraConfig = {
      credential.helper = "libsecret";
      merge."composer" = {
        name = "composer JSON file merge driver";
        driver = "~/.config/composer/vendor/bin/composer-git-merge-driver %O %A %B %L %P";
        recursive = "binary";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;

    localVariables = {
      DEFAULT_USER="$USER";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "sudo" "history-substring-search" ];
    };

    profileExtra = ''
      # Add bin in PATH if not already existing
      [[ ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$PATH:$HOME/bin"
      [[ ":$PATH:" != *":$HOME/Projects/ecom/magento2/tools/rm-scripts/bin:"* ]] && export PATH="$PATH:$HOME/Projects/ecom/magento2/tools/rm-scripts/bin"
    '';

    shellAliases = {
      fig = "docker-compose";
      up = "docker-compose up -d";
      run = "docker-compose run --rm";
      sandbox = "cd ~/Projects/sandbox";
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "a";
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;

    extraConfig = ''
	set-option -g default-shell $HOME/.nix-profile/bin/zsh
	set -g mouse on

	setw -g monitor-activity off
	set -g visual-activity off
	set -g xterm-keys on

	set-window-option -g automatic-rename off
	set -g allow-rename on

	bind m set -g mouse \; display "Mouse mode changed"
	bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
	bind Space next
	bind / split-window -h
	bind - split-window -v

	bind S set-window-option synchronize-panes \; display "Synchronize mode changed"

	# Color key:
	#   #2d2d2d Background
	#   #393939 Current Line
	#   #515151 Selection
	#   #cccccc Foreground
	#   #999999 Comment
	#   #f2777a Red
	#   #f99157 Orange
	#   #ffcc66 Yellow
	#   #99cc99 Green
	#   #66cccc Aqua
	#   #6699cc Blue
	#   #cc99cc Purple


	## set status bar
	set -g status-style bg=default
	setw -g window-status-current-style bg="#393939"
	setw -g window-status-current-style fg="#6699cc"

	## highlight active window
	setw -g window-style 'bg=#393939'
	setw -g window-active-style 'bg=#2d2d2d'
	setw -g pane-active-border-style ""

	## highlight activity in status bar
	setw -g window-status-activity-style fg="#66cccc"
	setw -g window-status-activity-style bg="#2d2d2d"

	## pane border and colors
	set -g pane-active-border-style bg=default
	set -g pane-active-border-style fg="#515151"
	set -g pane-border-style bg=default
	set -g pane-border-style fg="#515151"

	set -g clock-mode-colour "#6699cc"
	set -g clock-mode-style 24

	set -g message-style bg="#66cccc"
	set -g message-style fg="#000000"

	set -g message-command-style bg="#66cccc"
	set -g message-command-style fg="#000000"

	# message bar or "prompt"
	set -g message-style bg="#2d2d2d"
	set -g message-style fg="#cc99cc"

	set -g mode-style bg="#2d2d2d"
	set -g mode-style fg="#f99157"

	# right side of status bar holds "[host name] (date time)"
	set -g status-right-length 100
	set -g status-right-style fg=black
	set -g status-right-style bold
	set -g status-right '#[fg=#f99157,bg=#2d2d2d] %H:%M |#[fg=#6699cc] %y.%m.%d '

	# make background window look like white tab
	set-window-option -g window-status-style bg=default
	set-window-option -g window-status-style fg=white
	set-window-option -g window-status-style none
	set-window-option -g window-status-format '#[fg=#6699cc,bg=colour235] #I #[fg=#999999,bg=#2d2d2d] #W #[default]'

	# make foreground window look like bold yellow foreground tab
	set-window-option -g window-status-current-style none
	set-window-option -g window-status-current-format '#[fg=#f99157,bg=#2d2d2d] #I #[fg=#cccccc,bg=#393939] #W #[default]'

	# active terminal yellow border, non-active white
	set -g pane-border-style bg=default
	set -g pane-border-style fg="#999999"
	set -g pane-active-border-style fg="#f99157"
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;    
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
