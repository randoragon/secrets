{
  description = "A command-line utility for managing encrypted directories of secrets";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = nixpkgs.legacyPackages;
      deps = pkgs: with pkgs; [
        coreutils
        ncurses
        gnupg
        gnused
        gnutar
      ];
      secrets = pkgs: pkgs.runCommand "secrets" {
        nativeBuildInputs = with pkgs; [ makeWrapper ];
      } ''
        mkdir -p "$out/bin"
        cp ${./secrets} "$out/bin/secrets"
        wrapProgram "$out/bin/secrets" \
          --prefix PATH : ${pkgs.lib.makeBinPath (deps pkgs)}
      '';
    in {
      packages = forAllSystems (system: {
        default = secrets pkgsFor.${system};
      });

      devShells = forAllSystems (system: {
        default = pkgsFor.${system}.mkShell {
          buildInputs = deps pkgsFor.${system};
        };
      });
    };
}
