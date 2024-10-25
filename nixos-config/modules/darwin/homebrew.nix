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
      # "sanesidebuttons"
      "swiftformat-for-xcode"
    ];
    taps = [
      "leoafarias/fvm"
      "pkgxdev/made"
    ];
    brews = [
      "fvm"
      "mas"
      "pkgx"
    ];
    masApps = {
      Telegram = 747648890;
      Whatsapp = 310633997;
      Magnet = 441258766;
      Xcode = 497799835;
      WindowsApp = 1295203466;
      DevCleaner = 1388020431;
    };
  };
}
