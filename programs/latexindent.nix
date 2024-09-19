{ lib, pkgs, config, ... }:
let
  cfg = config.programs.latexindent;
  configFormat = pkgs.formats.yaml { };
  settingsFile = configFormat.generate "latexindentrc.yaml" cfg.settings;
in
{
  meta.maintainers = [ ];

  options.programs.latexindent = {
    enable = lib.mkEnableOption "latexindent";
    package = lib.mkPackageOption pkgs "texliveMedium" { };
    settings = lib.mkOption {
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    settings.formatter.latexindent = {
      command = lib.getExe' cfg.package "latexindent";
      options = lib.optionals (settingsFile != null) [
        "--local"
        (toString settingsFile)
      ];
      includes = [
        "*.tex"
        "*.sty"
        "*.cls"
        "*.bib"
        "*.cmh"
      ];
    };
  };
}
