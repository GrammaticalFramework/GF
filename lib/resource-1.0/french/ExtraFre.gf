concrete ExtraFre of ExtraFreAbs = ExtraRomanceFre ** 
  open CommonRomance, PhonoFre, ParamX, ResFre in {

  lin
    EstcequeS qs          = {s = "est-ce" ++ elisQue ++ qs.s ! Indic} ;
    EstcequeIAdvS idet qs = {s = idet.s ++ "est-ce" ++ elisQue ++ qs.s ! Indic} ;

    QueestcequeIP = {
      s = table {
        c => prepQue c ++ "est-ce" ++ caseQue c
        } ; 
      a = aagr Fem Pl
      } ;

    QuiestcequeIP = {
      s = table {
        c => prepQue c ++ "qui" ++ "est-ce" ++ caseQue c
        } ; 
      a = aagr Fem Pl
      } ;

  oper
    prepQue : Case -> Str = \c -> case c of {
      Nom | Acc => elisQue ;
      _   => prepCase c ++ "qui" ---
      } ;
    caseQue : Case -> Str = \c -> case c of {
      Nom => "qui" ;
      _   => elisQue
      } ;


}
