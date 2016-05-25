--# -path=.:../abstract:../common:../prelude

concrete NounGrc of Noun = CatGrc ** open Prelude, ResGrc, (M = MorphoGrc) in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = { -- different attribute order in ExtraGrc.DetCNpost
      s = \\c => let n = det.n ; g = cn.g 
        in det.s ! g ! c ++ cn.s2 ! n ! c ++ cn.s ! n ! c ++ cn.rel ! n ; 
      isPron = False ; 
      e = \\_ => [] ;
      a = Ag cn.g det.n P3
      } ;

    UsePN pn  = { 
      s = pn.s ; 
      isPron = False ; 
      e = \\c => [] ; 
      a = Ag pn.g pn.n P3 
      } ;

    UsePron pron = { 
      s = table{ c => pron.s ! NPCase Aton c } ; -- for Nom: like ProDrop
      isPron = True ;
      e = table{ c => pron.s ! NPCase Ton c } ; -- emphasized form after prep etc.
      a = pron.a 
      } ;

--    PredetNP pred np = {
--      s = \\c => pred.s ++ np.s ! c ;
--      a = np.a
--      } ;
--
--    PPartNP np v2 = {  -- the man seen
--      s = \\c => np.s ! c ++ v2.s ! VPPart ;
--      a = np.a
--      } ;
--

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      isPron = False ; 
      e = \\c => [] ;
      a = np.a
      } ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
      isPron = False ;
      e = \\c => [] ;
      a = np.a
      } ;

-- Mar 2,2012
-- The sp field is for determiners used as NP's, which are sometimes different
-- from their use as Det's. Omitted for Greek.
{-
    DetNP det = {
      s = \\o => det.s ! Neutr ;
      r = \\agr,c => case agr of {Ag g n p => det.s ! g ! c ++ autos.s ! g ! n ! c}; 
      isPron = False ; 
      e = \\_ => [] ;
      a = Ag Neutr det.n P3
      } ;
-}
    DetQuant quant num = {
      s = \\g,c => quant.s  ! num.n ! g ! c ++ num.s ! g ! c ;
      n = num.n
      } ;

    DetQuantOrd quant num ord = {
      s = \\g,c => quant.s ! num.n ! g ! c ++ num.s !g ! c ++ ord.s ! AF g num.n c ;  -- TODO check
      n = num.n
      } ;

    NumSg = {s = \\_,_ => [] ; n = Sg ; isCard = False} ;
    NumPl = {s = \\_,_ => [] ; n = Pl ; isCard = False} ;
    -- NumDl: in ExtraGrc

    NumCard n = n ** {isCard = True} ;

    -- TODO: check the following two:
    NumDigits digits = let num : Number = case digits.unit of {one => Sg ; _ => Pl}
                        in {s = \\g,c => digits.s ++ "'"; n = num ; isCard = True} ;
    NumNumeral numeral = {s = \\g,c => numeral.s ! NCard g c; n = numeral.n } ;

    AdNum adn num = {s = \\g,c => adn.s ++ num.s ! g ! c ; n = num.n} ;

    OrdDigits digits = {s = \\af => digits.s } ;  
    OrdNumeral numeral = {s = \\af => numeral.s ! NOrd af} ;
    OrdSuperl a = {s = a.s ! Superl} ;

-- Greek has a definite article, but no indefinite article.

    DefArt = {
       s = \\n,g,c => artDef ! g ! n ! c 
       } ;
{-
   -- An empty IndefArt produces empty NPgen-attributes: 
   -- like  (PrepNP part_Prep (DetNP (DetQuant InDefArt NumDl)))
-}
    IndefArt = {
       s = \\n,g,c => []  -- for linearization 
       } ;

    MassNP cn = {
      s = \\c => cn.s2 ! Sg ! c ++ cn.s ! Sg ! c ++ cn.rel ! Sg ;
      isPron = False ;
      e = \\_ => [] ;
      a = agrP3 Sg
      } ;

    -- TODO: the possPron is rather an adjective than a det:
    --       oi emoi agathoi philoi 
    PossPron p = {
      s = \\n,g,c => artDef ! g ! n ! c ++ p.s ! NPPoss g n c ; 
      } ;

--2 Common Nouns
--  We keep the head noun separate in field s, collect attributes in s2, and 
--  relative clauses in rel. (Combine the components properly when using the CN!)

    UseN n = { 
      s = n.s ; 
      s2 = \\n,c => [] ; 
      isMod = False ; 
      rel = \\n => [] ;
      g = n.g 
      } ;

    ComplN2 n2 np = { -- sketch
      s  = n2.s ; 
      s2 = -- noun + (refl) object + indir obj ; -- attribute 
        \\n,c => (appPrep n2.c2 np) ++ n2.obj ! Ag n2.g n P3 ;   
      isMod = True ;
      rel = \\n => [] ;
      g = n2.g
      } ;

    ComplN3 n3 np = {
      s = n3.s ; 
      obj = \\a => (appPrep n3.c2 np) ; -- TODO NPRefl ?
      g = n3.g ;
      c2 = n3.c3
      } ;

--    UseN2 = UseN ;
    UseN2 n2 = { 
      s = \\n,c => n2.s ! n ! c ++ n2.obj ! (Ag n2.g n P3); 
      s2 = \\n,c => [] ;
      isMod = False ; 
      rel = \\n => [] ;
      g = n2.g 
      } ;

    Use2N3 n3 = {
      s = n3.s ;
      g = n3.g ;
      obj = \\a => [] ;
      c2 = n3.c2
      } ;

    Use3N3 n3 = {
      s = n3.s ;
      g = n3.g ;
      obj = \\a => [] ;
      c2 = n3.c3
      } ;

    AdjCN ap cn = {
      s = cn.s ;                            
      s2 = \\n,c => (ap.s ! AF cn.g n c) ++ (cn.s2 ! n ! c) ;   -- attributes
      isMod = True ;
      rel = cn.rel ;
      g = cn.g
      } ;

    RelCN cn rs = {
      s = cn.s ;
      s2 = cn.s2 ;  
      isMod = True ;
      rel = \\n => "," ++ rs.s ! Ag cn.g n P3 ;  -- TODO: ++ (kai) ++ cn.rs 
      g = cn.g
      } ;

    AdvCN cn adv = {
      s = cn.s ;
      s2 = \\n,c => cn.s2 ! n ! c ++ adv.s ;   -- ???
      isMod = True ;
      rel = cn.rel ;
      g = cn.g 
      } ;

    SentCN cn sc = {
      s = \\n,c => cn.s ! n ! c ;
      s2 = \\n,c => cn.s2 ! n ! c ++ sc.s ; -- TODO: use the attribute!                    
      isMod = cn.isMod ; 
      rel = cn.rel ;
      g = cn.g } ;

--   abstract/Noun.gf: city Paris, but possibly overgenerating
--      ApposCN cn np = {s = \\n,c => np.s ! Pre ! c ++ cn.s ! n ! c ;   -- test: epi ton Psaron potamon
--                       s2 = \\n,c => [] ; isMod = cn.isMod ; g = cn.g} ; -- Pythagoras philosophos
-- Better use ExtraGrc.gf: ApposPN, ApposPron 
 
-- BR 67 2: The non-reflexive possessive relation, when expressed by a genitive np (including pron):
{-
    PossNP cn np = {      -- house of mine    -- BR 67 2 a (unemphasized pronoun only)
      s = \\a,n,c => case np.isPron of { 
                       True  => cn.s ! a ! n ! c ++ np.s ! a ! Pre ! Gen ;  -- unemphasized persPron!Gen
                       False => np.s ! a ! Pre ! Gen ++ cn.s ! a ! n ! c } ;
      s2= \\a,n,c => case np.isPron of { True => [] ; -- don't count the unemph.pron as attribute
                                         False => np.s ! a ! Pre ! Gen } ;
      isMod = case np.isPron of { True => cn.isMod ; _ => True } ; 
      rel = cn.rel ;
      g = cn.g
      } ;
-}
          -- BR 67 2a (ensure that the unemphasized pronoun follows then n)
    PossNP cn np = {      -- house of mine    -- BR 67 2 a (unemphasized pronoun only)
      s = \\n,c => cn.s ! n ! c  ++ case <np.isPron, np.a> of { 
        <True,Ag g na p> => (M.mkPersPron g na p) ! Aton ! Gen ; _ => [] } ;
      s2= \\n,c => case <np.isPron, np.a> of { <True,Ag g na p> => [] ;
                                                 _ => np.s ! Gen } ++ cn.s2 ! n ! c ;   
      isMod = True ; 
      rel = cn.rel ;
      g = cn.g
      } ;

-- The reflexive possessive relation, i.e. CN of one's own = eautoy CN, is treated by
-- PossRefl : CN -> CN  in ExtraGrc; note that reflPron is not a Pron or NP.

--    PartNP cn np = :cn    -- glass of wine
--    CountNP det no = :np  -- some of the boys

}
