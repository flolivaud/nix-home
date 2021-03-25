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
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in
{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
      ./gnome.nix
      ./terminal.nix
      ./editors.nix
      ./git.nix
      ./go.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.username = "$USER";
  home.homeDirectory = "/home/$USER";

  home.stateVersion = "20.09";

  home.sessionVariables = {
    LOCALE_ARCHIVE_2_11 = "${oldpkgs.glibcLocales}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    EDITOR = "vim";
  };

  nixpkgs.config = { allowUnfree = true; allowBroken = true; };

  # Enable settings that make home manager work better on Linux distribs other than NixOS
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    slack-dark
    powerline
    remmina
    arc-theme
    flat-remix-icon-theme 
    parcellite
    ripgrep
    fd
    meld
    vlc
    unstable.glab
    nodePackages.npm
    gnomeExtensions.dash-to-dock
    gnome3.gnome-shell-extensions
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
	item_size=500
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


  programs.chromium = {
    enable = true;
    package = unstable.google-chrome;
    extensions = [
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # grammarly
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "bcjindcccaagfpapjjmafapmmgkkhgoa" # json formatter
    ];
  };
}
