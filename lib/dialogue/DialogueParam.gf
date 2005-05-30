interface DialogueParam = open Resource, Predef, Prelude in {

  param 
    PhraseForm = PPos | PNeg | PQuest ;

  oper
    mkPhraseStr : (p,n,q : Str) -> {s : PhraseForm => Str} = \p,n,q ->
      {s = table {
         PPos   => p ;
         PNeg   => n ;
         PQuest => q
         }
      } ;

    mkPhrase : Cl -> {s : PhraseForm => Str} = \p ->
      mkPhraseStr
        ((IndicPhrase (UseCl  (PosTP TPresent ASimul) p)).s)
        ((IndicPhrase (UseCl  (NegTP TPresent ASimul) p)).s)
        ((QuestPhrase (UseQCl (PosTP TPresent ASimul) (QuestCl p))).s) ;

    mkQuestion : QCl -> {s : Str} = \q ->
      (QuestPhrase (UseQCl (PosTP TPresent ASimul) q)) ;

}
