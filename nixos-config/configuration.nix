{ pkgs, lib, ... }:
{
  users.users.simonemasoero = {
    name = "simonemasoero";
    home = "/Users/simonemasoero";
  };

  nix.extraOptions =
    ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  environment = {
    systemPackages = [
      # nix formatter
      pkgs.nixfmt-rfc-style
      pkgs.nil
      pkgs.yabai
      pkgs.skhd
      pkgs.alacritty
      pkgs.ripgrep

      # Rust toolchains
      pkgs.rustup
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
      gw = "git worktree";
      jqq = "/Users/smaso/Development/jqq/jqq.rb";
      l = "ls -lha";
      fastlane = "bundle exec fastlane";
      flutter = "fvm flutter";
      lg = "lazygit";
      ".." = "cd ..";
    };
  };

  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    nix-index.enable = true;
    zsh = {
      enable = true;
      variables = {
        EDITOR = "nvim";
      };
    };
  };

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
