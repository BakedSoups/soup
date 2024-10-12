{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "uas" "usbhid" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
}
