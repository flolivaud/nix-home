{ pkgs, ... }:

{
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
      [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$PATH:$HOME/.local/bin"
	  [[ ":$PATH:" != *":$HOME/.npm-packages/bin:"* ]] && export PATH="$PATH:$HOME/.npm-packages/bin"
      source ~/.env
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
}
