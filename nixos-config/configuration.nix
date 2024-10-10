{pkgs,...}:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  environment.systemPackages = [ pkgs.nixfmt-rfc-style ];
}