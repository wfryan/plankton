# ~/nixos-config/users/wryan.nix
{ config, pkgs, ... }:


{
  home.stateVersion = "25.05";
  home.username = "wryan";
  home.homeDirectory = "/home/wryan";

  # All your user packages, moved from configuration.nix
  home.packages = with pkgs; [
    # Neovim setup
    ripgrep
    fd
    clang-tools
    cmake
    nodejs
    pyright
    typescript-language-server
    jdt-language-server
    lua-language-server
    rust-analyzer
    go
    zig

    # Terminals and Shell utils
    ghostty
    kitty
    starship
    nitch

    # GUI Apps and utils
    discord
    libsForQt5.qt5ct
    zathura

    # Other CLI tools
    wget
    python3
    rustup
    cargo
    rustc
    sqlite-utils
  ];

  # Application settings managed by Home Manager
  programs.git = {
    enable = true;
    userName = "William Ryan";
    userEmail = "wfryan@wpi.edu";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # To make life easy, alias `nvim` to our wrapped version
  programs.zsh.shellAliases = {
    nvim = "nvim-final";
    vim = "nvim-final";
  };

  # Your Neovim dotfiles symlink
  home.xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/plankton/nvim";
    recursive = true;
  };
}
