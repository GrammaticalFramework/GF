--# -path=.:alltenses:../phrasebook:../../lib/src/english:../../lib/src/french:../../lib/src/romance

concrete TranslateFre of Translate = 
    ParseFre - [open_A], 
    PhrasebookFre - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease] ** 
  open SyntaxFre, ParadigmsFre, (E = ExtraFre), Prelude in {

lin
  PPhr p = lin Text p ;
  NP_Person np = {name = lin NP np ; isPron = False ; poss = mkQuant he_Pron} ;
  NP_Object np = lin NP np ;
  NP_Item np = lin NP np ;
  NP_Place np0 = let np = lin NP np0 in 
                 {name = np ; at = SyntaxFre.mkAdv dative np ; to = SyntaxFre.mkAdv dative np} ;
  
--- to remove Phrasebook punctuation, which makes the output in Translate heterogeneous

    PSentence s = lin Text (mkUtt s) ; 
    PQuestion s = lin Text (mkUtt s) ; 
    PGreetingMale, PGreetingFemale = \g -> lin Text g ;
    GObjectPlease o = lin Text (mkUtt o) ;

}