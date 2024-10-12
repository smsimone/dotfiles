{
  pkgs,
  ...
}:
{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    neofetch
    mkalias
    zoxide
    rbenv

    # archives
    zip
    xz
    unzip

    # utils
    jq
    fzf
    ripgrep

    # networking
    nmap
    dnsutils

    # activity metrics
    iftop
    btop

    nil # nix linter
    rustup
    go
    wget
    nmap
    lazygit
    eza
    bat
    tmux
    git

    alacritty
  ];

  home.sessionVariables = {
    GOPATH = "/Users/simonemasoero/go";
    GOBIN = "/Users/simonemasoero/go/bin";
    EDITOR = "nvim";
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Simone Masoero";
      userEmail = "smsimone65@gmail.com";
      ignores = [ ".DS_Store" ];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };
  };
}
