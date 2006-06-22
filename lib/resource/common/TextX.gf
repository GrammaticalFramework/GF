concrete TextX of Text = CommonX ** {

-- This will work for almost all languages except Spanish.

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "." ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ "?" ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ "!" ++ xs.s} ;

}
