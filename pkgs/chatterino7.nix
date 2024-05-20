{
  stdenv,
  lib,
  cmake,
  pkg-config,
  fetchFromGitHub,
  qt6,
  boost,
  openssl,
  libsecret,
}:
stdenv.mkDerivation rec {
  pname = "chatterino7";
  version = "7.5.1";
  src = fetchFromGitHub {
    owner = "SevenTV";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-R/y1dZo/wevBiatBD3GZ52QAZ4NK5uG7gGKUjCHBlMA=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = [cmake pkg-config qt6.wrapQtAppsHook];
  buildInputs =
    [
      qt6.qtbase
      qt6.qtsvg
      qt6.qtimageformats
      qt6.qttools
      qt6.qt5compat
      boost
      openssl
      libsecret
    ]
    ++ lib.optionals stdenv.isLinux [
      qt6.qtwayland
    ];
  cmakeFlags = ["-DBUILD_WITH_QT6=ON"];
  postInstall =
    lib.optionalString stdenv.isDarwin ''
      mkdir -p "$out/Applications"
      mv bin/chatterino.app "$out/Applications/"
    ''
    + ''
      mkdir -p $out/share/icons/hicolor/256x256/apps
      cp $src/resources/icon.png $out/share/icons/hicolor/256x256/apps/chatterino.png
    '';
  meta = with lib; {
    description = "A chat client for Twitch chat";
    mainProgram = "chatterino";
    longDescription = ''
      Chatterino is a chat client for Twitch chat. It aims to be an
      improved/extended version of the Twitch web chat. Chatterino 2 is
      the second installment of the Twitch chat client series
      "Chatterino".
      Chatterino7 is a fork of Chatterino 2. This fork mainly contains
      features that aren't accepted into Chatterino 2, most notably 7TV
      subscriber features.
    '';
    homepage = "https://github.com/SevenTV/chatterino7";
    changelog = "https://github.com/SevenTV/chatterino7/blob/master/CHANGELOG.md";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [rexim supa];
  };
}
