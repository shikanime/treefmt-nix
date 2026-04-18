{ mkFormatterModule, ... }:
{
  meta.maintainers = [ ];

  imports = [
    (mkFormatterModule {
      name = "dyff-json";
      package = "dyff";
      args = [
        "json"
      ];
      includes = [ "*.json" ];
    })
  ];
}
