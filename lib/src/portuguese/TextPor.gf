concrete TextPor of Text = CommonX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] ** {

  flags coding=utf8 ;
-- This works for the special punctuation marks of Pornish.

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "." ++ xs.s} ;
    TQuestMark x xs = {s = "¿" ++ x.s ++ "?" ++ xs.s} ;
    TExclMark x xs = {s = "¡" ++ x.s ++ "!" ++ xs.s} ;

}
