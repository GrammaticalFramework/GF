concrete ExtraFre of ExtraFreAbs = ExtraRomanceFre ** 
  open CommonRomance, PhonoFre, MorphoFre, ParadigmsFre, ParamX, ResFre, Prelude in {

  flags coding=utf8 ;
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
      {s = \\c => "les" + quelPron ! a ; a = a}
      where {a = aagr Fem Pl} ;
    whoSg8fem_IP = 
      {s = \\c => "la" + quelPron ! a ; a = a}
      where {a = aagr Fem Pl} ;

    youSg8fem_Pron = mkPronoun 
      "tu" (elision "t") (elision "t") "toi" "ton" (elisPoss "t") "tes"
      Fem Sg P2 ;
    youPl8fem_Pron =
      let vous = mkPronoun "vous" "vous" "vous" "vous" "votre" "votre" "vos" Fem Pl P2
      in 
      {s = vous.s ; hasClit = vous.hasClit ; poss = vous.poss ; a = vous.a ; isPol = False ; isNeg = False} ;
    youPol8fem_Pron =
      let vous = mkPronoun "vous" "vous" "vous" "vous" "votre" "votre" "vos" Fem Pl P2
      in 
      {s = vous.s ; hasClit = vous.hasClit ; poss = vous.poss ; a = vous.a ; isPol = True ; isNeg = False} ;

    ce_Pron = 
      let ce = elision "c" 
      in 
      mkPronoun ce ce ce ("cela" | "ça") "son" (elisPoss "s") "ses" Masc Sg P3 ; ---- variants?

    AdvDatVP = insertClit3 datClit ;
    AdvGenVP = insertClit3 genClit ;

  oper
    prepQue : Case -> Str = \c -> case c of {
      Nom | Acc => elisQue ;
      _   => prepCase c ++ "qui" ---
      } ;
    caseQue : Case -> Str = \c -> case c of {
      Nom => "qui" ;
      _   => elisQue
      } ;

  lin
    tout_Det = {
    s  = \\g,c => prepCase c ++ genForms "tout" "toute" ! g ;
    sp = \\g,c => prepCase c ++ genForms "tout" "toute" ! g ;
    n = Sg ; 
    s2 = [] ;
    isNeg = False
    } ;

    PNegNe = {s = [] ; p = RNeg True} ;

    ExistsNP np = 
      mknpClause "il" (insertComplement (\\_ => (np.s ! Nom).ton) (predV (regV "exister"))) ; ---- np.a

--- in ExtraRomance
--    PassAgentVPSlash vps np = passVPSlash 
--      vps ("par" ++ (np.s ! Acc).ton) ;

}
