with import <nixpkgs> { };
with python3Packages;

let userpath = import ../userpath;
in buildPythonPackage rec {
  pname = "pipx";
  version = "0.15.5.0";

  src = fetchFromGitHub {
    owner = "pipxproject";
    repo = pname;
    rev = version;
    sha256 = "13z032i8r9f6d09hssvyjpxjacb4wgms5bh2i37da2ili9bh72m6";
  };

  propagatedBuildInputs = [ userpath argcomplete packaging ];

  # avoid inconclusive venv assertion, see https://github.com/pipxproject/pipx/pull/477
  # remove after PR is merged
  postPatch = ''
    substituteInPlace tests/helpers.py \
      --replace 'assert getattr(sys, "base_prefix", sys.prefix) != sys.prefix, "Tests require venv"' ""
  '';

  checkInputs = [ pytestCheckHook ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  # disable tests, which require internet connection
  disabledTests = [
    "install"
    "inject"
    "ensure_null_pythonpath"
    "missing_interpreter"
    "cache"
    "internet"
    "runpip"
    "upgrade"
  ];
}
