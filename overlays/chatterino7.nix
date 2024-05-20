final: prev: {
  chatterino2 = prev.chatterino2.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "SevenTV";
      repo = "chatterino7";
      rev = "a3ef8a138037924f9928f2d67cd96b1801062676";
      hash = "";
    };
  });
}
