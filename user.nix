{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  users.users.alex.packages = with pkgs; [
    alejandra
    bun
    delve
    digital
    discord
    gcc
    gdb
    gnumake
    go
    gopls
    libreoffice
    lutris
    neovim
    nil
    obs-studio
    obsidian
    python3
    ruff
    snapper
    sqlite
    sshfs
    tectonic
    temurin-bin-17
    uv
    vscodium
    zoom-us
    cowsay
    jujutsu
  ];
  # programs.vscode.enable = true;

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true;
    gamescopeSession.enable = false;
  };

  services.snapper.configs = {
    home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = ["alex"];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = 5;
      TIMELINE_LIMIT_DAILY = 7;
    };
  };
  services.snapper.snapshotInterval = "*:0/5";

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["audio" "video" "wheel" "dialout"];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.backupFileExtension = ".hm-bak";
  home-manager.users.alex = import ./home.nix {inherit inputs pkgs lib;};
}
