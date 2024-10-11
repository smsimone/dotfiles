{ pkgs, ... }:
{

  environment = {
    systemPackages = [
      # nix formatter
      pkgs.nixfmt-rfc-style
      pkgs.neovim
      pkgs.nil
      pkgs.yabai
      pkgs.skhd
      pkgs.alacritty
    ];

    variables = {
      GOPATH = "/Users/simonemasoero/go";
      GOBIN = "/Users/simonemasoero/go/bin";
    };

    shellAliases = {
      garbage = "sudo nix-collect-garbage --delete-older-than 14d";
      nopt = "sudo nix-store --optimise";
      neu = "sudo nix-env --upgrade";
      erebuild = "(cd ~/.config/nixos-config && $EDITOR .) && rebuild";
      rebuild = "darwin-rebuild switch --flake ~/.config/nixos-config";
      git-history = "git diff-tree --no-commit-id --name-only -r ";
      vim = "nvim";
      gw = "git worktree";
      jqq = "/Users/smaso/Development/jqq/jqq.rb";
      l = "ls -lha";
      fastlane = "bundle exec fastlane";
      flutter = "fvm flutter";
      lg = "lazygit";
    };
  };

  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
    yabai = {
      enable = true;
      extraConfig = ''
        # bsp, stack or float
        yabai -m config layout bsp

        yabai -m config window_placement second_child

        # padding
        yabai -m config window_gap 12
        yabai -m config top_padding 4
        yabai -m config bottom_padding 4
        yabai -m config right_padding 4
        yabai -m config left_padding 4

        # mouse settings
        yabai -m config mouse_follows_focus on
        yabai -m config mouse_modifier alt
        # left click and drag
        yabai -m config mouse_action1 move
        # right click and drag
        yabai -m config mouse_action2 resize
        yabai -m config mouse_drop_action swap

        # disable yabai for these apps
        yabai -m rule --add app="^Discord$" manage=off

      '';
    };
    skhd = {
      enable = true;
      skhdConfig = ''
        # start and stop
        ctrl + alt - q: yabai --stop-service
        ctrl + alt - s: yabai --start-service

        # changing window focus
        alt - j: yabai -m window --focus south
        alt - k: yabai -m window --focus north
        alt - h: yabai -m window --focus west
        alt - l: yabai -m window --focus east

        # rotate layout clockwise
        shift + alt - c: yabai -m space --rotate 270

        # rotate layout anti-clockwise
        shift + alt - a: yabai -m space --rotate 270

        # flip alone x-axis
        shift + alt - x: yabai -m space -- mirror x-axis

        # flip along y-axis
        shift + alt - y: yabai -m space --mirror y-axis

        # toggle window float
        shift + alt - t: yabai -m window --toggle float --grid 4:4:1:1:2:2

        # maximize a window
        shift + alt - m: yabai -m window --toggle zoom-fullscreen

        # reset window size
        shift + alt - e: yabai -m space --balance

        # swap windows
        shift + alt - h: yabai -m window --swap west
        shift + alt - j: yabai -m window --swap south
        shift + alt - k: yabai -m window --swap north
        shift + alt - l: yabai -m window --swap east

        # move window and split
        ctrl + alt - h: yabai -m window --warp west
        ctrl + alt - j: yabai -m window --warp south
        ctrl + alt - k: yabai -m window --warp north
        ctrl + alt - l: yabai -m window --warp east
      '';
    };
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh = {
      enable = true;
      variables = {
        EDITOR = "nvim";
      };
    };
  };

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

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
