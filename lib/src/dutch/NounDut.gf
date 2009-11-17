concrete NounDut of Noun = CatDut ** open ResDut, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ++ cn.s ! det.a ! NF det.n Nom ;
      a = agrP3 det.n ;
      isPron = False
      } ;

    DetNP det = {
      s = \\_ => det.sp ! Neutr ;
      a = agrP3 det.n ;
      isPron = False
      } ;

    UsePN pn = {s = pn.s ; a = agrP3 Sg ; isPron = False} ;

    UsePron pron = {
      s = table {NPNom => pron.unstressed.nom ; NPAcc => pron.unstressed.acc} ;
      a = pron.a
      } ;

    PredetNP pred np = {
      s = \\c => 
        pred.s ! np.a.n ! np.a.g ++ np.s ! c ; ---- g
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPerf ; -- invar part
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetQuantOrd quant num ord = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s  = \\g => quant.s ! num.isNum ! n ! g ++ 
                      num.s ++ ord.s ! agrAdj g quant.a (NF n Nom) ;
        sp = \\g => quant.sp ! n ! g ++ 
                      num.s ++ ord.s ! agrAdj g quant.a (NF n Nom) ;
        n = n ;
        a = a
        } ;

    DetQuant quant num = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s = \\g => quant.s ! num.isNum ! n ! g ++ num.s ;
        sp = \\g => quant.sp ! n ! g ++ num.s ;
        n = n ;
        a = a
        } ;

    PossPron p = {
      s  = \\_,n,g => p.unstressed.poss ;
      sp = \\n,g => p.substposs ;
      a = Strong
      } ;

    NumCard n = {s = n.s ! Utr ! Nom ; n = n.n ; isNum = True} ;

    NumPl = {s = []; n = Pl ; isNum = False} ; 
    NumSg = {s = []; n = Sg ; isNum = False} ; 

    NumDigits numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;
    OrdDigits numeral = {s = \\af => numeral.s ! NOrd af} ;

    NumNumeral numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;
    OrdNumeral numeral = {s = \\af => numeral.s ! NOrd af} ;

    AdNum adn num = {s = \\g,c => adn.s ++ num.s!g!c; n = num.n } ;

    OrdSuperl a = {s = a.s ! Superl} ;

    DefArt = {
      s = \\_,n,g  => case <n,g> of {<Sg,Neutr> => "het" ; _ => "de"} ;
      sp = \\n,g => "die" ;
      a = Weak
      } ;

    IndefArt = {
      s = table {
        True => \\_,_ => [] ; 
        False => table {
          Sg => \\g => "een" ;
          Pl =>  \\_ => []
          }
        } ; 
      sp = table {
        Sg => \\g => "een" ;
        Pl => \\_ => "een" ----
        } ;
      a = Strong
      } ;

    MassNP cn = {
      s = \\c => cn.s ! Strong ! NF Sg Nom ;
      a = agrP3 Sg ;
      isPron = False
      } ;

    UseN, UseN2 = \n -> {
      s = \\_ => n.s ;
      g = n.g
      } ;

    ComplN2 f x = {
      s = \\_,nc => f.s ! nc ++ appPrep f.c2 x.s ;
      g = f.g
      } ;

    ComplN3 f x = {
      s = \\nc => f.s ! nc ++ appPrep f.c2 x.s ;
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
        s = \\a,n => 
               preOrPost ap.isPre
                 (ap.s ! agrAdj g a n)
                 (cn.s ! a ! n) ;
        g = g
        } ;

    RelCN cn rs = {
      s = \\a,nc => cn.s ! a ! nc ++ rs.s ! cn.g ! (case nc of {NF n c => n}) ;
      g = cn.g
      } ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a.g ! np.a.n ;
      a = np.a ;
      isPron = False
      } ;

    SentCN cn s = {
      s = \\a,nc => cn.s ! a ! nc ++ s.s ;
      g = cn.g
      } ;

    AdvCN cn s = {
      s = \\a,nc => cn.s ! a ! nc ++ s.s ;
      g = cn.g
      } ;

    ApposCN  cn np = let g = cn.g in {
      s = \\a,nc => cn.s ! a ! nc ++ np.s ! NPNom ;
      g = g ;
      isMod = cn.isMod
      } ;

}
