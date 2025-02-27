# This flake was initially generated by fh, the CLI for FlakeHub (version 0.1.21)
{
  description = "LÖVE Game Development";
  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.*";
  };

  # Flake outputs that other flakes can use
  outputs = { self, flake-schemas, nixpkgs }:
    let
      # Helpers for producing system-specific outputs
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      # Schemas tell Nix about the structure of your flake's outputs
      schemas = flake-schemas.schemas;
      # Development environments
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            stdenv.cc.cc.lib
            curl
          ];
          # Pinned packages available in the environment
          packages = with pkgs; [
            act
            luajit
            lua-language-server
            miniserve
            nodejs_20
            p7zip
            tree
            unzip
            xmlstarlet
            zip
          ] ++ pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
            love
          ];
          shellHook = ''
            #Coerce LD_LIBRARY_PATH for lua-https
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
              pkgs.stdenv.cc.cc.lib
              pkgs.curl
            ]}:$LD_LIBRARY_PATH
          '';
        };
      });
    };
}
