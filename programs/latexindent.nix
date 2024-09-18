{ lib, pkgs, config, ... }:
let
  cfg = config.programs.latexindent;
in
{
  meta.maintainers = [ ];

  options.programs.latexindent = {
    enable = lib.mkEnableOption "latexindent";
    package = lib.mkPackageOption pkgs "texliveMedium" { };
  };

  config = lib.mkIf cfg.enable {
    settings.formatter.latexindent = {
      command = lib.getExe' cfg.package "latexindent";
      includes = [
        ".github/workflows/*.yml"
        ".github/workflows/*.yaml"
      ];
    };
  };
}
