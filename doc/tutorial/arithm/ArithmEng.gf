--# -path=.:alltenses:prelude

concrete ArithmEng of Arithm = ArithmI with
  (Lang = LangEng),
  (Lex = LexEng) ;

{-

concrete ArithmEng of Arithm = open LangEng, ParadigmsEng in {

  lincat
    Prop = S ;
    Nat  = NP ;

  lin
    Zero = 
      UsePN (regPN "zero" nonhuman) ;
    Succ n = 
      DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 (regN2 "successor") n) ;
    Even n = 
      UseCl TPres ASimul PPos 
        (PredVP n (UseComp (CompAP (PositA (regA "even"))))) ;
    And x y = 
      ConjS and_Conj (BaseS x y) ;

}
-}
