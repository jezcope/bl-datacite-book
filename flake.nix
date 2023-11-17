{
  description =
    "A set of documented examples of tasks that can be performed using the DataCite API";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = inputs@{ flake-parts, nixpkgs, poetry2nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryEnv;
          myPython = mkPoetryEnv {
            projectDir = ./.;
            preferWheels = true;
          };
        in { devShells.default = myPython.env; };
    };
}
