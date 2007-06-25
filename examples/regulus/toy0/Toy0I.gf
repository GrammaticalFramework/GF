incomplete concrete Toy0I of Toy0 = open Syntax, Lexicon in {

lincat
  Spec = Det ;
  Noun = N ;
  NP   = Utt ;

lin
  SpecNoun spec noun = mkUtt (mkNP spec noun) ;

  One = mkDet one_Quant ;
  Two = mkDet (mkNum n2_Numeral) ;

  Felis = cat_N ;
  Canis = dog_N ;

}

