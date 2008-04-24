incomplete concrete NounRomance of Noun =
   CatRomance ** open CommonRomance, ResRomance, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      let 
        g = cn.g ;
        n = det.n
      in {
        s = \\c => let cs = npform2case c in 
              det.s ! g ! cs ++ cn.s ! n ;
        a = agrP3 g n ;
        hasClit = False
        } ;

    UsePN = pn2np ;

    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ! aagr (np.a.g) (np.a.n) ! npform2case c ++  --- subtype
                 np.s ! case2npform pred.c ;
      a = np.a ;
      hasClit = False
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPart np.a.g np.a.n ;
      a = np.a ;
      hasClit = False
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a ;
      hasClit = False
      } ;

{---b
    DetSg quant ord = {
      s = \\g,c => quant.s ! False ! Sg ! g ! c ++ ord.s ! aagr g Sg ;
      n = Sg
      } ;
    DetPl quant num ord = {
      s = \\g,c => quant.s ! num.isNum ! num.n ! g ! c ++ num.s ! g ++ 
                   ord.s ! aagr g Pl ;
      n = num.n
      } ;
-}

    PossPron p = {
      s = \\n,g,c => possCase g n c ++ p.s ! Poss (aagr g n) ---- il mio!
      } ;

    NumSg = {s = \\_ => [] ; isNum = False ; n = Sg} ;
    NumPl = {s = \\_ => [] ; isNum = False ; n = Pl} ;
---b    NoNum = {s = \\_ => [] ; isNum = False ; n = Pl} ;
---b    NoOrd = {s = \\_ => []} ;

---b    NumInt n = {s = \\_ => n.s ; isNum = True ; n = Pl} ;
---b    OrdInt n = {s = \\_ => n.s ++ "."} ; ---

    NumDigits nu = {s = \\g => nu.s ! NCard g ; isNum = True ; n = nu.n} ;
    OrdDigits nu = {s = \\a => nu.s ! NOrd a.g a.n} ;

    NumNumeral nu = {s = \\g => nu.s ! NCard g ; isNum = True ; n = nu.n} ;
    OrdNumeral nu = {s = \\a => nu.s ! NOrd a.g a.n} ;

    AdNum adn num = {s = \\a => adn.s ++ num.s ! a ; isNum = num.isNum ; n = num.n} ;

    OrdSuperl adj = {s = \\a => adj.s ! Superl ! AF a.g a.n} ;

    DefArt = {
      s = \\_,n,g,c => artDef g n c
      } ;

    IndefArt = {
      s = \\b,n,g,c => if_then_Str b [] (artIndef g n c) ;
      } ;

{---b
    MassDet = {
      s = \\b,n,g,c => case <b,n> of {
        <False,Sg> => partitive g c ;
        _ => prepCase genitive ----
        }
      } ;
-}

-- This is based on record subtyping.

    UseN, UseN2 = \noun -> noun ;
---b    UseN3 = \noun -> noun ;

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

    ApposCN  cn np = let g = cn.g in {
      s = \\n => cn.s ! n ++ np.s ! Ton Nom ;
      g = g
      } ;

}
