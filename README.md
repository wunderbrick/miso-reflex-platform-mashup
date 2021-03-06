# Miso Reflex Platform Mashup

### This is a very naive attempt to get a working Android app with Miso. The only reason I forked Miso was because it was the fastest, easist way for me to disable things in its miso.cabal while I was tinkering.

## FAQ

1. Q: Why is this project laid out in a weird way with one Cabal file and a huge library that contains frontend, backend, and common code?
   
   A: Millions of combinations of project layouts and hie-bios configurations were tested. This was the combo that gave us the best ghcide support and still left all the build tools working for live reload, usable JS, and Android builds. It's not so bad. The only place ghcide won't work is in the Main.hs files which you don't need to mess with anyway.

## Development

### Getting Started

This project skeleton was based off of this [document](https://github.com/reflex-frp/reflex-platform/blob/develop/docs/project-development.rst) which might be helpful to you.

### Develop with Editor Support in VSCode/Codium

Install the ghcide extension in VSCode/Codium. Make sure you have ghcide installed globally by Nix or available in the Nix infrastructure of this project and that it was built with the same version of GHC that Reflex is using (absolutely crucial). Per the VSCode/Codium extension page for ghcide you might need to follow instructions [here](https://github.com/hercules-ci/ghcide-nix). Once you have the extension and a ghcide binary you can run from the root of this project:

`nix-shell -A shells.ghc ./defaultGhc.nix --run 'codium'`

The hie.yaml and hie-bios.sh make sure ghcide can find everything it needs. hie-bios.sh must be executable:

`chmod +x hie-bios.sh`

### Develop with Live Reload (Almost)

`nix-shell -A shells.ghc ./defaultGhc.nix --run 'ghcid -W -c "cabal --project-file=cabal.project new-repl app" -T Frontend.Frontend.runApp'`

Go to http://localhost:3003/ in your browser. You still have to refresh the page on changes but you get automatic recompilation on saves.

### Compile With GHCJS for Web Deployment

Make sure baseURL in DomHelpers.hs is correct. You can then run:

`nix-build -A release ./defaultGhcjs.nix`

Just use the resulting files with your favorite server like you would any other HTML/JS/CSS.

### Build an Android APK

`nix-build -A android.app ./defaultGhc.nix -o result-android`

Make sure USB debugging is enabled on your device and then you can run the deployment script at:

`result-android/bin/deploy`
