{
  stdenv,
  cmake,
  pkg-config,
  meson,
  ninja,
  python3,
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

  postPatch = ''
    patchShebangs --build third_party/libei/proto/ei-scanner
  '';

  nativeBuildInputs = [
    cmake
    pkg-config
    meson
    ninja
    python3
    python3.pkgs.jinja2
  ];

  buildInputs = [
    qt6.qtbase
    wayland
    libxkbcommon
    libei
  ];

  dontWrapQtApps = true;

  cmakeFlags = [
    "-DBUILD_TESTING=OFF"
  ];
}
