{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot =
  { loader =
    {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "net.ifnames=0" ];
    blacklistedKernelModules = [ "nouveau" ];
  };

  networking =
  { hostName = "monika";
    hostId = "a77d8928";
  };

  i18n =
  { consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Jakarta";

  environment.systemPackages =
    with pkgs; [
    curl vim chromium firefox git zsh maim slop mpv neofetch
    libreoffice-fresh ntfs3g exfat steam tdesktop emacs
    python3 python36Packages.pip python36Packages.docker_compose arandr
    udisks2 gvfs pcmanfm xarchiver zip unzip iw xterm xorg.xbacklight pass
    gnupg xlockmore go dia thunderbird wineFull winetricks steam gcc gnumake
    gnome3.adwaita-icon-theme gnome3.gnome_themes_standard lxappearance-gtk3
  ];

  fonts =
  { enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts =
      with pkgs; [
      go-font google-fonts vistafonts
    ];
  };

  hardware =
  { bluetooth.enable = true;
    opengl.driSupport32Bit = true;
  };


  programs =
  { bash.enableCompletion = true;
    mtr.enable = true;
    gnupg.agent =
    { enable = true;
      enableSSHSupport = true;
    };
  };

  services =
  { acpid.enable = true;
    upower.enable = true;

    xserver =
    { enable = true;
      layout = "us";
      libinput.enable = true;
      videoDrivers = [ "intel" ];
      windowManager.awesome.enable = true;
      displayManager.slim.enable = true;
    };

    syncthing =
    { enable = true;
      user = "yuki";
      group = "users";
      dataDir = "/home/yuki/.config/syncthing";
      openDefaultPorts = true;
    };

    locate.enable = true;

    emacs.install = true;
  };

  virtualisation.docker.enable = true;

  users =
  { defaultUserShell = pkgs.zsh;
    extraUsers.yuki =
    { isNormalUser = true;
      home = "/home/yuki";
      extraGroups = [ "wheel" "docker" "audio" "video" ];
    };
  };

  nix =
  { useSandbox = true;
    buildCores = 4;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "17.09";
}
