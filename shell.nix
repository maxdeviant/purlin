with import <nixpkgs> {};

let
  easy-ps = import (fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "0ba91d9aa9f7421f6bfe4895677159a8a999bf20";
    sha256 = "1baq7mmd3vjas87f0gzlq83n2l1h3dlqajjqr7fgaazpa9xgzs7q";
  }) {
    inherit pkgs;
  };
in
stdenv.mkDerivation {
  name = "purlin";

  buildInputs = [
    easy-ps.purs
    easy-ps.spago
    yarn
  ];
}
