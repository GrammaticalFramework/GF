concrete IdiomIta of Idiom = CatIta ** 
  open (P = ParamX), PhonoIta, MorphoIta, BeschIta, ParadigmsIta, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause [] True (agrP3 Masc Sg) vp ;

    GenericCl vp = 
      mkClause [] True (agrP3 Masc Sg) (insertRefl vp) ;

    CleftNP np rs = mkClause [] True (agrP3 Masc Sg) 
      (insertComplement (\\_ => rs.s ! Indic ! np.a)
        (insertComplement (\\_ => np.s ! Ton rs.c) (predV copula))) ;

    CleftAdv ad s = mkClause [] True (agrP3 Masc Sg) 
      (insertComplement (\\_ => conjThat ++ s.s ! Indic)
        (insertComplement (\\_ => ad.s) (predV copula))) ;

    ExistNP np = 
      mkClause [] True (agrP3 np.a.g np.a.n) 
        (insertClit2 (elision "ci" "c'" "ci") 
          (insertComplement (\\_ => np.s ! Ton Nom) 
            (predV copula))) ;

    ExistIP ip = {
      s = \\t,a,p,_ =>
        ip.s ! Nom ++ 
        (mkClause [] True (agrP3 ip.a.g ip.a.n) 
           (insertClit2 (elision "ci" "c'" "ci") 
              (predV copula))).s ! DDir ! t ! a ! p ! Indic
      } ;

    ProgrVP vpr =
      let vp = useVP vpr in 
      insertComplement 
        (\\agr => 
           let 
             clpr = pronArg agr.n agr.p vp.clAcc vp.clDat ;
             obj  = clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
           in
           (vp.s ! VPGerund).inf ! (aagr agr.g agr.n) ++ clpr.p1 ++ obj
        )
        (predV (essereV (verboV (stare_16 "stare")))) ;

    ImpPl1 vpr = let vp = useVP vpr in {s =
      (mkImperative False P1 vp).s ! Pos ! {n = Pl ; g = Masc} --- fem
      } ;

}

