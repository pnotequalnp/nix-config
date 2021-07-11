{ modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot = {
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };

    initrd.kernelModules = [ "nvme" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DC0E-7E29";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  swapDevices = [{
    device = "/swapfile";
    size = 4096;
  }];
}
