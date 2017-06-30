concrete TextMon of Text = CatMon ** open Prelude in {
  flags coding=utf8 ;

lin
 TEmpty = {s = []} ;
 TFullStop p t = {s = p.s ++ SOFT_BIND ++ "." ++ t.s} ;
 TQuestMark p t = {s = p.s ++ SOFT_BIND ++ "?" ++ t.s} ;
 TExclMark p t = {s = p.s ++ SOFT_BIND ++ "!" ++ t.s} ;

}
