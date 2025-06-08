# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Enable flakes and nixf-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  }.;

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Swampert"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;
  services.xserver.videoDrivers = ["nvidia"];
  # Nvidia driver shenangians
  hardware.graphics.enable = true;
  hardware.nvidia = {
  	modesetting.enable = true;
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = true;
	nvidiaSettings = true;

	package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wryan = {
    isNormalUser = true;
    description = "William Ryan";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "audio"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Thunar
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable=true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  # ZSH
  programs.zsh = {
    enable=true;
  };

  # TY auto-login
  services.getty.autologinUser = "wryan";
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # GO XLR UTILITY
  services.goxlr-utility.enable = true;
  #Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  # GIT
  programs.git = {
    enable=true;
    config = {
      user.name = "William Ryan";
      user.mail = "wfryan@wpi.edu";
      init.defaultBranch = "main";
      pull.rebase = true;
      safe.directory = [
      "/etc/nixos"
      "/home/wryan/.config"
      ];
    };
  };
  # Steam
  programs.steam = {
  	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
};

  # System-level services and programs

  services.tumbler.enable = true;
  services.gvfs.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
 environment.systemPackages = with pkgs; [
    # Base system tools
  neovim
  # System-level tools
  git
  waybar
  rofi-wayland
  wl-clipboard
  hyprland
  firefox
  yazi
  xfce.thunar
  xfce.thunar-archive-plugin
  xfce.thunar-volman
  xfce.tumbler
  ffmpegthumbnailer
  gvfs
  zsh
  ffmpeg
  grimblast
  pyprland
  swww
  hyprlock
  nwg-dock-hyprland
  goxlr-utility
  clang-tools # Could be in home.nix too
  sqlite
  sqlite-utils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
