{
  lib,
  ...
}: {
  imports = [
    ./tuigreet
  ];

  options = {
    hyprland-config = {
      enable = lib.mkEnableOption {
        description = "Whether to enable hyprland-config";
        default = false;
      };
    };
  };
}
