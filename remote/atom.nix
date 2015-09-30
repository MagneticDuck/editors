{ nixpkgs ? import <nixpkgs> {}, tuckFile }:
with nixpkgs;

{
  ideHaskell = tuckFile "ide-haskell" (fetchFromGitHub {
    owner = "atom-haskell";
    repo = "ide-haskell";
    rev = "61bfedd8ba7f06c1ba5a4732a44a67b84bf2aafe";
    sha256 = "0six55bz5fvis1wkrbrdnfr6x3dfiqaf7q1k2vbx6g5sx09ld9h1";
  });

  vimMode = tuckFile "vim-mode" (fetchFromGitHub {
    owner = "atom";
    repo = "vim-mode";
    rev = "1d1dc2f478880f5d6e093e603b5f085de5c3a9ad";
    sha256 = "1xir3jzxh9h4dkxgf97yy7sv7is22qzwf4cvhn1a4az4dik0rnzx";
  });

  minimap = tuckFile "minimap" (fetchFromGitHub {
    owner = "atom-minimap";
    repo = "minimap";
    rev = "cf37f6041c2fb2a303ed43ec426223c2bb2a22a2";
    sha256 = "16b1vb48kax9w8cscpmlyfppqrlinzwsbqca0iipch7y3fahag98";
  });
}
