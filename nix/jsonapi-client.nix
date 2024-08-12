{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, aiohttp
, jsonschema
, requests
}:

buildPythonPackage rec {
  pname = "jsonapi-client";
  version = "0.9.9";
  pyproject = true;

  src = fetchPypi {
    pname = "jsonapi_client";
    inherit version;
    hash = "sha256-NIu577X5hCH4Zfglja5ap4FVKlkQNR/1ePCEKS5lnNE=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    aiohttp
    jsonschema
    requests
  ];

  pythonImportsCheck = [ "jsonapi_client" ];

  meta = with lib; {
    description = "Comprehensive, yet easy-to-use, pythonic, ORM-like access to JSON API services";
    homepage = "https://pypi.org/project/jsonapi-client/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
