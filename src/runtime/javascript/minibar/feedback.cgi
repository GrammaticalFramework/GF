#!/bin/bash

bin=../bin
. $bin/cgistart.sh

getquery

if [ -n "$feedback_path" ] && 
   echo "t=$(date +%F+%T)&ip=$REMOTE_ADDR&$query&accept_language=$HTTP_ACCEPT_LANGUAGE" >> "$feedback_path"
then 

    pagestart "Thank you"
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