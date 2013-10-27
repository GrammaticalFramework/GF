--# -path=.:alltenses:../phrasebook:../../lib/src/english:../../lib/src/swedish:../../lib/src/scandinavian

concrete TranslateSwe of Translate = 
    ParseSwe - [open_A], 
    PhrasebookSwe ** 
  open SyntaxSwe, ParadigmsSwe, (E = ExtraSwe), Prelude in {

lin
  PPhr p = lin Text p ;
  NP_Person np = {name = lin NP np ; isPron = False ; poss = mkQuant he_Pron} ;
  NP_Object np = lin NP np ;
  NP_Item np = lin NP np ;
  NP_Place np0 = let np = lin NP np0 in 
                 {name = np ; at = SyntaxSwe.mkAdv in_Prep np ; to = SyntaxSwe.mkAdv to_Prep np} ;
  
}