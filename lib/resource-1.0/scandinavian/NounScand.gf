incomplete concrete NounScand of Noun =
   CatScand ** open CommonScand, ResScand, Prelude in {

  flags optimize=all_subs ;

-- The rule defines $Det Quant Num Ord CN$ where $Det$ is empty if
-- it is the definite article ($DefSg$ or $DefPl$) and both $Num$ and
-- $Ord$ are empty and $CN$ is not adjectivally modified
-- ($AdjCN$). Thus we get $huset$ but $de fem husen$, $det gamla huset$.

  lin
    DetCN det cn = let g = cn.g in {
      s = \\c => det.s ! cn.isMod ! g ++
                 cn.s ! det.n ! det.det ! caseNP c ; 
      a = agrP3 g det.n
      } ;

    UsePN pn = {
      s = \\c => pn.s ! caseNP c ; 
      a = agrP3 pn.g Sg
      } ;

    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ! np.a.gn ++ np.s ! c ;
      a = np.a
      } ;

    DetSg quant ord = {
      s = \\b,g => quant.s ! (orB b ord.isDet) ! g ++ ord.s ;
      n = Sg ;
      det = quant.det
      } ;
    DetPl quant num ord = {
      s = \\b,g => quant.s ! (orB b (orB num.isDet ord.isDet)) ! g ++ 
                   num.s ! g ++ ord.s ;
      n = Pl ;
      det = quant.det
      } ;

    SgQuant quant = {
      s = quant.s ! Sg ;
      n = Sg ;
      det = quant.det
      } ;
    PlQuant quant = {
      s = quant.s ! Pl ;
      n = Pl ;
      det = quant.det
      } ;

    PossPron p = {
      s = \\n,_,g => p.s ! NPPoss (gennum g n) ; 
      det = DDef Indef
      } ;

    NoNum = {s = \\_ => [] ; isDet = False} ;
    NoOrd = {s = [] ; isDet = False} ;

    NumInt n = {s = \\_ => n.s ; isDet = True} ;
    OrdInt n = {s = n.s ++ ":e" ; isDet = True} ; ---

    NumNumeral numeral = {s = \\g => numeral.s ! NCard g ; isDet = True} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd SupWeak ; isDet = True} ;

    AdNum adn num = {s = \\g => adn.s ++ num.s ! g ; isDet = True} ;

    OrdSuperl a = {s = a.s ! AF (ASuperl SupWeak) Nom ; isDet = True} ;

    DefArt = {
      s = \\n,b,g => if_then_Str b (artDef (gennum g n)) [] ; 
      det = DDef detDef
      } ;

    IndefArt = {
      s = table {
        Sg => \\_ => artIndef ; 
        Pl => \\_,_ => []
        } ; 
      det = DIndef
      } ;

    MassDet = {s = \\_,_ => [] ; n = Sg ; det = DIndef} ;

    UseN, UseN2, UseN3 = \noun -> {
      s = \\n,d => noun.s ! n ! specDet d ;
      g = noun.g ;
      isMod = False
      } ;

-- The genitive of this $NP$ is not correct: "sonen till mig" (not "migs").

    ComplN2 f x = {
      s = \\n,d,c => f.s ! n ! specDet d ! Nom ++ f.c2 ++ x.s ! accusative ;
      g = f.g ;
      isMod = False
      } ;
    ComplN3 f x = {
      s = \\n,d,c => f.s ! n ! d ! Nom ++ f.c2 ++ x.s ! accusative ; 
      g = f.g ;
      c2 = f.c3 ;
      isMod = False
      } ;

    AdjCN ap cn = let g = cn.g in {
      s = \\n,d,c => preOrPost ap.isPre 
             (ap.s ! agrAdj (gennum g n) d) 
             (cn.s ! n ! d ! c) ;
      g = g ;
      isMod = True
      } ;

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

}
