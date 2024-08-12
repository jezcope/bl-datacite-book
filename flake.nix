{
  description = "A set of documented examples of tasks that can be performed using the DataCite API";

  inputs.pyproject-nix.url = "github:nix-community/pyproject.nix";
  inputs.pyproject-nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    { nixpkgs, pyproject-nix, ... }:
    let
      inherit (nixpkgs) lib;

      project = pyproject-nix.lib.project.loadPDMPyproject { projectRoot = ./.; };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "docutils" ];
      };

      python =
        let
          # TODO: maybe use pdm2nix to generate this instead
          packageOverrides = final: prev: {
            jsonapi-client = final.callPackage ./nix/jsonapi-client.nix { };
            myst-parser = final.callPackage ./nix/myst-parser.nix { };
            sphinx-autodoc2 = final.callPackage ./nix/sphinx-autodoc2.nix { };
            sphinx-design2 = final.callPackage ./nix/sphinx-design2.nix { };
            sphinx-pyscript = final.callPackage ./nix/sphinx-pyscript.nix { };
            sphinx-tippy = final.callPackage ./nix/sphinx-tippy.nix { };
            sphinxext-rediraffe = final.callPackage ./nix/sphinxext-rediraffe.nix { };
            docutils = final.callPackage ./nix/docutils.nix { };
          };
        in
        pkgs.python3.override {
          inherit packageOverrides;
          self = python;
        };

    in
    {
      devShells.x86_64-linux.default =
        let
          arg = project.renderers.withPackages { inherit python; };
          pythonEnv = python.withPackages arg;
        in
        pkgs.mkShell { packages = [ pythonEnv ]; };

      packages.x86_64-linux.default =
        let
          attrs = project.renderers.buildPythonPackage { inherit python; };
        in
        python.pkgs.buildPythonPackage attrs;
    };
}
