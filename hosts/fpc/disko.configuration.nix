# fpc - first pc
#
# Disko config for my First PC.
#
# > Btrfs with subvolumes <
#
# !!! Deprecated. Use only as example !!!

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
                mountOptions = ["umask=0077"];
              };
            };
            MAIN = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                mountpoint = "/";
                mountOptions = ["compress=zstd" "noatime"];
              };
            };
          };
        };
      };
      secondary = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            SECONDARY = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                mountpoint = "/data";
                mountOptions = ["compress=zstd" "noatime"];
              };
            };
          };
        };
      };
    };
  };
}
