{ stdenv, fetchurl, alsaLib, boost, cairo, cmake, fftwSinglePrec, fltk
, libjack2, libsndfile, libXdmcp, readline, lv2, mesa, minixml, pkgconfig, zlib, xorg
}:

assert stdenv ? glibc;

stdenv.mkDerivation  rec {
  name = "yoshimi-${version}";
  version = "1.4.1";

  src = fetchurl {
    url = "mirror://sourceforge/yoshimi/${name}.tar.bz2";
    sha256 = "133sx42wb66g803pcrgdwph40wh94knvab3yfqkgm0001jv4v14y";
  };

  buildInputs = [
    alsaLib boost cairo fftwSinglePrec fltk libjack2 libsndfile libXdmcp readline lv2 mesa
    minixml zlib xorg.libpthreadstubs
  ];

  nativeBuildInputs = [ cmake pkgconfig ];

  preConfigure = "cd src";

  cmakeFlags = [ "-DFLTK_MATH_LIBRARY=${stdenv.glibc.out}/lib/libm.so -DCMAKE_INSTALL_DATAROOTDIR=$out" ];

  meta = with stdenv.lib; {
    description = "High quality software synthesizer based on ZynAddSubFX";
    longDescription = ''
      Yoshimi delivers the same synthesizer capabilities as
      ZynAddSubFX along with very good Jack and Alsa midi/audio
      functionality on Linux
    '';
    homepage = http://yoshimi.sourceforge.net;
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ maintainers.goibhniu ];
  };
}
