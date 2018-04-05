let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in
  with nixpkgs;
  clangStdenv.mkDerivation {
    name = "libyubihsm";
    buildInputs = [
      autoconf
      automake
      cmake
      gettext
      glibc
      protobuf
      rustChannels.stable.rust
    ];

    shellHook = ''
      export LIBCLANG_PATH="${llvmPackages.clang-unwrapped.lib}/lib"
    '';
  }
