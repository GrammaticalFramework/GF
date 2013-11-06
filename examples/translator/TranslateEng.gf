--# -path=.:../phrasebook:../../lib/src/english:../../lib/src/abstract

concrete TranslateEng of Translate = 
  ParseEng, 
  PhrasebookEng  - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease] 
  ** open SyntaxEng, (E = ExtraEng), Prelude in {

flags
  literal = Symb ;
lin
  PPhr p = lin Text p ;
  NP_Person np = {name = lin NP np ; isPron = False ; poss = E.GenNP np} ;
  NP_Object np = lin NP np ;
  NP_Item np = lin NP np ;
  NP_Place np0 = let np = lin NP np0 in 
                 {name = np ; at = SyntaxEng.mkAdv in_Prep np ; to = SyntaxEng.mkAdv to_Prep np} ;

--- to remove Phrasebook punctuation, which makes the output in Translate heterogeneous

    PSentence s = lin Text (mkUtt s) ; 
    PQuestion s = lin Text (mkUtt s) ; 
    PGreetingMale, PGreetingFemale = \g -> lin Text g ;
    GObjectPlease o = lin Text (mkUtt o) ;
  
}