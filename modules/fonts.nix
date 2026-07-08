# fonts.nix

{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Your Custom Programming and Status Fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono

    mononoki
    nerd-fonts.mononoki

    iosevka
    nerd-fonts.iosevka

    font-awesome

    # Crucial System-Wide Web and Document Fallbacks
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
  ];

  # Force Fontconfig to smoothly fall back when symbols or text go missing
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      sansSerif = [ "Liberation Sans" "Noto Sans CJK HK" ];
      serif = [ "Liberation Serif" ];
    };
  };
}