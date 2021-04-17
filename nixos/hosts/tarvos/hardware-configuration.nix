{ config, lib, pkgs, modulesPath, ... }:

let
  btrfsOptions = subvol: [ "subvol=${subvol}" "compress=zstd:1" "noatime" ];
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    supportedFilesystems = [ "btrfs" "zfs" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "sdhci_pci" ];
      kernelModules = [ ];
      luks.devices."root".device = "/dev/disk/by-uuid/6aaa69b3-946e-43ee-a8f9-0671902f379b";
    };
  };

  fileSystems = {
    "/boot" =
      { device = "/dev/disk/by-uuid/8430-323F";
        fsType = "vfat";
      };

    "/" =
      { device = "/dev/disk/by-uuid/7047afb5-2e26-4405-8c11-ae7f40fde54d";
        fsType = "btrfs";
        options = btrfsOptions "root";
      };

    "/home" =
      { device = "/dev/disk/by-uuid/7047afb5-2e26-4405-8c11-ae7f40fde54d";
        fsType = "btrfs";
        options = btrfsOptions "home";
      };

    "/nix" =
      { device = "/dev/disk/by-uuid/7047afb5-2e26-4405-8c11-ae7f40fde54d";
        fsType = "btrfs";
        options = btrfsOptions "nix";
      };

    "/persist" =
      { device = "/dev/disk/by-uuid/7047afb5-2e26-4405-8c11-ae7f40fde54d";
        fsType = "btrfs";
        options = btrfsOptions "persist";
      };

    "/var/log" =
      { device = "/dev/disk/by-uuid/7047afb5-2e26-4405-8c11-ae7f40fde54d";
        fsType = "btrfs";
        options = btrfsOptions "log";
        neededForBoot = true;
      };
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
