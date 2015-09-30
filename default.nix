{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;

let
  tuckFile = name: file:
    runCommand "mover" {} ''
      mkdir -p $out
      cp -r "${file}" "$out/${name}"
    '';

  remoteSublime = import ./remote/sublime.nix {inherit nixpkgs tuckFile;};
  configSublime = import ./confi/sublime.nix {inherit nixpkgs tuckFile;};

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
    rm -rf ${root}
  '');

  launch = {name, debug ? true, exec, clearRoots ? [], copyDirs ? []}: 
    writeScriptBin name ''
      ${lib.concatStringsSep "\n" (map (doClearRoot debug) clearRoots)}
      ${lib.concatStringsSep "\n" (map (doCopyDir debug) copyDirs)}
      ${exec}
    '';

in

{
  sublime = launch {
    name = "sublime";
    exec = "${nixpkgs.sublime3}/bin/sublime";
    clearRoots = ["./test"];
    copyDirs = [
      { input = remoteSublime.haxeSublimeBundle;
        output = "./test"; }
    ];
  };
}

