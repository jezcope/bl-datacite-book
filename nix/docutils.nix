{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "docutils";
  version = "0.20.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-8IpOJ2w6FYOobc4+NKuj/gTQK7ot1R7RYQYkToqSPjs=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "docutils" ];

  meta = with lib; {
    description = "Docutils -- Python Documentation Utilities";
    homepage = "https://pypi.org/project/docutils";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
  };
}
