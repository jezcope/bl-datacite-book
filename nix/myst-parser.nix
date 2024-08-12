{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, docutils
, jinja2
, markdown-it-py
, mdit-py-plugins
, pyyaml
, sphinx
, pre-commit
, linkify-it-py
, ipython
, pydata-sphinx-theme
, sphinx-autodoc2
, sphinx-book-theme
, sphinx-copybutton
, sphinx-design2
, sphinx-pyscript
, sphinx-tippy
, sphinx-togglebutton
, sphinxext-opengraph
, sphinxext-rediraffe
, beautifulsoup4
, coverage
, pytest
, pytest-cov
, pytest-param-files
, pytest-regressions
, sphinx-pytest
, pygments
}:

buildPythonPackage rec {
  pname = "myst-parser";
  version = "2.0.0";
  pyproject = true;

  src = fetchPypi {
    pname = "myst_parser";
    inherit version;
    hash = "sha256-6pKaZ6agsWg82+GbjS5yTNdkP4qj57sY3WW+rDSDvq0=";
  };

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    docutils
    jinja2
    markdown-it-py
    mdit-py-plugins
    pyyaml
    sphinx
  ];

  passthru.optional-dependencies = {
    code_style = [
      pre-commit
    ];
    linkify = [
      linkify-it-py
    ];
    rtd = [
      ipython
      pydata-sphinx-theme
      sphinx-autodoc2
      sphinx-book-theme
      sphinx-copybutton
      sphinx-design2
      sphinx-pyscript
      sphinx-tippy
      sphinx-togglebutton
      sphinxext-opengraph
      sphinxext-rediraffe
    ];
    testing = [
      beautifulsoup4
      coverage
      pytest
      pytest-cov
      pytest-param-files
      pytest-regressions
      sphinx-pytest
    ];
    testing-docutils = [
      pygments
      pytest
      pytest-param-files
    ];
  };

  pythonImportsCheck = [ "myst_parser" ];

  meta = with lib; {
    description = "An extended [CommonMark](https://spec.commonmark.org/) compliant parser";
    homepage = "https://pypi.org/project/myst-parser/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
