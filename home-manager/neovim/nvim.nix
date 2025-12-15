{
  inputs,
  self,
  config,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim.enable = true;
  programs.nixvim.imports = [ ./nixvim.nix ];
}
