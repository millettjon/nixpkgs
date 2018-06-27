{ stdenv, fetchgit, python2, pkgconfig, usbmuxd, glib, libgcrypt,
  libtasn1, libplist, readline, libusbmuxd, openssl, autoconf, automake, libtool }:

stdenv.mkDerivation rec {
  name = "libimobiledevice-1.2.1";

  nativeBuildInputs = [ python2 libplist.swig pkgconfig autoconf automake libtool];
  buildInputs = [ readline ];
  propagatedBuildInputs = [ libusbmuxd glib libgcrypt libtasn1 libplist openssl ];

  passthru.swig = libplist.swig;

  preConfigure = ''
    patchShebangs autogen.sh
    ./autogen.sh
  '';

  src = fetchgit {
    url = "https://github.com/libimobiledevice/libimobiledevice.git";
    rev = "26373b334889f5ae2e2737ff447eb25b1700fa2f";
    sha256 = "03rkgidfjhzz0r0daa5hrg4g76nkj87fasrvnxi6nykyqjpmg05y";
  };

  meta = {
    homepage = http://www.libimobiledevice.org;
    description = "A software library that talks the protocols to support iPhone®, iPod Touch® and iPad® devices on Linux";
    longDescription = ''
      libimobiledevice is a software library that talks the protocols to support
      iPhone®, iPod Touch® and iPad® devices on Linux. Unlike other projects, it
      does not depend on using any existing proprietary libraries and does not
      require jailbreaking. It allows other software to easily access the
      device's filesystem, retrieve information about the device and it's
      internals, backup/restore the device, manage SpringBoard® icons, manage
      installed applications, retrieve addressbook/calendars/notes and bookmarks
      and synchronize music and video to the device. The library is in
      development since August 2007 with the goal to bring support for these
      devices to the Linux Desktop.'';
    inherit (usbmuxd.meta) platforms maintainers;
  };
}
