{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, beautifulsoup4
, jinja2
, requests
, sphinx
, furo
, myst-parser
, pytest
, pytest-regressions
, sphinx-pytest
}:

buildPythonPackage rec {
  pname = "sphinx-tippy";
  version = "0.4.3";
  pyproject = true;

  src = fetchPypi {
    pname = "sphinx_tippy";
    inherit version;
    hash = "sha256-JVq+4K7YCF/bmrDMWVzXpFdIrn9GYhVuUAoXo/c61j0=";
  };

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    beautifulsoup4
    jinja2
    requests
    sphinx
  ];

  passthru.optional-dependencies = {
    docs = [
      furo
      myst-parser
    ];
    testing = [
      pytest
      pytest-regressions
      sphinx-pytest
    ];
  };

  pythonImportsCheck = [ "sphinx_tippy" ];

  meta = with lib; {
    description = "Get rich tool tips in your sphinx documentation";
    homepage = "https://pypi.org/project/sphinx-tippy";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
