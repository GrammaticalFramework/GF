#!/bin/bash

bin=/Users/hallgren/www/bin

charset="UTF-8"
AUTOHEADER=no

. $bin/cgistart.sh
PATH=$PATH:/Users/hallgren/.cabal/bin
export LC_CTYPE="UTF-8"
style_url="editor.css"

make_dir() {
  dir="$(mktemp -d "$tmp/gfse.XXXXXXXX")"
# chmod a+rxw "$dir"
  chmod a+rx "$dir"
  ln "$grammars/grammars.cgi" "$dir"
}


check_grammar() {
  pagestart "Uploaded"
# echo "$PATH_INFO"
  chgrp everyone "$dir"
  chmod g+ws "$dir"
  umask 002
  files=$(Reg from-url | LC_CTYPE=sv_SE.ISO8859-1 ./save "$dir")
  cd $dir
  begin pre
  if gf -s -make $files 2>&1 ; then
    end
    h3 OK
    begin ul
    [ -z "$minibar" ] || { li; link "$minibar?/tmp/${dir##*/}/" "Minibar"; }
    [ -z "$transquiz" ] || { li; link "$transquiz?/tmp/${dir##*/}/" "Translation Quiz"; }
    [ -z "$gfshell" ] || { li; link "$gfshell?dir=${dir##*/}" "GF Shell"; }
    end
    begin pre
    ls -l *.pgf
  else
    end
    begin h3 class=error_message; echo Error; end
    for f in *.gf ; do
      h4 "$f"
      begin pre class=plain
      cat -n "$f"
      end
    done
  fi
  hr
  date
# begin pre ; env
  endall
}

if [ -z "$tmp" ] || [ -z "$grammars" ] ||
   ! [ -d "$tmp" ] || ! [ -d "$grammars" ] ; then
  pagestart "Error"
  echo "upload.cgi is not properly configured"

  # cgiconfig.sh must define tmp and grammars.
  # cgiconfig.sh should minibar and gfshell to allow grammars to be tested.
  endall
else
case "$REQUEST_METHOD" in
  POST)
    case "$PATH_INFO" in
      /tmp/gfse.*)
	style_url="../../$style_url"
        dir="$tmp/${PATH_INFO##*/}"
	check_grammar
	;;
      *)
        make_dir
	check_grammar
        rm -rf "$dir"
    esac
    ;;
  GET)
    case "$QUERY_STRING" in
	dir) make_dir
	     ContentType="text/plain"
	     cgiheaders
	     echo "/tmp/${dir##*/}"
             ;;
        *) pagestart "Error"
	   echo "What do you want?"
	   endall
    esac
esac
fi
