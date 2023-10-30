{
  description =
    "A set of documented examples of tasks that can be performed using the DataCite API";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = inputs@{ flake-parts, mach-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          mach-nix' = mach-nix.lib.${system};
          python = mach-nix'.mkPython {
            requirements = (builtins.readFile ./requirements.txt) + "pip";
            providers = {
              webcolors = "sdist";
              jsonschema = "sdist";
            };
          };
        in {
          packages = {
            inherit python;
            default = python;
          };

          devShells.default = python.env;
        };
    };
}
