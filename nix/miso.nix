{ mkDerivation, aeson, base, bytestring, containers, fetchgit
, http-api-data, http-types, lucid, network-uri, servant
, servant-lucid, stdenv, text, transformers, vector
, quickcheck-instances, jsaddle, file-embed
}:
mkDerivation {
  pname = "miso";
  version = "1.7.1.0";
  src = fetchgit {
    url = "https://github.com/wunderbrick/miso.git";
    sha256 = "111n4vbxid2ca21al133328x8fg0xafg8vi9h8g9f5mxhjccmayk";
    rev = "149f7629b53f3140e31cf675e1ef08ebebddd8d5";
    fetchSubmodules = true;
  };
  isLibrary = true;
  #isExecutable = true;
  libraryHaskellDepends = [
    aeson base bytestring containers http-api-data http-types lucid
    network-uri servant servant-lucid text transformers vector
    quickcheck-instances jsaddle file-embed
  ];
  homepage = "http://github.com/dmjio/miso";
  description = "A tasty Haskell front-end framework";
  license = stdenv.lib.licenses.bsd3;
}
