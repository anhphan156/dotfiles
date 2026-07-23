(_: prev: {
  gdb = let
    gdb-dashboard = prev.stdenv.mkDerivation {
      pname = "gdb";
      version = "1.0.0";
      src = prev.fetchFromGitHub {
        owner = "cyrus-and";
        repo = "gdb-dashboard";
        rev = "05b31885798f16b1c1da9cb78f8c78746dd3557e";
        sha256 = "sha256-x3XcAJdj2Q8s+ZkIBHpGZvCroedPzBmqt5W9Hc1FL7s=";
      };

      installPhase = ''
        cp .gdbinit $out
      '';
    };
  in
    prev.symlinkJoin {
      name = "gdb";
      paths = [prev.gdb];
      nativeBuildInputs = [prev.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/gdb \
          --add-flags '-x' \
          --add-flags '${gdb-dashboard}'
      '';
    };
})
