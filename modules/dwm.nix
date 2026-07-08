# dwm.nix

{ config, pkgs, ... }:

let
  # Compile your custom dwmblocks using your local source directory
  customDwmblocks = pkgs.dwmblocks.overrideAttrs (oldAttrs: {
    src = ./../dwmblocks-src;
  });
in
{
  # Enable X11 and the Display Manager
  services.xserver = {
    enable = true;

    # Configure your display manager
    displayManager.lightdm.enable = true;

    # Enable and configure DWM
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (oldAttrs : {
        # Point this to a local folder containing your custom config.h / config.def.h
        src = ./../dwm-src;
      });
    };

    # Setup your keyboard repeat rates and startup apps
    displayManager.sessionCommands = ''
      # Set terminal typing speed (delay 300ms, repeat rate 50Hz)
      ${pkgs.xset}/bin/xset r rate 300 50 &

      # Start DWM Status Bar
      ${customDwmblocks}/bin/dwmblocks &

      # Launch GUI applications in the Background
      ${pkgs.emacs}/bin/emacs --daemon

      # Background
      ${pkgs.feh}/bin/feh --randomize --bg-fill /home/jibran/Pictures/ &

      # Compositor
      ${pkgs.picom}/bin/picom --config /home/jibran/Git/desktop/picom/picom.conf &
    '';
  };

  environment.sessionVariables = {
  QT_QPA_PLATFORMTHEME = "qt5ct"; # Change to "qt6ct" if using Qt6
  };

  # Essential tools that complement dwm
  environment.systemPackages = with pkgs; [
    dmenu
    alacritty
    feh
    numlockx
    customDwmblocks
    picom
    lxappearance
    pavucontrol
    acpi
    xset
    libsForQt5.qt5ct
  ];
}
