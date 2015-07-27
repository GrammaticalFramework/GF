concrete NounGer of Noun = CatGer ** open ResGer, MorphoGer, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ 
                 (let k = (prepC c).c in cn.s ! adjfCase det.a k ! det.n ! k) ;
      a = agrgP3 cn.g det.n ;
      isPron = det.isDef ;   -- ich sehe den Mann nicht vs. ich sehe nicht einen Mann
      rc = cn.rc ! det.n ;
      adv = cn.adv ;
      ext = cn.ext 
      } ;

    DetNP det = {
      s = \\c => det.sp ! Neutr ! c ; -- more genders in ExtraGer
      a = agrP3 det.n ;
      isPron = det.isDef ;
      rc, adv, ext = []
      } ;

    UsePN pn = {
      s = \\c => usePrepC c (\k -> pn.s ! k) ;
      a = agrgP3 pn.g Sg ;
      isPron = True ; --- means: this is not a heavy NP, but comes before negation
 	  rc, adv, ext = []
      } ;

    UsePron pron = {
      s = \\c => usePrepC c (\k -> pron.s ! NPCase k) ;
      a = pron.a ;
      isPron = True ;
	  rc, adv, ext = []
      } ;

    PredetNP pred np = 
      let ag = case pred.a of {PAg n => agrP3 n ; _ => np.a} in np ** {
        s = \\c0 => 
          let c = case pred.c.k of {NoCase => c0 ; PredCase k => k} in
          pred.s ! numberAgr ag ! genderAgr np.a ! c0 ++ pred.c.p ++ np.s ! c ; 
        a = ag ;
        isPron = False
        } ;

    PPartNP np v2 = np ** {
      s = \\c => np.s ! c ++ v2.s ! VPastPart APred ; --- invar part
      isPron = False
      } ;
	{- possibly structures such as
		"sie ist eine erfolgreiche Frau geliebt von vielen"
	 but only with v2 not possible in German? -}
	
    AdvNP np adv = np ** {
      adv = np.adv ++ adv.s ;
      isPron = False
      } ;

    ExtAdvNP np adv = np ** {
      adv = np.adv ++ embedInCommas adv.s ;
      isPron = False
      } ;

    DetQuantOrd quant num ord = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s  = \\g,c => quant.s  ! num.isNum ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k ++ ord.s ! agrAdj g (adjfCase a k) n k) ;
        sp = \\g,c => quant.sp ! num.isNum ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k ++ ord.s ! agrAdj g (adjfCase quant.aPl k) n k) ;
        n = n ;
        a = case n of {Sg => a ; Pl => quant.aPl} ;
        isDef = case <quant.a, quant.aPl> of {<Strong,Strong> => False ; _ => True} ;
        } ;

    DetQuant quant num = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s  = \\g,c => quant.s  ! num.isNum ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k) ;
        sp = \\g,c => quant.sp ! num.isNum ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k) ;
        n = n ;
        a = case n of {Sg => a ; Pl => quant.aPl} ;
        isDef = case <quant.a, quant.aPl> of {<Strong,Strong> => False ; _ => True} ;
        } ;


    PossPron p = {
      s  = \\_,n,g,c => usePrepC c (\k -> p.s ! NPPoss (gennum g n) k) ;
      sp = \\_,n,g,c => usePrepC c (\k -> p.s ! NPPoss (gennum g n) k) ;
      a = Strong ;
      aPl = Weak ;
      } ;

    NumCard n = n ** {isNum = True} ;

    NumPl = {s = \\g,c => []; n = Pl ; isNum = False} ; 
    NumSg = {s = \\g,c => []; n = Sg ; isNum = False} ; 

    NumDigits numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;
    OrdDigits numeral = {s = \\af => numeral.s ! NOrd af} ;

    NumNumeral numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;
    OrdNumeral numeral = {s = \\af => numeral.s ! NOrd af} ;

    AdNum adn num = {s = \\g,c => adn.s ++ num.s!g!c; n = num.n } ;

    OrdSuperl a = {s = a.s ! Superl} ;

    OrdNumeralSuperl n a = {s = \\af => n.s ! NOrd APred ++ Predef.BIND ++ a.s ! Superl ! af} ; -- drittbeste

    DefArt = {
      s = \\_,n,g,c => artDefContr (gennum g n) c ; 
      sp = \\_,n,g,c  => artDefContr (gennum g n) c ;  ---- deren, denem...
      a, aPl = Weak
      } ;

    IndefArt = {
      s = table {
        True => \\_,_,c => usePrepC c (\k -> []) ;
        False => table {
          Sg => \\g,c => usePrepC c (\k -> "ein" + pronEnding ! GSg g ! k) ;  
          Pl => \\_,c => usePrepC c (\k -> [])
          }
        } ; 
      sp = table {
        True => \\_,_,c => usePrepC c (\k -> []) ;
        False => table {
          Sg => \\g,c => usePrepC c (\k -> (detLikeAdj False Sg "ein").s ! g ! NPC k) ;
          Pl => \\_,c => usePrepC c (\k -> caselist "einige" "einige" "einigen" "einiger" ! k)
          }
        } ;
      a, aPl = Strong 
      } ;

    MassNP cn = {
      s = \\c => usePrepC c (\k -> cn.s ! Strong ! Sg ! k) ;
      a = agrgP3 cn.g Sg ;
      isPron = False ;
	  rc = cn.rc ! Sg ;
	  adv = cn.adv ;
	  ext = cn.ext 
      } ;

    UseN, UseN2 = \n -> {
      s = \\_ => n.s ;
      g = n.g ;
	  rc = \\_ => [] ;
	  ext,adv = [] 
      } ;

    ComplN2 f x = {
      s = \\_,n,c => f.s ! n ! c ++ appPrepNP f.c2 x ;
      g = f.g ;
	  rc = \\_ => [] ;
	  ext,adv = [] 
      } ;

    ComplN3 f x = {
      s = \\n,c => f.s ! n ! c ++ appPrepNP f.c2 x ;
      co = f.co ++ appPrepNP f.c2 x ; ---- should not occur at all; the abstract syntax is problematic in giving N2
      uncap = {
        s = \\n,c => f.uncap.s ! n ! c ++ appPrepNP f.c2 x ;
        co = f.uncap.co ++ appPrepNP f.c2 x ; ---- should not occur at all; the abstract syntax is problematic in giving N2
       } ;
      g = f.g ; 
      c2 = f.c3 ;
	  rc = \\_ => [] ;
	  ext,adv = [] 
      } ;

    Use2N3 f = f ;

    Use3N3 f = f ** {
      c2 = f.c3;
      } ;

    AdjCN ap cn = 
      let 
        g = cn.g 
      in cn ** {
        s = \\a,n,c => 
               preOrPost ap.isPre
                 (ap.c.p1 ++ ap.c.p2 ++ ap.s ! agrAdj g a n c ++ ap.ext)
                 (cn.s ! a ! n ! c) ;
        g = g
        } ;

 
    RelCN cn rs = cn ** {rc = \\n => embedInCommas (rs.s ! RGenNum (gennum cn.g n))} ;

    RelNP np rs = np ** {
      rc = embedInCommas (rs.s ! RGenNum (gennum (genderAgr np.a) (numberAgr np.a))) ;
      isPron = False } ;

    SentCN cn s = cn ** {ext = embedInCommas s.s} ;

    AdvCN cn a = cn ** {adv = a.s} ;

    ApposCN  cn np = let g = cn.g in cn ** {
      s = \\a,n,c => cn.s ! a ! n ! c ++ np.s ! NPC c ++ bigNP np } ;

    PossNP cn np = cn ** {
      s = \\a,n,c => cn.s ! a ! n ! c ++ np.s ! NPP CVonDat ++ bigNP np } ;
}
