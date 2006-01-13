concrete NounGer of Noun = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ cn.s ! adjfCase det.a c ! det.n ! c ;
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

    DetSg quant ord = 
      let 
        n = Sg ;
        a = quant.a
      in {
        s = \\g,c => quant.s ! g ! c ++ 
                     ord.s ! agrAdj g (adjfCase a c) n c ;
        n = n ;
        a = a
        } ;
    DetPl quant num ord = 
      let 
        n = Pl ;
        a = quant.a
      in {
        s = \\g,c => quant.s ! g ! c ++ 
                     num.s ! g ! c ++ ord.s ! agrAdj g (adjfCase a c) n c ;
        n = n ;
        a = a
        } ;

    PossSg p = {
      s = \\g,c => p.s ! NPPoss (gennum g Sg) c ;
      n = Sg ;
      a = Strong
      } ;

    PossPl p = {
      s = \\g,c => p.s ! NPPoss (gennum g Pl) c ;
      n = Pl ;
      a = Weak
      } ;

    NoNum = {s = \\_,_ => []} ; 
    NoOrd = {s = \\_ => []} ;

    NumInt n = {s = \\_,_ => n.s} ;
    OrdInt n = {s = \\_   => n.s ++ "."} ;

    NumNumeral numeral = {s = \\_,_ => numeral.s ! NCard} ;
    OrdNumeral numeral = {s = \\af => numeral.s ! NOrd af} ;

    AdNum adn num = {s = \\g,c => adn.s ++ num.s ! g ! c} ;

    OrdSuperl a = {s = a.s ! Superl} ;

    DefSg = {
      s = \\g,c => artDef ! GSg g ! c ; 
      n = Sg ;
      a = Weak
      } ;
    DefPl = {
      s = \\_,c => artDef ! GPl ! c ; 
      n = Pl ;
      a = Weak
      } ;

    IndefSg = {
      s = \\g,c => "ein" + pronEnding ! GSg g ! c ;  
      n = Sg ;
      a = Strong
      } ;
    IndefPl = {
      s = \\_,_ => [] ; 
      n = Pl ;
      a = Strong
      } ;

    MassDet = {
      s = \\g,c => [] ;
      n = Sg ;
      a = Strong
      } ;


    UseN, UseN2, UseN3 = \n -> {
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

    SentCN cn s = {
      s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ;
      g = cn.g
      } ;

}
