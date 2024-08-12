{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, sphinx
, furo
, pydata-sphinx-theme
, sphinx-rtd-theme
, sphinx-book-theme
}:

buildPythonPackage rec {
  pname = "sphinx-design2";
  version = "0.4.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ExXoKhqU44IwSPLjpVWyj+kwNuRz/MY2JcSS0sUY2X0=";
  };

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    sphinx
  ];

  passthru.optional-dependencies = {
    theme_furo = [
      furo
    ];
    theme_pydata = [
      pydata-sphinx-theme
    ];
    theme_rtd = [
      sphinx-rtd-theme
    ];
    theme_sbt = [
      sphinx-book-theme
    ];
  };

  pythonImportsCheck = [ "sphinx_design2" ];

  meta = with lib; {
    description = "A sphinx extension for designing beautiful, view size responsive web components";
    homepage = "https://pypi.org/project/sphinx-design2";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
