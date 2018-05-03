{ mkDerivation, alex, array, base, bytestring, Cabal, cgi
, containers, directory, exceptions, filepath, happy, haskeline
, HTF, httpd-shed, HUnit, json, mtl, network, network-uri
, old-locale, parallel, pretty, process, random, stdenv, terminfo
, time, time-compat, unix, utf8-string
}:
mkDerivation {
  pname = "gf";
  version = "3.9";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    array base bytestring cgi containers directory exceptions filepath
    haskeline httpd-shed json mtl network network-uri old-locale
    parallel pretty process random terminfo time time-compat unix
    utf8-string
  ];
  libraryToolDepends = [ alex happy ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [
    base Cabal directory filepath HTF HUnit process
  ];
  doCheck = false;
  postPatch = ''
    sed -i "s|\"-s\"|\"\"|" ./Setup.hs
    sed -i "s|numJobs (bf bi)++||" ./Setup.hs
  '';
  preBuild = ''export LD_LIBRARY_PATH=`pwd`/dist/build:$LD_LIBRARY_PATH'';
  homepage = "http://www.grammaticalframework.org/";
  description = "Grammatical Framework";
  license = "unknown";
}
