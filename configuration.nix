{
  modulesPath,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs;
    map lib.lowPrio [
      tree
      firefox
      git
      wget
    ];

  services.tailscale.enable = true;
  programs.kdeconnect.enable = true;
  hardware.graphics.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.desktopManager.plasma6.enable = true;
  systemd.services.display-manager.restartIfChanged = false;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  services.resolved.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings.IPv6.Enabled = true;
    settings.Settings.AutoConnect = true;
  };

  services.smartd.enable = true;
  services.btrfs.autoScrub.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;

  security.sudo-rs.enable = true;
  security.sudo.enable = false;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    trusted-users = ["root" "@wheel"];
  };
  nixpkgs.config = {allowUnfree = true;};

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINimJXI8WOYUMwfAcGyKB9EYtuaClNjeEH4ZTQl9tuUY"
  ];
  programs.ssh.askPassword = lib.mkForce "true";

  networking.hostName = "soup";
  system.stateVersion = "24.05";
}
