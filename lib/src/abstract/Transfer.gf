abstract Transfer = Sentence, Verb, Adverb, Structural, NumeralTransfer ** {

{-
-- examples of transfer: to test,

  > i LangEng.gf

  > p "she sees him" | pt -transfer=active2passive | l
  he is seen by her

  > p "wouldn't she see him" | pt -transfer=active2passive | l
  wouldn't he be seen by her

  > p -cat=NP "3 cats with 4 dogs" | pt -transfer=digits2numeral | l
  three cats with four dogs
-}

fun
  active2passive : Cl -> Cl ;
def
  active2passive (PredVP subj (ComplSlash (SlashV2a v) obj)) = 
    PredVP obj (AdvVP (PassV2 v) (PrepNP by8agent_Prep subj)) ;
  active2passive (PredVP subj (AdvVP (ComplSlash (SlashV2a v) obj) adv)) = 
    PredVP obj (AdvVP (AdvVP (PassV2 v) (PrepNP by8agent_Prep subj)) adv) ;
  active2passive (PredVP subj (AdVVP adv (ComplSlash (SlashV2a v) obj))) = 
    PredVP obj (AdVVP adv (AdvVP (PassV2 v) (PrepNP by8agent_Prep subj))) ;
  active2passive cl = cl ;

}
