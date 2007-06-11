incomplete concrete Toy0I of Toy0 = open Syntax, Lexicon in {

lincat
  Spec = Det ;
  Noun = N ;
  NP   = Syntax.NP ;
  MAIN = Utt ;

lin
  Main np = mkUtt np ;
  SpecNoun spec noun = mkNP spec noun ;

  One = mkDet one_Quant ;
  Two = mkDet (mkNum n2_Numeral) ;

  Felis = cat_N ;
  Canis = dog_N ;

}

