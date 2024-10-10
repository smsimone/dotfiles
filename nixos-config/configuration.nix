{
  pkgs,
  lib,
  inputs,
}:

{
  programs = {
    bash.enable = false;
    zsh.enable = true;
  };
}
