{ nixpkgs ? import <nixpkgs> {}, tuckFile }:
with nixpkgs;

{
  haxeSublimeBundle = tuckFile "Haxe" (fetchFromGitHub {
    owner = "clemos";
    repo = "haxe-sublime-bundle";
    rev = "c3b96f1c754ebc91bacc2926412042567fabbb5a";
    sha256 = "0faxybgzlr8v7xgrdxgljw31p9hxm2iq4sqa2h7x4dm98m226pr8";
  });

  sublimeHaskell = tuckFile "SublimeHaskell" (fetchFromGitHub {
    owner = "SublimeHaskell";
    repo = "SublimeHaskell";
    rev = "c1f92945bfbc3b52c719d4cb8f26c1eb4fd5b27b";
    sha256 = "14xbdb2k9nac9mga1djncv44y10dqnbmpb9f869nc9g9qwywgfrv";
  });

  spacegrayTheme = tuckFile "Theme - Spacegray" (fetchzip {
    url = "https://github.com/kkga/spacegray/archive/master.zip";
    sha256 = "129p3azqkvjva3pcq7wvbxwqgmrdpwrjxx283bfipqly1cg50cnq";
  });
}
