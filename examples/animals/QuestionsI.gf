-- to compile: echo "eb -file=QuestionsI.gfe" | gf $GF_LIB_PATH/present/LangEng.gfo
-- or use directly gf <mkAnimals.gfs

incomplete concrete QuestionsI of Questions = open Lang in {
  lincat
    Phrase = Utt ;
    Entity = N ;
    Action = V2 ;

  lin 
    Who  love_V2 man_N           = (
--- WARNING: ambiguous example who loves men
UttQS (UseQCl (TTAnt TPres ASimul) PPos (QuestVP whoSg_IP (ComplSlash (SlashV2a love_V2) (DetCN (DetQuant IndefArt NumPl) (UseN man_N)))))
)
 ;
    Whom man_N love_V2           = (
--- WARNING: ambiguous example whom does the man love
UttQS (UseQCl (TTAnt TPres ASimul) PPos (QuestSlash whoPl_IP (SlashVP (DetCN (DetQuant DefArt NumSg) (UseN man_N)) (SlashV2a love_V2))))
  --- UttQS (UseQCl (TTAnt TPres ASimul) PPos (QuestSlash whoSg_IP (SlashVP (DetCN (DetQuant DefArt NumSg) (UseN man_N)) (SlashV2a love_V2))))
)
 ;
    Answer woman_N love_V2 man_N = (
--- WARNING: cannot parse example the woman lovess men; unknown words: lovess
)
 ;

}
