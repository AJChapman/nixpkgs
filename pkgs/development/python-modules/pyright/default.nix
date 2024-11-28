{
  lib,
  stdenv,
  buildPythonPackage,
  setuptools,
  fetchFromGitHub,
  pythonOlder,
  gitUpdater,

  # propagates
  nodeenv,
  typing-extensions,
}:

buildPythonPackage rec {
  pname = "pyright";
  version = "1.1.389";

  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "RobertCraigie";
    repo = "pyright-python";
    rev = "refs/tags/v${version}";
    hash = "sha256-aX6+TcBC+8N1x0jNPOgmMUmhvSMOqfmWzZx/UPPvn+4=";
  };

  dependencies = [
    nodeenv
    typing-extensions
  ];

  build-system = [ setuptools ];

  enableParallelBuilding = true;

  doCheck = true;

  pythonImportsCheck = [ "pyright" ];

  passthru.updateScript = gitUpdater {
    rev-prefix = "v";
  };

  meta = {
    description = "A Python command-line wrapper over pyright, a static type checker for Python.";
    downloadPage = "https://github.com/RobertCraigie/pyright-python/releases/tag/v${version}";
    homepage = "https://pypi.org/project/pyright/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ alexchapman ];
  };
}
