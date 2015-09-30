{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;

let
  ##################################################################################
  # source directories

  tuckFile = name: file:
    runCommand "mover" {} ''
      mkdir -p $out
      cp -r "${file}" "$out/${name}"
    '';

  remoteSublime = import ./remote/sublime.nix {inherit nixpkgs tuckFile;};
  configSublime = import ./config/sublime.nix {inherit nixpkgs tuckFile;};

  ##################################################################################
  # launch scripts

  doCopyDir = debug: (dirAttrs: with dirAttrs; ''
    ${if debug then 
        "echo 'writing to ${output}'" 
      else "# debug disbled"}
    mkdir -p ${output}
    cp -r ${input}/* ${output}
    chmod -R +rw ${output}
  '');

  doClearRoot = debug: (root: ''
    ${if debug then 
        "echo 'clearing at ${root}'" 
      else "# debug disabled"}
    rm -rf ${root}/*
  '');

  # launch script that executes 'exec' after clearing directories clearRoots
  # and copying between the input / output directories in copyDirs
  launch = {name, debug ? true, exec, clearRoots ? [], copyDirs ? []}: 
    writeScriptBin name ''
      ${lib.concatStringsSep "\n" (map (doClearRoot debug) clearRoots)}
      ${lib.concatStringsSep "\n" (map (doCopyDir debug) copyDirs)}
      ${exec}
    '';

in

{
  sublime = 
    let
      packageDir = "$HOME/.config/sublime-text-3/Packages";
    in launch {
      name = "sublime";
      exec = "${nixpkgs.sublime3}/bin/sublime";
      clearRoots = [packageDir];
      copyDirs = [
        { input = remoteSublime.haxeSublimeBundle;
          output = packageDir; }
        { input = remoteSublime.spacegrayTheme;
          output = packageDir; }
        { input = configSublime.generalPreferences;
          output = packageDir + "/User"; }
      ];
    };
}

