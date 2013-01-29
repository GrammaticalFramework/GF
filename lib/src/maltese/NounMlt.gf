-- NounMlt.gf: noun phrases and nouns
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

concrete NounMlt of Noun = CatMlt ** open ResMlt, Prelude in {

  flags
    optimize=noexpand ;

  lin
    -- Det -> CN -> NP
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! numnum2nounnum det.n ; 
      a = case (numnum2nounnum det.n) of {
	Singular _ => mkAgr cn.g Sg P3 ;
	_ => mkAgr cn.g Pl P3
      } ;
      isPron = False ;
    } ;

    -- Quant -> Num -> Det
    DetQuant quant num = {
      s  = quant.s ! num.hasCard ! num.n ++ num.s ! NumNominative;
      n  = num.n ;
      hasNum = num.hasCard
    } ;

    -- Quant
    DefArt = {
      s  = \\hasCard,n => artDef ;
    } ;
    IndefArt = {
      s  = \\hasCard,n => artIndef ;
    } ;

    -- PN -> NP
    UsePN pn = {
      s = \\c => pn.s ;
      a = pn.a ;
      isPron = False ;
      } ;

    -- Pron -> NP
    UsePron p = {
      -- s = \\npcase => (p.s ! Personal).c1 ;
      s = table {
        Nom => (p.s ! Personal).c1 ;
        CPrep => (p.s ! Suffixed Acc).c1
        } ;
      a = p.a ;
      isPron = True ;
      } ;

    -- Num
    NumSg = {s = \\c => []; n = Num_Sg ; hasCard = False} ;
    NumPl = {s = \\c => []; n = Num_Pl ; hasCard = False} ;

    -- N -> CN
    UseN n = n ;

    -- N2 -> CN
    UseN2 n = n ;

-- Card
-- CN
-- Det
-- NP
-- Num
-- Ord

}
