incomplete concrete NounRomance of Noun =
   CatRomance ** open DiffRomance, ResRomance, Prelude in {

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

    UsePN pn = {
      s = \\c => prepCase (npform2case c) ++ pn.s ; 
      a = agrP3 pn.g Sg ;
      c = Clit0
      } ;

    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => prepCase (npform2case c) ++ pred.s ! np.a ++ np.s ! Ton Acc ;
      a = np.a ;
      c = Clit0
      } ;

    DetSg quant ord = {
      s = \\g,c => quant.s ! g ! c ++ ord.s ! aagr g Sg ;
      n = Sg
      } ;
    DetPl quant num ord = {
      s = \\g,c => quant.s ! g ! c ++ num.s ! g ++ ord.s ! aagr g Sg ;
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

----    NumNumeral numeral = {s = \\g => numeral.s ! NCard g ; isDet = True} ;
----    OrdNumeral numeral = {s = numeral.s ! NOrd SupWeak ; isDet = True} ;

    AdNum adn num = {s = \\a => adn.s ++ num.s ! a} ;

----    OrdSuperl a = {s = a.s ! AF (ASuperl SupWeak) Nom ; isDet = True} ;

    DefSg = {
      s = \\g,c => artDef g Sg c ; 
      n = Sg
      } ;
    DefPl = {
      s = \\g,c => artDef g Sg c ;  
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

{-
    RelCN cn rs = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ rs.s ! agrP3 g n ;
      g = g ;
      isMod = cn.isMod
      } ;
    SentCN  cn sc = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ sc.s ;
      g = g ;
      isMod = cn.isMod
      } ;
    AdvCN  cn sc = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ sc.s ;
      g = g ;
      isMod = cn.isMod
      } ;
-}
}
