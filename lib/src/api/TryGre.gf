--# -path=.:../greek:../common:../abstract:../prelude

resource TryGre = SyntaxGre, LexiconGre, ParadigmsGre ;

{-
-[mkAdv, mkDet,mkQuant]** 
  open (P = ParadigmsGre) in {

 oper

  mkAdv = overload SyntaxGre {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

}

-}