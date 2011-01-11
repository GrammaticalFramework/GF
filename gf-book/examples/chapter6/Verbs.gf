abstract Verbs = {

cat
  S ; NP ; Subcat ; V Subcat ; Args Subcat ;

fun
  cIntr : Subcat ;
  cTr   : Subcat ;
  cS    : Subcat ;

  aIntr : NP -> Args cIntr ;
  aTr   : NP -> NP -> Args cTr ;
  aS    : NP -> S  -> Args cS ;

  pred  : (s : Subcat) -> V s -> Args s -> S ;

  john, mary : NP ;
  walk : V cIntr ;
  love : V cTr ;
  know : V cS ;

}