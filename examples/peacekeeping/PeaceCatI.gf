incomplete concrete PeaceCatI of PeaceCat = 
  Cat ** open Lang, PeaceRes, Prelude in {

  lincat
    MassN = N ;
    Phrase = { s : Str; p : Punct } ;
    PhraseWritten = { s : Str } ;
    PhraseSpoken = { s : Str } ;

  lin 
    Written x = mkWritten x.s x.p ;
    Spoken x = { s = x.s } ;

  oper
    mkWritten : Str -> Punct -> { s : Str } ;
    mkWritten x p = case p of {
      FullStop => { s = x ++ "." } ; --TFullStop (ss s) TEmpty ;
      QuestMark => { s = x ++ "?" } ; --TQuestMark (ss s) TEmpty ;
      ExclMark => { s = x ++ "!" } --TExclMark (ss s) TEmpty 
    } ;

}