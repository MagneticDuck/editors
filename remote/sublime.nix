{ nixpkgs ? import <nixpkgs> {}, tuckFile }:
with nixpkgs;

{
  haxeSublimeBundle = tuckFile "Haxe" (fetchFromGitHub {
    owner = "clemos";
    repo = "haxe-sublime-bundle";
    rev = "c3b96f1c754ebc91bacc2926412042567fabbb5a";
    sha256 = "0faxybgzlr8v7xgrdxgljw31p9hxm2iq4sqa2h7x4dm98m226pr8";
  });

  spacegrayTheme = tuckFile "Theme - Spacegray" (fetchzip {
    url = "https://github.com/kkga/spacegray/archive/master.zip";
    sha256 = "129p3azqkvjva3pcq7wvbxwqgmrdpwrjxx283bfipqly1cg50cnq";
  });
}
