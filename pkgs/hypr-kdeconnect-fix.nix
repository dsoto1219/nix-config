{
  stdenv,
  cmake,
  pkg-config,
  qt6,
  wayland,
  libxkbcommon,
  libei,
  src,
}:

stdenv.mkDerivation {
  pname = "hypr-kdeconnect-fix";
  version = "0.1.0";

  inherit src;

  nativeBuildInputs = [
    cmake
    pkg-config
    wayland
  ];

  buildInputs = [
    qt6.qtbase
    wayland
    libxkbcommon
    libei
  ];

  cmakeFlags = [
    "-DBUILD_TESTING=OFF"
  ];
}
