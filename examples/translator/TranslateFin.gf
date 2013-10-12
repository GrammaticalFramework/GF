--# -path=.:../phrasebook:../../lib/src/finnish/stemmed:../../lib/src/finnish:../../lib/src/api:../../lib/src/english:alltenses

concrete TranslateFin of Translate = ParseFin, PhrasebookFin - [at_Prep] ** open SyntaxFin, (E = ExtraFin), Prelude in {

lin
  PPhr p = lin Text p ;
  NP_Person np = {name = lin NP np ; isPron = False ; poss = E.GenNP np} ;
  NP_Object np = lin NP np ;
  NP_Item np = lin NP np ;
  NP_Place np0 = let np = lin NP np0 in 
                 {name = np ; at = SyntaxFin.mkAdv in_Prep np ; 
                  to = SyntaxFin.mkAdv to_Prep np ; from = SyntaxFin.mkAdv from_Prep np} ;
  
}