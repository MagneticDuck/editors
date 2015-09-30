{ nixpkgs ? import <nixpkgs> {}, tuckFile }:
with nixpkgs;

{
  generalPreferences = 
    tuckFile "Preferences.sublime-settings" (writeFile "pref" ''
      {
        "color_scheme": "Packages/Spacegray/base16-eighties.dark.tmTheme",
        "ignored_packages": [ ],
        "tab_size": 4,
        "translate_tabs_to_spaces": true,
        "theme": "Spacegray.sublime-theme",
        "color_scheme": "Packages/Theme - Spacegray/base16-ocean.dark.tmTheme",
        "word_wrap": true,
        "rulers": [80],
        "wrap_width": 80,
        "draw_centered": true
      }
    '';
}
