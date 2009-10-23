concrete TextPol of Text = {

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "." ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ "?" ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ "!" ++ xs.s} ;

}
