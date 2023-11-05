{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland-config;
in {
  config = lib.mkIf cfg.enable {
    programs.swaylock.settings = let
      grey = "282828";
      red = "fb4934";
      orange = "fe8019";
      blue = "83a598";
      blue2 = "458588";
    in {
      show-failed-attempts = true;
      indicator-radius = 75;
      font = "JetBrainsMono Nerd Font";

      key-hl-color = blue2;
      bs-hl-color = red;
      caps-lock-key-hl-color = red;
      caps-lock-bs-hl-color = red;

      text-color = blue;
      text-clear-color = orange;
      text-caps-lock-color = red;
      text-ver-color = blue;
      text-wrong-color = red;
      ring-color = blue;
      ring-clear-color = orange;
      ring-caps-lock-color = red;
      ring-ver-color = blue;
      ring-wrong-color = red;

      color = grey;
      inside-color = grey;
      line-color = grey;
      line-clear-color = grey;
      line-caps-lock-color = grey;
      line-ver-color = grey;
      line-wrong-color = grey;
      inside-clear-color = grey;
      inside-caps-lock-color = grey;
      inside-ver-color = grey;
      inside-wrong-color = grey;
      separator-color = grey;
    };
  };
}
