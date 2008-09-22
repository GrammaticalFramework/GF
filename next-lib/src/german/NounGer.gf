concrete NounGer of Noun = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ cn.s ! adjfCase det.a c ! det.n ! c ;
      a = agrP3 det.n ;
      isPron = False
      } ;

    DetNP det = {
      s = \\c => det.s ! Neutr ! c ; ---- genders
      a = agrP3 det.n ;
      isPron = False
      } ;

    UsePN pn = pn ** {a = agrP3 Sg} ;

    UsePron pron = {
      s = \\c => pron.s ! NPCase c ;
      a = pron.a
      } ;

    PredetNP pred np = {
      s = \\c => pred.s ! np.a.n ! Masc ! c ++ np.s ! c ; ---- g
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPastPart APred ; --- invar part
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
        s  = \\g,c => quant.s ! num.isNum ! n ! g ! c ++ 
                      num.s!g!c ++ ord.s ! agrAdj g (adjfCase a c) n c ;
        sp = \\g,c => quant.sp ! n ! g ! c ++ 
                      num.s!g!c ++ ord.s ! agrAdj g (adjfCase a c) n c ;
        n = n ;
        a = a
        } ;

    DetQuant quant num = 
      let 
        n = num.n ;
        a = quant.a
      in {
        s = \\g,c => quant.s ! num.isNum ! n ! g ! c ++ num.s!g!c ;
        sp = \\g,c => quant.sp ! n ! g ! c ++ num.s!g!c ;
        n = n ;
        a = a
        } ;


    PossPron p = {
      s  = \\_,n,g,c => p.s ! NPPoss (gennum g n) c ;
      sp = \\n,g,c => p.s ! NPPoss (gennum g n) c ;
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
      s = \\_,n,g,c => artDef ! gennum g n ! c ; 
      sp = \\n,g,c   => artDef ! gennum g n ! c ;  ---- deren, denem...
      a = Weak
      } ;

    IndefArt = {
      s = table {
        True => \\_,_,_ => [] ; 
        False => table {
          Sg => \\g,c => "ein" + pronEnding ! GSg g ! c ;  
          Pl =>  \\_,_ => []
          }
        } ; 
      sp = \\_,g,c => "ein" + pronEnding ! GSg g ! c ; ---- plural ; einer  
      a = Strong
      } ;

    MassNP cn = {
      s = \\c => cn.s ! adjfCase Strong c ! Sg ! c ;
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
      s = \\c => np.s ! c ++ "," ++ rs.s ! gennum np.a.g np.a.n ;
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
      s = \\a,n,c => cn.s ! a ! n ! c ++ np.s ! c ;
      g = g ;
      isMod = cn.isMod
      } ;

}
