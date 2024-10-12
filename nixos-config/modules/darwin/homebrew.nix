_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "alacritty"
    ];
    taps = [
      "leoafarias/fvm"
    ];
    brews = [
      "fvm"
      "mas"
    ];
    masApps = {
      Telegram = 747648890;
      Whatsapp = 310633997;
      Magnet = 441258766;
    };
  };
}
