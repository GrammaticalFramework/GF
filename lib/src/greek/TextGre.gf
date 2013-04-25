concrete TextGre of Text = CatGre ** {
  flags coding=utf8 ;


  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "." ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ ";" ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ "!" ++ xs.s} ;

}