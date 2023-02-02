{
  description = "caps2esc - Transforming the most useless key ever in the most useful one.";

  #inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
  #inputs.nixpkgs.follows = "nixpkgs";
  inputs.caps2esc.url = git+https://gitlab.com/interception/linux/plugins/caps2esc.git;
  inputs.caps2esc.flake = false;

  outputs = { self, nixpkgs, caps2esc }: rec {

    packages.x86_64-linux.caps2esc = 
      let pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
      in pkgs.stdenv.mkDerivation {
        name = "caps2esc";
        src = caps2esc;
        nativeBuildInputs = [ pkgs.cmake ];
        buildInputs = [ pkgs.interception-tools ];
      };
    packages.x86_64-linux.default = packages.x86_64-linux.caps2esc;
  };
}
