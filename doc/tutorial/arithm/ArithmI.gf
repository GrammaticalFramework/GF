--# -path=.:alltenses:prelude

incomplete concrete ArithmI of Arithm = open Lang, Lex in {

  lincat
    Prop = S ;
    Nat  = NP ;

  lin
    Zero = 
      UsePN zero_PN ;
    Succ n = 
      DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 successor_N2 n) ;
    Even n = 
      UseCl TPres ASimul PPos 
        (PredVP n (UseComp (CompAP (PositA even_A)))) ;
    And x y = 
      ConjS and_Conj (BaseS x y) ;

}
