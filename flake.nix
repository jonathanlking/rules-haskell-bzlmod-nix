{
  description = "A flake for setting up a dev shell with Bazel";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: {
    devShells.default = let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      buildInputs = [
        pkgs.bazel
        pkgs.nix
      ];
    };
  });
}
