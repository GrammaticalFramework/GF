concrete TextJap of Text = CatJap ** open ResJap, Prelude in {

flags coding = utf8 ;

lin

    TEmpty = ss "" ;
    
    TFullStop phr txt = {s = phr.s ++ "." ++ txt.s} ;
    
    TQuestMark phr txt = {s = phr.s ++ "?" ++ txt.s} ;
    
    TExclMark phr txt = {s = phr.s ++ "!" ++ txt.s} ;
}