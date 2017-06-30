--# -coding=cp1251
concrete TextBul of Text = CatBul ** open Prelude in {
  flags coding=cp1251 ;


-- This will work for almost all languages except Spanish.

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ SOFT_BIND ++ "." ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ SOFT_BIND ++ "?" ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ SOFT_BIND ++ "!" ++ xs.s} ;

}
