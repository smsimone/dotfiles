{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.stateVersion = "23.05";

  imports = [./programs/starship.nix];

  home.sessionVariables = rec {
    GOPATH = "/Users/simonemasoero/go";
    GOBIN = "/Users/simonemasoero/go/bin";
    EDITOR = "nvim";
    PATH = "$PATH:/Users/simonemasoero/fvm/default/bin:${GOBIN}";
  };

  programs = {
    home-manager.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName = "Simone Masoero";
      userEmail = "smsimone65@gmail.com";
      ignores = [".DS_Store"];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh = {
      enable = true;
      enableCompletion = true;

      shellAliases = {
        cd = "z";
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

      plugins = [
        {
          name = "fzf-tab.plugin.zsh";
          src =
            pkgs.fetchFromGitHub
            {
              owner = "Aloxaf";
              repo = "fzf-tab";
              rev = "b6e1b22458a131f835c6fe65bdb88eb45093d2d2";
              sha256 = "sha256-4A7zpaO1rNPvS0rrmmxg56rJGpZHnw/g+x5FJd0EshI=";
            };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "2d60a47cc407117815a1d7b331ef226aa400a344";
            sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
          };
        }
      ];

      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export PATH=/run/current-system/sw/bin:$PATH
        eval "$(fzf --zsh)"
      '';

      history = {
        size = 5000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };
  };
}
