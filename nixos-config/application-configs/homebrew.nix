_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    taps = [
      "leoafarias/fvm"
    ];
    brews = [
      "fvm"
      "fzf"
      "zoxide"
      "rbenv"
      "mas"
      "go"
      "nmap"
      "wget"
      "git"
      "lazygit"
      "eza"
      "bat"
      "btop"
    ];
    masApps = {
      Telegram = 747648890;
      Whatsapp = 310633997;
    };
  };
}
