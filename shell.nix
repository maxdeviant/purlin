with import <nixpkgs> {};

let
  easy-ps = import (fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "bbef4245cd6810ea84e97a47c801947bfec9fadc";
    sha256 = "00764zbwhbn61jwb5px2syzi2f9djyl8fmbd2p8wma985af54iwx";
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
