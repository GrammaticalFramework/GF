--# -path=.:resource/swedish:resource/scandinavian:resource/abstract:resource/../prelude

concrete AnimalsSwe of Animals = open ResourceSwe, ParadigmsSwe, VerbsSwe in {
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
    Dog = regN "hund" utrum ;
    Cat = mk2N "katt" "katter" ;
    Mouse = mkN "mus" "musen" "möss" "mössen" ;
    Lion = mk2N "lejon" "lejon" ;
    Zebra = regN "zebra" utrum ;
    Chase = dirV2 (regV "jaga") ;
    Eat = dirV2 äta_V ;
    Like = mkV2 (mk2V "tycka" "tycker") "om" ;
}
