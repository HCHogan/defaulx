{
  description = "defaulx: Neovim's default colorscheme, finished";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: {
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.defaulx;
      defaulx = pkgs.vimUtils.buildVimPlugin {
        pname = "defaulx";
        version = "0-unstable-${self.lastModifiedDate or "dirty"}";
        src = lib.fileset.toSource {
          root = ./.;
          fileset = lib.fileset.unions [./colors ./lua ./doc ./scripts ./tests ./LICENSE ./README.md];
        };
        # The precompiled highlights in lua/defaulx/compiled are committed so
        # non-Nix installs need no build step; here we prove they match the
        # sources, then run the test suite against the packaged tree.
        doCheck = true;
        nativeCheckInputs = [pkgs.neovim-unwrapped];
        checkPhase = ''
          runHook preCheck
          export HOME=$TMPDIR
          nvim --clean --headless -l scripts/build.lua --check
          nvim --clean --headless -l tests/run.lua
          runHook postCheck
        '';
        meta = {
          description = "Neovim's default colorscheme, finished";
          homepage = "https://github.com/HCHogan/defaulx";
          license = lib.licenses.mit;
        };
      };
    });

    overlays.default = final: prev: {
      vimPlugins = prev.vimPlugins // {defaulx = self.packages.${final.stdenv.hostPlatform.system}.defaulx;};
    };

    checks = forAllSystems (pkgs: {
      defaulx = self.packages.${pkgs.stdenv.hostPlatform.system}.defaulx;
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = [pkgs.neovim-unwrapped pkgs.stylua pkgs.selene pkgs.lua-language-server];
      };
    });

    formatter = forAllSystems (pkgs: pkgs.alejandra);
  };
}
