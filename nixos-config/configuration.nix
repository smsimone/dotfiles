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

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
