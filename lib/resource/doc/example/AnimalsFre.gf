--# -path=.:resource/french:resource/romance:resource/abstract:resource/../prelude

concrete AnimalsFre of Animals = open ResourceFre, ParadigmsFre, VerbsFre in {
  lincat
    Phrase = Phr ;
    Animal = N ;
    Action = V2 ;
  lin
    Who act obj = QuestPhrase (UseQCl (PosTP TPresent ASimul) 
                   (QPredV2 who8one_IP act (IndefNumNP NoNum (UseN obj)))) ;
    Whom subj act = QuestPhrase (UseQCl (PosTP TPresent ASimul) 
                      (IntSlash who8one_IP (SlashV2 (DefOneNP (UseN subj)) act))) ;
    Answer subj act obj = IndicPhrase (UseCl (PosTP TPresent ASimul) 
                            (SPredV2 (DefOneNP (UseN subj)) act (IndefNumNP NoNum (UseN obj)))) ;
    Dog   = regN "chien" masculine ;
    Cat   = regN "chat" masculine ;
    Mouse = regN "souris" feminine ;
    Lion  = regN "lion" masculine ;
    Zebra = regN "zèbre" masculine ;
    Chase = dirV2 (regV "chasser") ;
    Eat   = dirV2 (regV "manger") ;
    Like  = dirV2 (regV "aimer") ;
}
