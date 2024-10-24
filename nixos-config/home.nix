{...}: {
  home.stateVersion = "23.05";

  home.sessionVariables = {
    GOPATH = "/Users/simonemasoero/go";
    GOBIN = "/Users/simonemasoero/go/bin";
    EDITOR = "nvim";
    PATH = "$PATH:/Users/simonemasoero/fvm/default/bin";
  };

  programs = {
    home-manager.enable = true;
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
  };
}
