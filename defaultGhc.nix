{ reflex-platform ? import ./nix/reflex-platform.nix {} 
}:

reflex-platform.project ({ pkgs, ... }: {
  
  withHoogle = true;
  useWarp = true;

  packages = {
    app = ./app;
  };

  android.app = {
    executableName = "frontend";
    applicationId = "org.example.App";
    displayName = "Miso";
  };

  shells = {
    ghc = [
      "app"
      ];
    ghcjs = [ # GHCJS called by Reflex tooling will just fail with no C compiler found for platform.
      "app" 
    ];
  };

  # addition tools outside of Haskell packages you want to include in the shell, e.g., Codium or MongoDB
  shellToolOverrides = self: super: {
    # e.g.
    # inherit (pkgs) mongodb;
  };

  # Haskell packages to override
  overrides = self: super: rec {
    misoFromCabal2nix = self.callPackage ./nix/miso.nix {};
    miso = pkgs.haskell.lib.overrideCabal misoFromCabal2nix (drv: {
      configureFlags = [ "-fjsaddle" ];
    });
  };
})
