--# -resource=../../english/LangEng.gf

-- to compile: gf -makeconcrete QuestionsI.gfe

incomplete concrete QuestionsI of Questions = open Resource in {
  lincat
    Phrase = Phr ;
    Entity = N ;
    Action = V2 ;

  lin Who love_V2 man_N = QuestPhrase (UseQCl (PosTP TPresent ASimul) (QPredV2 who8one_IP love_V2 (IndefNumNP NoNum (UseN man_N)))) ;
  lin Whom man_N love_V2 = QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntSlash who8many_IP (SlashV2 (DefOneNP (UseN man_N)) love_V2))) ; -- AMBIGUOUS
  lin Answer woman_N love_V2 man_N = IndicPhrase (UseCl (PosTP TPresent ASimul) (SPredV2 (DefOneNP (UseN woman_N)) love_V2 (IndefNumNP NoNum (UseN man_N)))) ;

}
