{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  users.users.simonemasoero = {
    name = "simonemasoero";
    home = "/Users/simonemasoero";
  };
  home-manager.backupFileExtension = "hm-backup";

  nix.extraOptions =
    ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  fonts.packages = [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  nix.settings = {
    auto-optimise-store = true;
    cores = 4;
    experimental-features = "nix-command flakes";
  };

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      powerBar
      hidePodcasts
      autoVolume
      history
    ];
    colorScheme = "mocha";
  };

  environment = {
    systemPackages = with pkgs; [
      yabai
      skhd
    ];

    shellAliases = {
      garbage = "sudo nix-collect-garbage --delete-older-than 14d";
      nopt = "sudo nix-store --optimise";
      neu = "sudo nix-env --upgrade";
      erebuild = "(cd ~/.config/nixos-config && $EDITOR .) && rebuild";
      rebuild = "darwin-rebuild switch --flake ~/.config/nixos-config";
      gw = "git worktree";
      jqq = "/Users/smaso/Development/jqq/jqq.rb";
      l = "ls -lha";
      fastlane = "bundle exec fastlane";
      flutter = "fvm flutter";
      lg = "lazygit";
      ls = "eza";
      ".." = "cd ..";
    };

    variables = {
      GOPATH = "/Users/simonemasoero/go";
      GOBIN = "/Users/simonemasoero/go/bin";
      EDITOR = "nvim";
    };
  };

  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  time.timeZone = "Europe/Rome";

  system = {
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
      pkgs.lib.mkForce ''
        # Set up applications
        echo "Setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "Copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

    keyboard.enableKeyMapping = true;

    defaults = {
      menuExtraClock.Show24Hour = true;
      menuExtraClock.ShowSeconds = false;

      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
      };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
      NSGlobalDomain = {
        # keyboard navigation in dialogs
        AppleKeyboardUIMode = 3;

        # disable press-and-hold for keys in favor of key repeat
        ApplePressAndHoldEnabled = false;

        # fast key repeat rate when hold
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };

      # killall Dock to make them have effect
      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
      dock = rec {
        autohide = false;
        magnification = true;
        # most recently used spaces
        mru-spaces = false;
        tilesize = 30;
        largesize = tilesize + 10;
        persistent-apps = [
          /Applications/Safari.app
          /Applications/Telegram.app
          /Applications/WhatsApp.app
          /System/Applications/Calendar.app
          /System/Applications/Mail.app
        ];
      };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
      finder = {
        # bottom status bar
        ShowStatusBar = true;
        ShowPathbar = true;

        # default to list view
        FXPreferredViewStyle = "Nlsv";
        # full path in window title
        _FXShowPosixPathInTitle = false;
      };
    };
  };
}
