concrete ExtraFre of ExtraFreAbs = ExtraRomanceFre ** 
  open CommonRomance, PhonoFre, MorphoFre, ParadigmsFre, ParamX, ResFre in {

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

    i8fem_Pron = mkPronoun
      (elision "j") (elision "m") (elision "m") "moi" "mon" (elisPoss "m") "mes"
      Fem Sg P1 ;
    these8fem_NP = makeNP ["celles-ci"] Fem Pl ;
    they8fem_Pron = mkPronoun
      "elles" "les" "leur" "eux" "leur" "leur" "leurs"
      Fem Pl P3 ;
    this8fem_NP = pn2np (mkPN ["celle-ci"] Fem) ;
    those8fem_NP = makeNP ["celles-là"] Fem Pl ;
    we8fem_Pron = mkPronoun "nous" "nous" "nous" "nous" "notre" "notre" "nos"
      Fem Pl P1 ;
    whoPl8fem_IP = 
      {s = \\c => artDef a.g a.n c + quelPron ! a ; a = a}
      where {a = aagr Fem Sg} ;
    whoSg8fem_IP = 
      {s = \\c => artDef a.g a.n c + quelPron ! a ; a = a}
      where {a = aagr Fem Pl} ;

    youSg8fem_Pron = mkPronoun 
      "tu" (elision "t") (elision "t") "toi" "ton" (elisPoss "t") "tes"
      Fem Sg P2 ;
    youPl8fem_Pron,
    youPol8fem_Pron =
      mkPronoun
        "vous" "vous" "vous" "vous" "votre" "votre" "vos"
        Fem Pl P2 ;

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
