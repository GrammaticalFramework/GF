--# -path=.:alltenses:../phrasebook:../../lib/src/chinese:../../lib/src/chinese/sysu:../../lib/src/english

concrete TranslateChi of Translate = 
  ParseChi, 
  PhrasebookChi - [at_Prep, PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease] 
  ** open SyntaxChi, (E = ExtraChi), Prelude in {

lin
  PPhr p = lin Text p ;
  NP_Person np = {name = lin NP np ; isPron = False ; poss = E.GenNP np} ;
  NP_Object np = lin NP np ;
  NP_Item np = lin NP np ;
  NP_Place np0 = let np = lin NP np0 in 
                 {name = np ; at = SyntaxChi.mkAdv in_Prep np ; to = SyntaxChi.mkAdv to_Prep np} ;

--- to remove Phrasebook punctuation, which makes the output in Translate heterogeneous

    PSentence s = lin Text (mkUtt s) ; 
    PQuestion s = lin Text (mkUtt s) ; 
    PGreetingMale, PGreetingFemale = \g -> lin Text g ;
    GObjectPlease o = lin Text (mkUtt o) ;
  
}