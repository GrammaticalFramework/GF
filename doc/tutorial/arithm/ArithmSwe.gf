--# -path=.:alltenses:prelude


concrete ArithmSwe of Arithm = ArithmI with
  (Lang = LangSwe),
  (Lex = LexSwe) ;

{-
concrete ArithmSwe of Arithm = open LangSwe, ParadigmsSwe in {

  lincat
    Prop = S ;
    Nat  = NP ;

  lin
    Zero = 
      UsePN (regPN "noll" neutrum) ;
    Succ n = 
      DetCN (DetSg (SgQuant DefArt) NoOrd) 
        (ComplN2 (mkN2 (mk2N "efterföljare" "efterföljare") 
           (mkPreposition "till")) n) ;
    Even n = 
      UseCl TPres ASimul PPos 
        (PredVP n (UseComp (CompAP (PositA (regA "jämn"))))) ;
    And x y = 
      ConjS and_Conj (BaseS x y) ;

}
-}