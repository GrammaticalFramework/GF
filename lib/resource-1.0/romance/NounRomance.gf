incomplete concrete NounRomance of Noun =
   CatRomance ** open CommonRomance, ResRomance, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      let 
        g = cn.g ;
        n = det.n
      in {
        s = \\c => det.s ! g ! npform2case c ++ cn.s ! n ;
        a = agrP3 g n ;
        c = Clit0
        } ;

    UsePN = pn2np ;

    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ! aagr (np.a.g) (np.a.n) ! npform2case c ++  --- subtype
                 np.s ! case2npform pred.c ;
      a = np.a ;
      c = Clit0
      } ;

    DetSg quant ord = {
      s = \\g,c => quant.s ! g ! c ++ ord.s ! aagr g Sg ;
      n = Sg
      } ;
    DetPl quant num ord = {
      s = \\g,c => quant.s ! g ! c ++ num.s ! g ++ ord.s ! aagr g Pl ;
      n = Pl
      } ;

    PossSg p = {
      s = \\g,c => prepCase c ++ p.s ! Poss (aagr g Sg) ; 
      n = Sg
      } ;
    PossPl p = {
      s = \\g,c => prepCase c ++ p.s ! Poss (aagr g Pl) ; 
      n = Pl
      } ;

    NoNum = {s = \\_ => []} ;
    NoOrd = {s = \\_ => []} ;

    NumInt n = {s = \\_ => n.s} ;
    OrdInt n = {s = \\_ => n.s ++ "ème"} ; ---

    NumNumeral numeral = {s = \\g => numeral.s ! NCard g} ;
    OrdNumeral numeral = {s = \\a => numeral.s ! NOrd a.g a.n} ;

    AdNum adn num = {s = \\a => adn.s ++ num.s ! a} ;

    OrdSuperl adj = {s = \\a => adj.s ! Superl ! AF a.g a.n} ;

    DefSg = {
      s = \\g,c => artDef g Sg c ; 
      n = Sg
      } ;
    DefPl = {
      s = \\g,c => artDef g Pl c ;  
      n = Pl
      } ;

    IndefSg = {
      s = \\g,c => artIndef g Sg c ; 
      n = Sg
      } ;
    IndefPl = {
      s = \\g,c => artIndef g Pl c ; 
      n = Pl
      } ;

    MassDet = {
      s = \\g,c => partitive g c ; 
      n = Sg
      } ;

-- This is based on record subtyping.

    UseN, UseN2, UseN3 = \noun -> noun ;

    ComplN2 f x = {
      s = \\n => f.s ! n ++ appCompl f.c2 x.s ;
      g = f.g ;
      } ;
    ComplN3 f x = {
      s = \\n => f.s ! n ++ appCompl f.c2 x.s ;
      g = f.g ;
      c2 = f.c3
      } ;

    AdjCN ap cn = 
      let 
        g = cn.g 
      in {
        s = \\n => preOrPost ap.isPre (ap.s ! (AF g n)) (cn.s ! n) ;
        g = g ;
        } ;

    RelCN cn rs = let g = cn.g in {
      s = \\n => cn.s ! n ++ rs.s ! Indic ! agrP3 g n ; --- mood
      g = g
      } ;
    SentCN  cn sc = let g = cn.g in {
      s = \\n => cn.s ! n ++ sc.s ;
      g = g
      } ;
    AdvCN  cn sc = let g = cn.g in {
      s = \\n => cn.s ! n ++ sc.s ;
      g = g
      } ;

}
