{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: {
    overlays.default = _: prev': let
      prev =
        prev'.extend
        <| prev'.lib.composeManyExtensions [
          (import ./overlays/gdb.nix)
          inputs.neovim-nightly.overlays.default
          (_: prev: {
            leftdockpopulate = prev.callPackage ./scripts/eww/leftdockpopulate.nix {
              data = builtins.readFile ./config/eww/data/leftdock.json;
            };
            ewwinit = prev.callPackage ./scripts/eww/ewwinit.nix {};
          })
        ];
    in {
      myDotfiles = prev.callPackage ./packages/dotfiles.nix {src = self;};
      myEwwScripts = prev.symlinkJoin {
        name = "EWW scripts";
        paths = [
          prev.leftdockpopulate
          prev.ewwinit
        ];
      };
      wallpapers = prev.callPackage ./packages/wallpapers.nix {};
      neovim = prev.callPackage ./packages/neovim.nix {
        initLua = ./config/neovim/init.lua;
        myConfig = ./config/neovim/myConfig;
        snippets = ./config/neovim/snippets;
        scripts =
          ./scripts/neovim
          |> builtins.readDir
          |> prev.lib.filterAttrs (_: v: v == "regular")
          |> prev.lib.mapAttrsToList (k: _: prev.callPackage "${self}/scripts/neovim/${k}" {});
      };
    };

    nixosModules.default = nixpkgs.lib.modules.importApply ./modules/rofi.nix inputs;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
}
