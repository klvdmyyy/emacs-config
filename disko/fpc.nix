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
        device = "/dev/disk/by-diskseq/1";
        content = {
          # TODO: Configuration of disk
        };
      };
      secondary = {
        type = "disk";
        device = "/dev/disk/by-diskseq/2";
        content = {
          # TODO: Configuration of disk
        };
      };
    };
  };
}
