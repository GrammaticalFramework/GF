--# -path=.:resource/abstract:resource/../prelude

-- Language-independent question grammar parametrized on Resource.

incomplete concrete QuestionsI of Questions = open Resource in {
  lincat
    Phrase = Phr ;
    Entity = N ;
    Action = V2 ;
  lin
    Who act obj = 
      QuestPhrase (UseQCl (PosTP TPresent ASimul) 
        (QPredV2 who8one_IP act (IndefNumNP NoNum (UseN obj)))) ;
    Whom subj act = 
      QuestPhrase (UseQCl (PosTP TPresent ASimul) 
        (IntSlash who8one_IP (SlashV2 (DefOneNP (UseN subj)) act))) ;
    Answer subj act obj = 
     IndicPhrase (UseCl (PosTP TPresent ASimul) 
        (SPredV2 (DefOneNP (UseN subj)) act (IndefNumNP NoNum (UseN obj)))) ;
}
