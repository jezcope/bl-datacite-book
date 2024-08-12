{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, sphinx
}:

buildPythonPackage rec {
  pname = "sphinxext-rediraffe";
  version = "0.2.7";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ZR3L+uX/2p/9U037gCXzYSDl77bqGjP1QgAjhiufcl0=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    sphinx
  ];

  pythonImportsCheck = [ "sphinxext_rediraffe" ];

  meta = with lib; {
    description = "Sphinx Extension that redirects non-existent pages to working pages";
    homepage = "https://pypi.org/project/sphinxext-rediraffe";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
