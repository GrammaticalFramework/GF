--# -path=.:resource/english:resource/abstract:resource/../prelude

concrete AnimalsEng of Animals = open ResourceEng, ParadigmsEng, VerbsEng in {
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
    Dog = regN "dog" ;
    Cat = regN "cat" ;
    Mouse = mk2N "mouse" "mice" ;
    Lion = regN "lion" ;
    Zebra = regN "zebra" ;
    Chase = dirV2 (regV "chase") ;
    Eat = dirV2 (eat_V ** {lock_V = <>}) ;
    Like = dirV2 (regV "like") ;
}


{-
> p -cat=Phr "who likes cars ?"

QuestPhrase (UseQCl (PosTP TPresent ASimul) (QPredV2 who8one_IP like_V2 (IndefNumNP NoNum (UseN car_N))))

QuestPhrase (UseQCl (PosTP TPresent ASimul) (IntSlash who8one_IP (SlashV2 (DefOneNP (UseN car_N))  like_V2)))

> p -cat=Phr "the house likes cars ."

IndicPhrase (UseCl (PosTP TPresent ASimul) (SPredV2 (DefOneNP (UseN house_N)) like_V2 (IndefNumNP NoNum (UseN car_N))))

-}