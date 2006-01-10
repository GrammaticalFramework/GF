incomplete concrete NounScand of Noun =
   CatScand ** open DiffScand, ResScand, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = let g = cn.g in {
      s = \\c => det.s ! g ++ cn.s ! det.n ! det.det ! caseNP c ; 
      a = agrP3 g det.n
      } ;
    UsePN pn = {
      s = \\c => pn.s ! caseNP c ; 
      a = agrP3 pn.g Sg
      } ;

    UsePron p = p ;

    DetSg pred quant ord = {
      s = \\g => pred.s ! gennum g Sg ++ quant.s ! g ++ ord.s ; 
      n = Sg ;
      det = quant.det
      } ;
    DetPl pred quant num ord = {
      s = \\g => pred.s ! gennum g Pl ++ quant.s ! g ++ num.s ! g ++ ord.s ; 
      n = Pl ;
      det = quant.det
      } ;

    PossSg p = {
      s = \\g => p.s ! NPPoss (gennum g Sg) ; 
      n = Sg ;
      det = DDef Indef
      } ;
    PossPl p = {
      s = \\_ => p.s ! NPPoss Plg ; 
      n = Pl ;
      det = DDef Indef
      } ;

    NoPredet, NoNum = {s = \\_ => []} ; -- these get different types!
    NoOrd = {s = []} ;

    NumInt n = {s = \\_ => n.s} ;
    OrdInt n = {s = n.s ++ ":e"} ; ---

    NumNumeral numeral = {s = \\g => numeral.s ! NCard g} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd SupWeak} ;

    AdNum adn num = {s = \\g => adn.s ++ num.s ! g} ;

    OrdSuperl a = {s = a.s ! AF (ASuperl SupWeak) Nom} ;

    DefSg = {s = \\g => artDef (gennum g Sg) ; n = Sg ; det = DDef detDef} ;
    DefPl = {s = \\_ => artDef Plg           ; n = Pl ; det = DDef detDef} ;

    IndefSg = {s = artIndef  ; n = Sg ; det = DIndef} ;
    IndefPl = {s = \\_ => [] ; n = Pl ; det = DIndef} ;

    MassDet = {s = \\_ => [] ; n = Sg ; det = DIndef} ;

    UseN, UseN2, UseN3 = \noun -> {
      s = \\n,d => noun.s ! n ! specDet d ;
      g = noun.g
      } ;

-- The genitive of this $NP$ is not correct: "sonen till mig" (not "migs").

    ComplN2 f x = {
      s = \\n,d,c => f.s ! n ! specDet d ! Nom ++ f.c2 ++ x.s ! accusative ;
      g = f.g
      } ;
    ComplN3 f x = {
      s = \\n,d,c => f.s ! n ! d ! Nom ++ f.c2 ++ x.s ! accusative ; 
      g = f.g ;
      c2 = f.c3
      } ;

    AdjCN ap cn = let g = cn.g in {
      s = \\n,d,c => preOrPost ap.isPre 
             (ap.s ! agrAdj (gennum g n) d) 
             (cn.s ! n ! d ! c) ;
      g = g
      } ;

    RelCN cn rs = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ rs.s ! agrP3 g n ;
      g = g
      } ;
    SentCN  cn sc = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ sc.s ;
      g = g
      } ;

}
