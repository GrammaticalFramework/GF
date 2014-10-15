concrete NounEst of Noun = CatEst ** open ResEst, HjkEst, MorphoEst, Prelude in {

  flags optimize=all_subs ; coding=utf8;

  lin

-- The $Number$ is subtle: "nuo autot", "nuo kolme autoa" are both plural
-- for verb agreement, but the noun form is singular in the latter.

    DetCN det cn = 
      let
        n : Number = case det.isNum of {
          True => Sg ;
          _ => det.n
          } ;
        ncase : NPForm -> Case * NForm = \c ->
          let k = npform2case n c 
          in 
          case <n, c, det.isNum, det.isDef> of {
            <_, NPAcc,      True,_>  => <Nom,NCase Sg Part> ; -- kolm kassi (as object)
            <_, NPCase Nom, True,_>  => <Nom,NCase Sg Part> ; -- kolm kassi (as subject)

            --Only the last word gets case ending.
            <_, NPCase Comit, _, _>  => <Gen,NCase n Comit> ;  -- kolme kassiga
            <_, NPCase Abess, _, _>  => <Gen,NCase n Abess> ;  -- kolme kassita
            <_, NPCase Ess,   _, _>  => <Gen,NCase n Ess> ;    -- kolme kassina
            <_, NPCase Termin,_, _>  => <Gen,NCase n Termin> ; -- kolme kassini
            
            <_, _, True,_>           => <k,  NCase Sg k> ;     -- kolmeks kassiks (all other cases)
            _                        => <k,  NCase n k>        -- kass, kassi, ... (det is not a number)
            }
      in {
      s = \\c => let 
                   k = ncase c ;
                 in
                 det.s ! k.p1 ++ cn.s ! k.p2 ;
      a = agrP3 det.n ;
--	(case det.isNum of {
--            True => Sg ;
--            _ => det.n
--            }) ;
      isPron = False
      } ;

    DetNP det = 
      let
        n : Number = case det.isNum of {
          True => Sg ;
          _ => det.n
          } ;
      in {
        s = \\c => let k = npform2case n c in
                 det.sp ! k ; 
        a = agrP3 (case det.isDef of {
            False => Sg ;  -- autoja menee; kolme autoa menee
            _ => det.n
            }) ;
        isPron = False
      } ;

    UsePN pn = {
      s = \\c => pn.s ! npform2case Sg c ; 
      a = agrP3 Sg ;
      isPron = False
      } ;
    UsePron p = p ** {isPron = True} ;

    PredetNP pred np = {
      s = \\c => pred.s ! complNumAgr np.a ! c ++ np.s ! c ;
      a = np.a ;
      isPron = np.isPron  -- kaikki minun - ni
      } ;

    PPartNP np v2 =
      let 
        num : Number     = complNumAgr np.a ;
        part : Str       = v2.s ! (PastPart Pass) ;
        adj : NForms     = hjk_type_IVb_maakas part ; 
        partGen : Str    = adj ! 1 ;
	partEss : Str    = partGen + "na"
      in {
        s = \\c => np.s ! c ++ part ; --partEss ;
        a = np.a ;
        isPron = np.isPron  -- minun täällä - ni
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a ;
      isPron = np.isPron  -- minun täällä - ni
      } ;

    DetQuantOrd quant num ord = {
      s = \\c => quant.s ! num.n ! c ++ num.s ! Sg ! c ++ ord.s ! NCase num.n c ; 
      sp = \\c => quant.sp ! num.n ! c ++ num.s ! Sg ! c ++ ord.s ! NCase num.n c ; 
      n = num.n ;
      isNum = num.isNum ;
      isDef = quant.isDef
      } ;

    DetQuant quant num = {
      s = \\c => quant.s ! num.n ! c ++ num.s ! Sg ! c ;
      sp = \\c => quant.sp ! num.n ! c ++ num.s ! Sg ! c ;
      n = num.n ;
      isNum = num.isNum ; -- case num.n of {Sg => False ; _ => True} ;
      isDef = quant.isDef
      } ;

    PossPron p = {
      s,sp = \\_,_ => p.s ! NPCase Gen ;
      isNum = False ;
      isDef = True  --- "minun kolme autoani ovat" ; thus "...on" is missing
      } ;

    PossNP cn np = {s = \\nf => np.s ! NPCase Gen ++ cn.s ! nf };

    NumSg = {s = \\_,_ => [] ; isNum = False ; n = Sg} ;
    NumPl = {s = \\_,_ => [] ; isNum = False ; n = Pl} ;

    NumCard n = n ** {isNum = case n.n of {Sg => False ; _ => True}} ;  -- üks raamat/kaks raamatut

    NumDigits numeral = {
      s = \\n,c => numeral.s ! NCard (NCase n c) ; 
      n = numeral.n 
      } ;
    OrdDigits numeral = {s = \\nc => numeral.s ! NOrd nc} ;

    NumNumeral numeral = {
      s = \\n,c => numeral.s ! NCard (NCase n c) ; 
      n = numeral.n
      } ;
    OrdNumeral numeral = {s = \\nc => numeral.s ! NOrd nc} ;

    AdNum adn num = {
      s = \\n,c => adn.s ++ num.s ! n ! c ; 
      n = num.n
      } ;

    -- OrdSuperl a = {s = \\nc => a.s ! Superl ! AN nc} ;
    -- TODO: it is more robust to use: kõige + Compar
    OrdSuperl a = {s = \\nc => "kõige" ++ a.s ! Compar ! AN nc} ;

    DefArt = {
      s = \\_,_ => [] ; 
      sp = table {Sg => pronSe.s ; Pl => pronNe.s} ; 
      isNum = False ;
      isDef = True   -- autot ovat
      } ;

    IndefArt = {
      s = \\_,_ => [] ; --use isDef in DetCN
      sp = \\n,c => 
         (nForms2N (nForms6 "üks" "ühe" "üht" "ühesse" "ühtede" 
         "ühtesid")).s ! NCase n c ; 
      isNum,isDef = False -- autoja on
      } ;

    MassNP cn =
      let
        n : Number = Sg ;
        ncase : Case -> NForm = \c -> NCase n c ;
      in {
        s = \\c => let k = npform2case n c in
                cn.s ! ncase k ; 
        a = agrP3 Sg ;
        isPron = False
      } ;

    UseN n = n ;

    UseN2 n = n ;

    Use2N3 f = lin N2 {
      s = f.s ;
      c2 = f.c2 ;
      isPre = f.isPre
      } ;
    Use3N3 f = lin N2 {
      s = f.s ;
      c2 = f.c3 ;
      isPre = f.isPre2
      } ;

    ComplN2 f x = {
      s = \\nf => preOrPost f.isPre (f.s ! nf) (appCompl True Pos f.c2 x)
      } ;


    ComplN3 f x = lin N2 {
      s = \\nf => preOrPost f.isPre (f.s ! nf) (appCompl True Pos f.c2 x) ;
      c2 = f.c3 ;
      isPre = f.isPre2
      } ;


    AdjCN ap cn = {
      s = \\nf => 
        case ap.infl of {
          (Invariable|Participle) => ap.s ! True ! (NCase Sg Nom) ++ cn.s ! nf ; --valmis kassile; väsinud kassile
          Regular => case nf of { 
              NCase num (Ess|Abess|Comit|Termin) => ap.s ! True ! (NCase num Gen) ++ cn.s ! nf ; --suure kassiga, not *suurega kassiga 
              _ => ap.s ! True ! nf ++ cn.s ! nf
              } 
          } 
      } ;

    RelCN cn rs = {s = \\nf => cn.s ! nf ++ rs.s ! agrP3 (numN nf)} ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ; 
      a = np.a ;  
      isPron = np.isPron ---- correct ?
      } ;

    AdvCN cn ad = {s = \\nf => cn.s ! nf ++ ad.s} ;

    SentCN cn sc = {s = \\nf=> cn.s ! nf ++ sc.s} ;

    ApposCN cn np = {s = \\nf=> cn.s ! nf ++ np.s ! NPCase Nom} ; --- luvun x

  oper
    numN : NForm -> Number = \nf -> case nf of {
      NCase n _ => n ;
      _ => Sg ---
      } ;


}
