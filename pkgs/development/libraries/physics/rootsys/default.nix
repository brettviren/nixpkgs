{ stdenv, fetchurl, cmake }:

stdenv.mkDerivation rec {
  name = "rootsys-${version}";
  version = "6.04.02";
    
  src = fetchurl {
    url = "http://root.cern.ch/download/root_v${version}.source.tar.gz";
    sha256 = "16irxlpl5xirz4v5mnnfs672j6v1j21lmf4xjrjzabjrllvmwhc1";
  };


  
}
  
