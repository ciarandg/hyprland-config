{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland-config;
in {
  config = lib.mkIf cfg.enable {
    security.pam.services.swaylock = {};
  };
}
