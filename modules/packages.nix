{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowunfree = true;

  # Allow Flatpaks
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    # This automatically pulls in the default desktop portals for your DE
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
  
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    emacs
    pcmanfm
    firefox
    gnome-disk-utility
    keepassxc
    onlyoffice-desktopeditors
    screenfetch

    # Video Editor
    vokoscreen-ng
    mpv

    # File Reader
    mupdf
    
    # Email Client
    thunderbird

    # Clangd, gcc, and bear
    clang-tools
    gcc
    bear

    # Python
    pyright
    python3

    # Zip Files
    file-roller
    
    # Audio Controller Utilities
    wireplumber
    pavucontrol
    alsa-utils

    # Bluetooth Management Utilities
    bluez
    bluez-tools
    blueman
  ];
}
