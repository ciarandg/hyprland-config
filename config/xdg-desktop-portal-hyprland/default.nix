{
  pkgs,
  ...
}: {
  config = {
    home.packages = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
