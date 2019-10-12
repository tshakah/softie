with import <nixpkgs> {};
let
  unstable = import <unstable> {};
in
stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    unstable.beam.packages.erlangR22.elixir_1_9
    postgresql_11
    nodejs
    inotify-tools
    elmPackages.elm
    watchexec
  ];
  PGDATA = "tmp/pgdata";
  shellHook = ''
    initdb -U postgres > /dev/null
    pg_ctl start > /dev/null
  '';
}
