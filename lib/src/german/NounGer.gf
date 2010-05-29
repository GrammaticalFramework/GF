concrete NounGer of Noun = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ 
                 (let k = (prepC c).c in cn.s ! adjfCase det.a k ! det.n ! k) ;
      a = agrgP3 cn.g det.n ;
      isPron = False
      } ;

    DetNP det = {
      s = \\c => det.sp ! Neutr ! c ; ---- genders
      a = agrP3 det.n ;
      isPron = False
      } ;

    UsePN pn = heavyNP {
      s = \\c => usePrepC c (\k -> pn.s ! k) ;
      a = agrP3 Sg
      } ;

    UsePron pron = {
      s = \\c => usePrepC c (\k -> pron.s ! NPCase k) ;
      a = pron.a ;
      isPron = True
      } ;

    PredetNP pred np = 
      let ag = case pred.a of {PAg n => agrP3 n ; _ => np.a} in heavyNP {
        s = \\c0 => 
          let c = case pred.c.k of {NoCase => c0 ; PredCase k => k} in
          pred.s ! numberAgr ag ! genderAgr np.a ! c0 ++ pred.c.p ++ np.s ! c ; 
        a = ag
        } ;

    PPartNP np v2 = heavyNP {
      s = \\c => np.s ! c ++ v2.s ! VPastPart APred ; --- invar part
      a = np.a
      } ;

    AdvNP np adv = heavyNP {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetQuantOrd quant num ord = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s  = \\g,c => quant.s ! num.isNum ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k ++ ord.s ! agrAdj g (adjfCase a k) n k) ;
        sp = \\g,c => quant.sp ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k ++ ord.s ! agrAdj g (adjfCase a k) n k) ;
        n = n ;
        a = a
        } ;

    DetQuant quant num = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s  = \\g,c => quant.s ! num.isNum ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k) ;
        sp = \\g,c => quant.sp ! n ! g ! c ++ (let k = (prepC c).c in
                        num.s!g!k) ;
        n = n ;
        a = a
        } ;


    PossPron p = {
      s  = \\_,n,g,c => usePrepC c (\k -> p.s ! NPPoss (gennum g n) k) ;
      sp = \\n,g,c   => usePrepC c (\k -> p.s ! NPPoss (gennum g n) k) ;
      a = Strong --- need separately weak for Pl ?
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

    DefArt = {
      s = \\_,n,g,c => artDefContr (gennum g n) c ; 
      sp = \\n,g,c  => artDefContr (gennum g n) c ;  ---- deren, denem...
      a = Weak
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
        Sg => \\g,c => usePrepC c (\k -> "ein" + pronEnding ! GSg g ! k) ;
        Pl => \\_,c => usePrepC c (\k -> caselist "einige" "einige" "einigen" "einiger" ! k)
        } ;
      a = Strong
      } ;

    MassNP cn = {
      s = \\c => usePrepC c (\k -> cn.s ! adjfCase Strong k ! Sg ! k) ;
      a = agrP3 Sg ;
      isPron = False
      } ;

    UseN, UseN2 = \n -> {
      s = \\_ => n.s ;
      g = n.g
      } ;

    ComplN2 f x = {
      s = \\_,n,c => f.s ! n ! c ++ appPrep f.c2 x.s ;
      g = f.g
      } ;

    ComplN3 f x = {
      s = \\n,c => f.s ! n ! c ++ appPrep f.c2 x.s ;
      g = f.g ; 
      c2 = f.c3
      } ;

    Use2N3 f = {
      s = f.s ;
      g = f.g ; 
      c2 = f.c2
      } ;

    Use3N3 f = {
      s = f.s ;
      g = f.g ; 
      c2 = f.c3
      } ;

    AdjCN ap cn = 
      let 
        g = cn.g 
      in {
        s = \\a,n,c => 
               preOrPost ap.isPre
                 (ap.s ! agrAdj g a n c)
                 (cn.s ! a ! n ! c) ;
        g = g
        } ;

    RelCN cn rs = {
      s = \\a,n,c => cn.s ! a ! n ! c ++ rs.s ! gennum cn.g n ;
      g = cn.g
      } ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ 
                 rs.s ! gennum (genderAgr np.a) (numberAgr np.a) ;
      a = np.a ;
      isPron = False
      } ;

    SentCN cn s = {
      s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ;
      g = cn.g
      } ;

    AdvCN cn s = {
      s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ;
      g = cn.g
      } ;

    ApposCN  cn np = let g = cn.g in {
      s = \\a,n,c => cn.s ! a ! n ! c ++ np.s ! NPC c ;
      g = g ;
      isMod = cn.isMod
      } ;

}
