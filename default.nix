{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;

let
  ##################################################################################
  # source directories

  tuckFile = name: file:
    runCommand "tucked-dir" {} ''
      mkdir -p $out
      cp -r "${file}" "$out/${name}"
    '';

  remoteSublime = import ./remote/sublime.nix {inherit nixpkgs tuckFile;};
  configSublime = import ./config/sublime.nix {inherit nixpkgs tuckFile;};

  remoteAtom = import ./remote/atom.nix {inherit nixpkgs tuckFile;};
  configAtom = import ./config/atom.nix {inherit nixpkgs tuckFile;};

  ##################################################################################
  # launch scripts

  doCopyDir = debug: (dirAttrs: with dirAttrs; ''
    ${if debug then 
        "echo 'writing to ${output}'" 
      else "# debug disbled"}
    mkdir -p ${output}
    cp -r ${input}/* ${output}/
    chmod -R +rw ${output}
  '');

  doClearRoot = debug: (root: ''
    ${if debug then 
        "echo 'clearing at ${root}'" 
      else "# debug disabled"}
    if [ -d ${root} ]
    then rm -rf ${root}/*
    else rm -f ${root}
    fi
  '');

  # launch script that executes 'exec' after clearing directories clearRoots
  # and copying between the input / output directories in copyDirs
  launch = {name, debug ? true, exec, clearRoots ? [], copyDirs ? []}: 
    writeScriptBin name ''
      ${lib.concatStringsSep "\n" (map (doClearRoot debug) clearRoots)}
      ${lib.concatStringsSep "\n" (map (doCopyDir debug) copyDirs)}
      ${exec} "$@"
    '';

in

{
  ##################################################################################
  # I use sublime text for haxe and haskell
  sublime = 
    let
      packageDir = "$HOME/.config/sublime-text-3/Packages";
    in launch {
      name = "sublime";
      exec = "${nixpkgs.sublime3}/bin/sublime";
      clearRoots = [packageDir (packageDir + "/User")];
      copyDirs = [
        { input = remoteSublime.haxeSublimeBundle;
          output = packageDir; }
        { input = remoteSublime.spacegrayTheme;
          output = packageDir; }
        { input = configSublime.generalPreferences;
          output = packageDir + "/User"; }
      ];
    };

  ##################################################################################
  # I use atom for some other things
  atom = 
    let
      atomDir = "$HOME/.atom";
      packageDir = atomDir + "/dev/packages";
    in launch {
      name = "atom";
      exec = "${nixpkgs.atom}/bin/atom";
      clearRoots = 
        [ packageDir (atomDir + "/config.cson")
          (atomDir + "/packages")
        ];
      copyDirs = [
        { input = configAtom.generalPreferences;
          output = atomDir; }
        # { input = remoteAtom.ideHaskell;
          # output = packageDir; }
        # { input = remoteAtom.vimMode;
          # output = packageDir; }
        # { input = remoteAtom.minimap;
          # output = packageDir; }
      ];
    };
}

