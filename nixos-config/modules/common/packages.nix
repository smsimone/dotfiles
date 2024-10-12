{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
}
