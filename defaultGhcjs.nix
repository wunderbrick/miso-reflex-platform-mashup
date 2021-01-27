with (import (builtins.fetchGit {
    url = "https://github.com/wunderbrick/miso.git";
    rev = "149f7629b53f3140e31cf675e1ef08ebebddd8d5";
}) {});

{
  dev = pkgs.haskell.packages.ghc865.callCabal2nix "app" ./app { miso = miso-jsaddle; };
  release = pkgs.haskell.packages.ghcjs86.callCabal2nix "app" ./app {};
  inherit pkgs;
}
