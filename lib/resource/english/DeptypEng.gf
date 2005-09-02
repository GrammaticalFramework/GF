---- to be merged in TypesEng

resource DeptypEng = open Prelude, TypesEng in {

  param 
    VComp = 
       CVt_
     | CVt  CComp
     | CVtN CPrep CComp ;

    CComp =
       CCtN CPrep
     | CCtS
     | CCtV
     | CCtQ
     | CCtA ;

    CPrep = CP_ | CP_at | CP_in | CP_on | CP_to ;

  oper
    strCPrep : CPrep -> Str = \p -> case p of {
      CP_   => [] ;
      CP_at => "at" ;
      CP_in => "in" ;
      CP_on => "on" ;
      CP_to => "to" 
      } ;

    cprep1, cprep2 : VComp -> Str -> Str ;

    cprep1 c s = case c of {
      CVt (CCtN cp) => strCPrep cp ++ s ;
      CVtN cp _ => strCPrep cp ++ s ;
      _ => s
      } ;

    cprep2 c s = case c of {
      CVtN _ (CCtN cp) => strCPrep cp ++ s ;
      _ => s
      } ;


}