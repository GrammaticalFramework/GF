incomplete concrete Toy0I of Toy0 = open Syntax, Lexicon in {

lincat
  Spec = Det ;
  Noun = N ;
  NP   = Utt ;

lin
  SpecNoun spec noun = mkUtt (mkNP spec noun) ;

  One = mkDet n1_Numeral ;
  Two = mkDet n2_Numeral ;

  Felis = cat_N ;
  Canis = dog_N ;

}

