--# -path=.:../abstract:../common:../prelude

abstract LangExtra =
  Grammar,
  Lexicon,
  Bornemann
  ** {
  flags startcat=Phr ;
  oper
    NumDl : Num ;
  } ;

