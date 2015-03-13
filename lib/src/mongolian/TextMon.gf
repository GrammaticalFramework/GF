concrete TextMon of Text = CatMon ** {
  flags coding=utf8 ;

lin
 TEmpty = {s = []} ;
 TFullStop p t = {s = p.s ++ "." ++ t.s} ;
 TQuestMark p t = {s = p.s ++ "?" ++ t.s} ;
 TExclMark p t = {s = p.s ++ "!" ++ t.s} ;

}
