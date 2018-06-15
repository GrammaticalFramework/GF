concrete NounDut of Noun = CatDut ** open ResDut, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = noMerge ** {
      s = \\c => det.s ! cn.g ++ cn.s ! det.a ! NF det.n Nom ;
      a = agrP3 det.n ;
      isPron = False ;
      } ;

    DetNP det = det ** {
      s = \\_ => det.sp ! Neutr ;
      a = agrP3 det.n ;
      isPron = False
      } ;

    UsePN pn = noMerge ** {s = pn.s ; a = agrP3 Sg ; isPron = False} ;

    UsePron pron = pron ** {
      s = table {NPNom => pron.stressed.nom ; NPAcc => pron.stressed.acc} ;
      isPron = True ;
      } ;

    PredetNP pred np = heavyNP {
      s = \\c => 
        pred.s ! np.a.n ! np.a.g ++ np.s ! c ; ---- g
      a = np.a
      } ;

    PPartNP np v2 = heavyNP {
      s = \\c => np.s ! c ++ v2.s ! VPerf APred ; -- invar part
      a = np.a ;
      } ;

    AdvNP np adv = heavyNP {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    ExtAdvNP np adv = heavyNP {
      s = \\c => np.s ! c ++ embedInCommas adv.s ;
      a = np.a
      } ;

    DetQuantOrd quant num ord = 
      let 
        detQuant = DetQuant quant num ;
        af : Gender -> AForm = \g -> agrAdj g quant.a (NF num.n Nom) ;
      in detQuant ** {
        -- When combined with an ord, don't use the sp form of the quant.
        -- Works the same way in English:
        -- e.g. s="your", sp="yours" -> s,sp="your youngest", not sp="*yours youngest"
        s,sp  = \\g => detQuant.s ! g ++ ord.s ! af g ;

        -- Even if the original quant merges; when you add an ord, it doesn't.
        mergesWithPrep = False
        } ;

    DetQuant quant num = 
      let 
        n = num.n ;
        a = quant.a
      in quant ** {
        s = \\g => quant.s ! num.isNum ! n ! g ++ num.s ;
        sp = \\g => case num.isNum of {
	  False => quant.sp ! n ! g ++ num.s ;
	  True  => quant.s ! True ! n ! g ++ num.s -- to prevent "een 5 …"
	  } ;
        n = n ;
        a = a ;
        } ;

    PossPron p = noMerge ** {
      s  = \\_,n,g => p.stressed.poss ;
      sp = \\n,g => DefArt.s ! True ! n ! g ++ p.substposs ! n ;
      a = Weak
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

    OrdNumeralSuperl n a = {s = \\af => n.s ! NOrd af ++ a.s ! Superl ! af} ;

    DefArt = noMerge ** {
      s = \\_,n,g  => case <n,g> of {<Sg,Neutr> => "het" ; _ => "de"} ;
      sp = \\n,g => "die" ;
      a = Weak
      } ;

    IndefArt = noMerge ** {
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

    MassNP cn = noMerge ** {
      s = \\c => cn.s ! Strong ! NF Sg Nom ;
      a = agrP3 Sg ;
      isPron = False
      } ;

    UseN, UseN2 = \n -> {
      s = \\_ => n.s ;
      g = n.g
      } ;

    ComplN2 f x = {
      s = \\_,nc => f.s ! nc ++ appPrep f.c2 x ;
      g = f.g
      } ;

    ComplN3 f x = {
      s = \\nc => f.s ! nc ++ appPrep f.c2 x ;
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
               let gan : Gender*Adjf*NForm = case ap.isPre of {
                    True  => <g,a,n> ;
                    False => <Neutr,Strong,NF Sg Nom> } ;
                   af = agrAdj gan.p1 gan.p2 gan.p3 ;
               in preOrPost ap.isPre
                    (ap.s ! agrP3 Sg ! af)
                    (cn.s ! a ! n) ;
        g = g
        } ;

    RelCN cn rs = {
      s = \\a,nc => cn.s ! a ! nc ++ rs.s ! cn.g ! (case nc of {NF n c => n}) ;
      g = cn.g
      } ;

    RelNP np rs = heavyNP {
      s = \\c => np.s ! c ++ embedInCommas (rs.s ! np.a.g ! np.a.n) ;
      a = np.a
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

    PossNP cn np = {
      s = \\a,nc => cn.s ! a ! nc ++ "van" ++ np.s ! NPNom ;
      g = cn.g
      } ;

}
