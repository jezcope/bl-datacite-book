{
  description = "Description for the project";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = inputs@{ flake-parts, mach-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          python = mach-nix.lib.${system}.mkPython {
            requirements = builtins.readFile ./requirements.txt;
            providers = {
              webcolors = "sdist";
              jsonschema = "sdist";
            };
          };
        in {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          packages = {
            inherit python;
            default = python;
          };
          devShells.default = python.env;
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
