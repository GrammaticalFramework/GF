--# -path=.:alltenses:../phrasebook:../../lib/src/english

concrete TranslateEng of Translate = ParseEng, PhrasebookEng ** open SyntaxEng, (E = ExtraEng), Prelude in {

lin
  PPhr p = lin Text p ;
  NP_Person np = {name = lin NP np ; isPron = False ; poss = E.GenNP np} ;
  NP_Object np = lin NP np ;
  NP_Item np = lin NP np ;
  NP_Place np0 = let np = lin NP np0 in 
                 {name = np ; at = SyntaxEng.mkAdv in_Prep np ; to = SyntaxEng.mkAdv to_Prep np} ;
  
}