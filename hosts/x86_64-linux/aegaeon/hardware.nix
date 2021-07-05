{ config, lib, pkgs, modulesPath, ... }:

let btrfsOptions = subvol: [ "subvol=${subvol}" "compress=zstd:1" "noatime" ];
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    supportedFilesystems = [ "btrfs" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "sdhci_pci" ];
      kernelModules = [ ];
      luks.devices."root".device =
        "/dev/disk/by-uuid/2d808767-cd42-4348-ac34-c9b1e679b34e";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/306B-71B6";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/2d808767-cd42-4348-ac34-c9b1e679b34e";
      fsType = "btrfs";
      options = btrfsOptions "root";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/2d808767-cd42-4348-ac34-c9b1e679b34e";
      fsType = "btrfs";
      options = btrfsOptions "nix";
    };
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
