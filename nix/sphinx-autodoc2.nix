{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, astroid
, tomli
, typing-extensions
, typer
, furo
, myst-parser
, sphinx
, pytest
, pytest-cov
, pytest-regressions
}:

buildPythonPackage rec {
  pname = "sphinx-autodoc2";
  version = "0.5.0";
  pyproject = true;

  src = fetchPypi {
    pname = "sphinx_autodoc2";
    inherit version;
    hash = "sha256-fXYESqgdavdERwgBgraGjH6wZodO3INejd+BBzW2Vlo=";
  };

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    astroid
    tomli
    typing-extensions
  ];

  passthru.optional-dependencies = {
    cli = [
      typer
    ];
    docs = [
      furo
      myst-parser
      sphinx
    ];
    sphinx = [
      sphinx
    ];
    testing = [
      pytest
      pytest-cov
      pytest-regressions
      sphinx
    ];
  };

  pythonImportsCheck = [ "sphinx_autodoc2" ];

  meta = with lib; {
    description = "Analyse a python project and create documentation for it";
    homepage = "https://pypi.org/project/sphinx-autodoc2/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
