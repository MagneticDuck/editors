{ nixpkgs ? import <nixpkgs> {}, tuckFile }:
with nixpkgs;

{
  generalPreferences = 
    tuckFile "Preferences.sublime-settings" (writeText "pref" ''
      {
        "theme": "Spacegray.sublime-theme",
        "color_scheme": "Packages/Theme - Spacegray/base16-ocean.dark.tmTheme",
        "draw_centered": true,

        "ignored_packages": [ ],

        "tab_size": 4,
        "rulers": [80],
        "translate_tabs_to_spaces": true,
        "word_wrap": true,
        "wrap_width": 80,

      }
    '');

  sublimeHaskell =
    tuckFile "SublimeHaskell.sublime-settings" (writeText "pref" ''
      {
        "enable_auto_build": false
      }
    '');
}
