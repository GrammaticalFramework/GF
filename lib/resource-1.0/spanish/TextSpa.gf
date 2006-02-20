concrete TextSpa of Text = {

-- This works for the special punctuation marks of Spanish.

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "." ++ xs.s} ;
    TQuestMark x xs = {s = "¿" ++ x.s ++ "?" ++ xs.s} ;
    TExclMark x xs = {s = "¡" ++ x.s ++ "!" ++ xs.s} ;

}
