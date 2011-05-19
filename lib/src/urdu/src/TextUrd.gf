concrete TextUrd of Text = CommonX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] ** {

-- This works for the special punctuation marks of Urdu.

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "" ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ "" ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ "" ++ xs.s} ;

}
