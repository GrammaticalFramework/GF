-- to compile: echo "eb -file=QuestionsI.gfe" -probs=probs | gf $GF_LIB_PATH/present/LangEng.gfo
-- or use directly gf <mkAnimals.gfs

incomplete concrete QuestionsI of Questions = open Lang in {
  lincat
    Phrase = Utt ;
    Entity = N ;
    Action = V2 ;

  lin 
    Who  love_V2 man_N           = (
--- WARNING: ambiguous example who loves men
UttQS (UseQCl (TTAnt TPres ASimul) PPos (QuestVP whoSg_IP (ComplSlash (SlashV2a love_V2) (DetCN (DetQuant IndefArt NumPl) (UseN man_N)))))  -- 2.122431752061382e-11
)
 ;
    Whom man_N love_V2           = (
--- WARNING: ambiguous example whom does the man love
UttQS (UseQCl (TTAnt TPres ASimul) PPos (QuestSlash whoPl_IP (SlashVP (DetCN (DetQuant DefArt NumSg) (UseN man_N)) (SlashV2a love_V2))))  -- 1.3265198450383634e-11
  --- UttQS (UseQCl (TTAnt TPres ASimul) PPos (QuestSlash whoSg_IP (SlashVP (DetCN (DetQuant DefArt NumSg) (UseN man_N)) (SlashV2a love_V2))))  -- 1.3265198450383634e-11
)
 ;
    Answer woman_N love_V2 man_N = (
--- WARNING: ambiguous example the woman loves men
UttS (UseCl (TTAnt TPres ASimul) PPos (PredVP (DetCN (DetQuant DefArt NumSg) (UseN woman_N)) (ComplSlash (SlashV2a love_V2) (DetCN (DetQuant IndefArt NumPl) (UseN man_N)))))  -- 1.1637456560533483e-14
  --- UttNP (DetCN (DetQuant DefArt NumSg) (ApposCN (ApposCN (UseN woman_N) (DetCN (DetQuant IndefArt NumPl) (UseN love_N))) (DetCN (DetQuant IndefArt NumPl) (UseN man_N))))  -- 2.018579347059343e-20
  --- UttNP (DetCN (DetQuant DefArt NumSg) (ApposCN (UseN woman_N) (DetCN (DetQuant IndefArt NumPl) (ApposCN (UseN love_N) (DetCN (DetQuant IndefArt NumPl) (UseN man_N))))))  -- 2.018579347059343e-20
)
 ;

}
