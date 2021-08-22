{ config, lib, pkgs, modulesPath, ... }:

let
  byUuid = id: "/dev/disk/by-uuid/${id}";
  bootId = "8430-323F";
  luksId = "6aaa69b3-946e-43ee-a8f9-0671902f379b";
  btrfsId = "7047afb5-2e26-4405-8c11-ae7f40fde54d";
  btrfsOptions = [ "compress=zstd:1" "noatime" ];
  btrfsSubvol = subvol: extraOptions: {
    device = byUuid btrfsId;
    fsType = "btrfs";
    options = [ "subvol=${subvol}" ] ++ btrfsOptions;
  } // extraOptions;
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    supportedFilesystems = [ "btrfs" "zfs" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "sdhci_pci" ];
      kernelModules = [ ];
      luks.devices."root".device = byUuid luksId;
    };
  };

  fileSystems = {
    "/boot" = {
      device = byUuid bootId;
      fsType = "vfat";
    };

    "/main" = {
      device = byUuid btrfsId;
      fsType = "btrfs";
      options = btrfsOptions;
    };

    "/" = btrfsSubvol "root" { };

    "/home" = btrfsSubvol "home" { };

    "/nix" = btrfsSubvol "nix" { };

    "/persist" = btrfsSubvol "persist" { };

    "/etc/secret.d" = btrfsSubvol "secrets" { };

    "/steam" = btrfsSubvol "steam" { };

    "/var/log" = btrfsSubvol "log" { neededForBoot = true; };

    "/var/lib/tailscale" = btrfsSubvol "tailscale" { neededForBoot = true; };
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
