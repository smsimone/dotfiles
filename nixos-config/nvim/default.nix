{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    #./plugins/treesitter.nix
    #./plugins/mini.nix
  ];

  programs.nixvim = {
    enable = true;

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          style = "mocha";
        };
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };

    opts = {
      number = true;
      showmode = false;
      clipboard = {
        register = "unnamedplus";
      };

      ignorecase = true;
      smartcase = true;

    };
  };
}
