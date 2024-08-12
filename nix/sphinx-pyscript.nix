{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, pyyaml
, sphinx
, furo
, myst-parser
, pytest
, sphinx-pytest
}:

buildPythonPackage rec {
  pname = "sphinx-pyscript";
  version = "0.1.0";
  pyproject = true;

  src = fetchPypi {
    pname = "sphinx_pyscript";
    inherit version;
    hash = "sha256-6NL/7E9g+ySAS35ZRvpOj9kj0DIowXz9hY8gLcCAOXI=";
  };

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    pyyaml
    sphinx
  ];

  passthru.optional-dependencies = {
    docs = [
      furo
      myst-parser
    ];
    testing = [
      pytest
      sphinx-pytest
    ];
  };

  pythonImportsCheck = [ "sphinx_pyscript" ];

  meta = with lib; {
    description = "A sphinx extension for adding pyscript to a page";
    homepage = "https://pypi.org/project/sphinx-pyscript";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
