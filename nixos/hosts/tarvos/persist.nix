{ config, lib, pkgs, ... }:

{
  boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
    mkdir -p /mnt

    mount -o subvol=/ /dev/mapper/root /mnt

    btrfs subvolume list -o /mnt/root |
    cut -f9 -d' ' |
    while read subvolume; do
      echo "deleting /$subvolume subvolume..."
      btrfs subvolume delete "/mnt/$subvolume"
    done &&
    echo "deleting /root subvolume..." &&
    btrfs subvolume delete /mnt/root

    echo "restoring blank /root subvolume..."
    btrfs subvolume snapshot /mnt/blank /mnt/root

    umount /mnt
  '';

  services = {
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/" ];
    };

    snapper = let
      conf = ''
        TIMELINE_CREATE=yes
        TIMELINE_CLEANUP=yes
        TIMELINE_LIMIT_DAILY="7"
        TIMELINE_LIMIT_WEEKLY="1"
        TIMELINE_LIMIT_MONTHLY="1"
        TIMELINE_LIMIT_YEARLY="1"
      '';
    in {
      snapshotInterval = "daily";
      cleanupInterval = "daily";
      configs = {
        home = {
          subvolume = "/home";
          extraConfig = conf;
        };
        persist = {
          subvolume = "/persist";
          extraConfig = conf;
        };
      };
    };
  };

  environment.etc = {
    "NetworkManager/system-connections".source =
      "/persist/etc/NetworkManager/system-connections";
    "ssh/ssh_host_ed25519_key".source = "/persist/etc/ssh/ssh_host_ed25519_key";
    "ssh/ssh_host_ed25519_key.pub".source =
      "/persist/etc/ssh/ssh_host_ed25519_key.pub";
    "ssh/ssh_host_rsa_key".source = "/persist/etc/ssh/ssh_host_rsa_key";
    "ssh/ssh_host_rsa_key.pub".source = "/persist/etc/ssh/ssh_host_rsa_key.pub";
    NIXOS.source = "/persist/etc/NIXOS";
    adjtime.source = "/persist/etc/adjtime";
    machine-id.source = "/persist/etc/machine-id";
    shadow.source = "/persist/etc/shadow";
  };

  systemd.tmpfiles.rules = [
    "L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth"
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/docker - - - - /persist/var/lib/docker"
    "L /var/lib/sops - - - - /persist/var/lib/sops"
  ];
}
