{ stdenv, fetchurl, cmake, gcc, zlib, freetype, pcre, xz, x11, libXpm, giflib, libtiff, libjpeg_turbo, gsl, python, mesa, graphviz, libxml2, openssl, mysql, postgresql, sqlite, pkgconfig, fftw, doxygen }:

stdenv.mkDerivation rec {
  name = "rootsys-${version}";
  version = "6.04.02";
    
  src = fetchurl {
    url = "http://root.cern.ch/download/root_v${version}.source.tar.gz";
    sha256 = "16irxlpl5xirz4v5mnnfs672j6v1j21lmf4xjrjzabjrllvmwhc1";
  };

  # CMAKE_INSTALL_RPATH_USE_LINK_PATH is set to FALSE in
  # <rootsrc>/cmake/modules/RootBuildOptions.cmake.
  # This patch sets it to TRUE.
  patches = [
    ./cmake.patch
  ];

  enableParallelBuilding = true;

  # existence of configure hides cmake
  preConfigure = ''
    rm -f configure
  '';

  buildInputs = [ cmake gcc zlib freetype pcre xz x11 libXpm giflib libtiff libjpeg_turbo gsl python mesa graphviz libxml2 openssl mysql postgresql sqlite pkgconfig fftw doxygen ];

  cmakeFlags = ''
  -Dcxx11=ON
  -Dbuiltin_xrootd=ON
  -Dminuit2=ON
  -Dpython=ON
  -Dfftw3=ON
  -Dgdml=ON
  -Dgviz=ON
  -DMYSQL_CONFIG_EXECUTABLE="{mysql}/bin/mysql_config"
  '';

  meta = {
    homepage = "http://root.cern.ch/";
    description = "A data analysis framework";
    platforms = stdenv.lib.platforms.linux;
  };
  
}
  
