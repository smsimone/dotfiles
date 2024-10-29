{...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 40;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red) ";
      };
    };
  };
}
