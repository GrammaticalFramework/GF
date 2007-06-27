--# -path=..:present:prelude

concrete Toy0Fin0 of Toy0 = open SyntaxFin, ParadigmsFin in {

lincat
  Spec = Det ;
  Noun = N ;
  NP   = Utt ;
lin
  SpecNoun spec noun = mkUtt (SyntaxFin.mkNP spec noun) ;

  One = mkDet one_Quant ;
  Two = mkDet (mkNum n2_Numeral) ;
  Felis = mkN "kissa" ;
  Canis = mkN "koira" ;
}
