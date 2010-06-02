#!/bin/bash

bin=../bin
AUTOHEADER=no
. $bin/cgistart.sh

save_feedback() {
getquery

if [ -n "$feedback_path" ] && 
   echo "t=$(date +%F+%T)&ip=$REMOTE_ADDR&$query&accept_language=$HTTP_ACCEPT_LANGUAGE&user_agent=$(echo -n $HTTP_USER_AGENT | plain2url)" >> "$feedback_path"
then 

    pagestart "Thank you!"
    echo "Your feedback has been saved."
    begin script type="text/javascript"
    echo "setTimeout(function(){window.close()},4000);"
    end
    pageend

else

    pagestart "Feedback error"
    echo "Your feedback could not be saved. Sorry."
    p
    tag 'input type=button onclick="javascript:history.back()" value="&lt;- Go back"'
    pageend

fi
}

view_feedback() {
  charset="UTF-8"
  pagestart "Collected Feedback"
  begin pre
   Reg show reverse drop color_depth,pixel_depth,outer_size,inner_size,available_screen_size from-url <"$PATH_TRANSLATED" | plain2html
  end
  pageend
}

case "$PATH_TRANSLATED" in
  "") save_feedback ;;
  *) view_feedback
esac