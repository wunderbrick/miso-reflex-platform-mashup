f:
let
  reflex-platform = builtins.fetchGit {
     url = "https://github.com/reflex-frp/reflex-platform.git";
     rev = "27a7851a780ff21472d85f9a02fb84635ef9027a";
  };
in 
  import reflex-platform { config.android_sdk.accept_license = true; }