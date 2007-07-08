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

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPastPart APred ; --- invar part
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
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
        n = num.n ;
        a = quant.a
      in {
        s = \\g,c => quant.s ! g ! c ++ 
                     num.s ++ ord.s ! agrAdj g (adjfCase a c) n c ;
        n = n ;
        a = a
        } ;

    SgQuant q = {
      s = q.s ! Sg ;
      a = q.a
      } ;
    PlQuant q = {
      s = q.s ! Pl ;
      a = q.a
      } ;

    PossPron p = {
      s = \\n,g,c => p.s ! NPPoss (gennum g n) c ;
      a = Strong --- need separately weak for Pl ?
      } ;

    NoNum = {s = []; n = Pl } ; 
    NoOrd = {s = \\_ => []} ;

    NumInt n = {s = n.s; n = table (Predef.Ints 1 * Predef.Ints 9) {
			        <0,1>  => Sg ;
				_ => Pl
			   } ! <1,2> ---- parser bug (AR 2/6/2007) <n.size,n.last>
      } ;
    OrdInt n = {s = \\_   => n.s ++ "."} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n } ;
    OrdNumeral numeral = {s = \\af => numeral.s ! NOrd af} ;

    AdNum adn num = {s = adn.s ++ num.s; n = num.n } ;

    OrdSuperl a = {s = a.s ! Superl} ;

    DefArt = {
      s = \\n,g,c => artDef ! gennum g n ! c ; 
      a = Weak
      } ;

    IndefArt = {
      s = table {
        Sg => \\g,c => "ein" + pronEnding ! GSg g ! c ;  
        Pl =>  \\_,_ => []
        } ; 
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
