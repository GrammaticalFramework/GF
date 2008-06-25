--# -path=.:present:api:prelude
concrete Toy0Eng of Toy0 = 
    open SyntaxEng, ParadigmsEng in {

  flags language=en_US ;

  lincat
    Spec = Det ; Noun = N ; NP = Utt ;

  lin
    SpecNoun s n  = mkUtt (mkNP s n) ;
    One           = mkDet one_Quant ;
    Two           = mkDet n2_Numeral ;
    Felis         = mkN "cat" ;
    Canis         = mkN "dog" ;
}
