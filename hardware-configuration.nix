{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot =
  { initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "usbhid"
    "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
    kernelModules = [ "kvm-intel" ];
    supportedFilesystems = [ "zfs" ];
  };

  fileSystems = {
    "/" =
    { device = "zmonika/root/nixos";
      fsType = "zfs";
    };

    "/zmonika" =
    { device = "zmonika";
      fsType = "zfs";
    };

    "/home" =
    { device = "zmonika/data/home";
      fsType = "zfs";
    };

    "/boot" =
    { device = "/dev/disk/by-uuid/61A1-7C4E";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = "powersave";
}
