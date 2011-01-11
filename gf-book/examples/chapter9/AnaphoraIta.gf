concrete AnaphoraIta of Anaphora = TestSemanticsIta - [she_NP] ** 
  open ResIta, Prelude, Formal in {

lincat
  Proof = {} ;

lin
  IfS A B = {s = "se" ++ A.s ++ B.s} ;

  AnaNP cn _ _ = case cn.g of {
    Masc => pronNP "lui" "lo" "gli" Masc  Sg Per3 ;
    Fem  => pronNP "lei" "la" "le" Fem  Sg Per3
    } ;

  pe _ _ = constant [] ; ----

}
