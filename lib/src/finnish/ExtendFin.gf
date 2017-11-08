--# -path=.:../common:../abstract

concrete ExtendFin of Extend =
  CatFin ** ExtendFunctor - [
    VPI2,VPS2,MkVPS2,ConjVPS2,ComplVPS2,MkVPI2,ConjVPI2,ComplVPI2,ComplVPIVV
    ,ExistCN, ExistMassCN
    ]
  with
    (Grammar = GrammarFin) **

  open
    GrammarFin,
    ResFin,
    (S=StemFin),
    IdiomFin,
    Coordination,
    Prelude,
    MorphoFin,
    ParadigmsFin in {

lin
   ExistCN cn =
      let
         pos = ExistNP (DetCN (DetQuant IndefArt NumSg) cn) ;
         neg = ExistNP (partCN cn) ;
      in posNegClause pos neg ;
   ExistMassCN cn = ExistNP (partCN cn) ;

oper
    partCN : CN -> GrammarFin.NP ;
    partCN cn = 
      let 
        acn = DetCN (DetQuant IndefArt NumSg) cn
      in acn ** {
        s = table {
          NPCase Nom | NPAcc => acn.s ! NPCase ResFin.Part ;
          c => acn.s ! c
          }
	} ; 


  lincat
    VPS   = {s : Agr => Str } ;
    [VPS] = {s1,s2 : Agr => Str } ; 
    VPI   = {s : VVType => Agr => Str ; sc : SubjCase } ;     -- Agr needed for possessive suffix:
    [VPI] = {s1,s2 : VVType => Agr => Str ; sc : SubjCase } ; -- e.g. toivon nukkuva+ni

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;
    
    BaseVPI = twoTable2 VVType Agr ;
    ConsVPI = consrTable2 VVType Agr comma ;

    MkVPS t p vp = mkVPS t p (lin VP vp) ;
    ConjVPS c xs = conjunctDistrTable Agr c xs  ;
    PredVPS np vps = {s = np.s ! npNom ++ vps.s ! np.a} ;

    
    MkVPI vp = mkVPI vp ;
    ConjVPI c xs = conjunctDistrTable2 VVType Agr c xs ;
    ComplVPIVV vv vpi = 
      S.insertObj (\\_,_,a => vpi.s ! vv.vi ! a)
                  (S.predV (vv ** {sc = case vpi.sc of {
                                         SCNom => vv.sc ;  -- minun täytyy pestä auto
                                         c     => c }})   -- minulla täytyy olla auto
                  ) ;


-------- two-place verb conjunction

  lincat
    -- Polarity needed to pick the right object case
    VPS2   = {s : Agr => Str ; c2 : Compl ; p : Polarity } ; 
    [VPS2] = {s1,s2 : Agr => Str ; c2 : Compl ; p : Polarity } ; 
    -- A version with
    VPI2   = {s : VVType => Agr => Str ; c2 : Compl ; sc : SubjCase } ;
    [VPI2] = {s1,s2 : VVType => Agr => Str ; c2 : Compl ; sc : SubjCase } ;

  lin
    -- : Temp -> Pol -> VPSlash -> VPS2 ;  -- has loved
    MkVPS2 t p vpsl = mkVPS t p (lin VP vpsl) ** {c2 = vpsl.c2 ; p = p.p } ;

    -- : VPSlash -> VPI2 ;                 -- to love
    MkVPI2 vpsl = mkVPI (lin VP vpsl) ** {c2 = vpsl.c2} ;

    BaseVPS2 x y = twoTable Agr x y ** {c2 = y.c2 ; p = xs.p } ; ---- just remembering the compl. case of the latter verb
    ConsVPS2 x xs = consrTable Agr comma x xs ** {c2 = xs.c2 ; p = xs.p } ;
	
    BaseVPI2 x y = twoTable2 VVType Agr x y ** {c2 = y.c2} ; ---- just remembering the compl. case of the latter verb
    ConsVPI2 x xs = consrTable2 VVType Agr comma x xs ** {c2 = xs.c2} ;


    ConjVPS2 c xs = conjunctDistrTable Agr c xs ** {c2 = xs.c2 ; p = xs.p } ;
    ConjVPI2 c xs = conjunctDistrTable2 VVType Agr c xs ** {c2 = xs.c2 ; p = xs.p ; sc = xs.sc } ;


                            -- appCompl : Bool -> Polarity -> Compl -> ResFin.NP -> Str 
    ComplVPS2 v np = { s = \\agr => v.s ! agr ++ appCompl True v.p v.c2 np } ;

                                              -- TODO: Version with variable polarity?
    ComplVPI2 v np = v ** { s = \\vt,a => v.s ! vt ! a ++ appCompl True Pos v.c2 np };

oper 
    mkVPS : Temp -> Pol -> VP -> VPS = \tem,pol,vp -> lin VPS {
      s = \\agr => (UseCl tem pol (S.mkClause (\_ -> []) agr vp)).s } ;

    mkVPI : VP -> VPI = \vp -> lin VPI { 
      s = \\vt,agr => S.infVP vp.s.sc Pos agr vp (vvtype2infform vt) ;
      sc = vp.s.sc } ;

}