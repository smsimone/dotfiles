_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "wezterm"
    ];
    taps = [
      "leoafarias/fvm"
      "pkgxdev/made"
    ];
    brews = [
      "fvm"
      "mas"
      "flyctl"
      "pkgx"
    ];
    masApps = {
      Telegram = 747648890;
      Whatsapp = 310633997;
      Magnet = 441258766;
      Xcode = 497799835;
    };
  };
}
