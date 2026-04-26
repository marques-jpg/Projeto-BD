{
  description = "Direnv for Base de dados";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            docker
            docker-compose
            postgresql # Fornece o cliente psql localmente
          ];

          shellHook = ''
            echo "Direnv loaded successfully!"
          '';
        };
      }
    );
}
