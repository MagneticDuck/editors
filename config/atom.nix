{ nixpkgs ? import <nixpkgs> {}, tuckFile }:
with nixpkgs;

{
  generalPreferences = 
    tuckFile "config.cson" (writeText "pref" ''
      "*":
        welcome:
          showOnStartup: false
        core:
          autoHideMenuBar: true
          themes: [
            "one-dark-ui"
            "atom-dark-syntax"
          ]
        editor:
          tabLength: 2
          showIndentGuide: true
          softWrap: true
          softWrapAtPreferredLineLength: true
          scrollPastEnd: true;
          fontSize: 12
    '');
}
