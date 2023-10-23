{
  lib,
  ...
}: {
  imports = [
    ./hyprland
    ./hyprpaper
  ];

  options = {
    hyprland-config = {
      enable = lib.mkEnableOption {
        description = "Whether to enable hyprland-config";
        default = false;
      };
      monitors = lib.mkOption {
        description = "A list of monitor names";
        type = lib.types.listOf lib.types.str;
      };
    };
  };
}
