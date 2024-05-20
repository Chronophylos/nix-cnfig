final: prev: {
  chatterino2 = prev.chatterino2.overrideAttrs (old: {
    version = "git";
    src = prev.fetchFromGitHub {
      owner = "SevenTV";
      repo = "chatterino7";
      rev = "a3ef8a138037924f9928f2d67cd96b1801062676";
      hash = "sha256-R/y1dZo/wevBiatBD3GZ52QAZ4NK5uG7gGKUjCHBlMA=";
      fetchSubmodules = true;
      deepClone = true;
    };
    nativeBuildInputs = old.nativeBuildInputs or [] ++ [prev.git];
  });
}
