concrete TextJpn of Text = CatJpn ** open ResJpn, Prelude in {

flags coding = utf8 ;

lin

    TEmpty = {s = ""} ;
    
    TFullStop phr txt = {s = phr.s ++ "。" ++ txt.s} ;
    
    TQuestMark phr txt = {s = phr.s ++ "？" ++ txt.s} ;
    
    TExclMark phr txt = {s = phr.s ++ "！" ++ txt.s} ;
}
