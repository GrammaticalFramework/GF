
# Executable version of INSTALL

command="$1"
shift

case "$command" in
  configure)
    [ `uname` != Darwin ] || glibtoolize
    autoreconf -i
    ./configure "$@"
    ;;
  build)
    make -j "$@"
    ;;
  copy|install)
    make install "$@"
    ;;
  *)
    echo "Usage: setup.sh [configure|build|copy|install] ..."
esac
