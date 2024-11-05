{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    luarocks
    neofetch
    mkalias
    zoxide
    rbenv
    sqlc
    neovim

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

    #rustup
    go
    wget
    nmap
    lazygit
    eza
    bat
    tmux
    git

    obsidian
    lua
    yq
    fd
    delta
    postgresql
    alejandra
    rainfrog

    yazi
    dbeaver-bin
    spicetify-cli
  ];
}
