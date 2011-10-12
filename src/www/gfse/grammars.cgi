#!/bin/bash
echo "Content-Type: text/javascript"
echo ""

case "$QUERY_STRING" in
  jsonp=*) prefix="${QUERY_STRING#jsonp=}("; suffix=")" ;;
  *) prefix=""; suffix=""
esac

echo -n "$prefix"
sep="["
for g in *.pgf ; do
  echo -n "$sep\"$g\""
  sep=", "
done
echo "]$suffix"
#echo "/*"
#set
#echo "*/"
