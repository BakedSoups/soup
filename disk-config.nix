# Example to create a bios compatible gpt partition
{lib, ...}: {
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            end = "-16G";
            content = {
              type = "btrfs";
              mountpoint = "/";
              mountOptions = ["noatime" "compress-force=zstd:3" "discard=async"];
              subvolumes = {
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = ["noatime" "compress-force=zstd:3" "discard=async"];
                };
              };
            };
          };
          plainSwap = {
            size = "100%";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true; # resume from hiberation from this device
            };
          };
        };
      };
    };
  };
}
