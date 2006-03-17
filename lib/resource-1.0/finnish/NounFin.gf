concrete NounFin of Noun = CatFin ** open ResFin, Prelude in {

  flags optimize=all_subs ;

  lin

-- The $Number$ is subtle: "nuo autot", "nuo kolme autoa" are both plural
-- for verb agreement, but the noun form is singular in the latter.

    DetCN det cn = 
      let
        n : Number = case det.isNum of {
          True => Sg ;
          _ => det.n
          } ;
        ncase : Case -> NForm = \c -> 
          case <n,c,det.isNum,det.isPoss, det.isDef> of {
            <_, Nom,  True,_,_>  => NCase Sg Part ; -- kolme kytkintä(ni)
            <_, _, True,False,_> => NCase Sg c ;    -- kolmeksi kytkimeksi
            <Pl,Nom,  _,_,False> => NCase Pl Part ; -- kytkimiä
            <_, Nom,_,True,_>    => NPossNom ;      -- kytkime+ni on/ovat...
            <Sg,Gen,_,True,_>    => NPossNom ;      -- kytkime+ni vika
            <Pl,Gen,_,True,_>    => NPossGenPl ;    -- kytkimie+ni viat
            <_, Transl,_,True,_> => NPossTransl n ; -- kytkim(e|i)kse+ni
            <_, Illat,_,True,_>  => NPossIllat n ;  -- kytkim(ee|ii)+ni
 
            _ => NCase n c                          -- kytkin, kytkimen,...
            }
      in {
      s = \\c => let k = npform2case c in
                 det.s1 ! k ++ cn.s ! ncase k ++ det.s2 ; 
      a = agrP3 (case det.isDef of {
            False => Sg ;  -- autoja menee; kolme autoa menee
            _ => det.n
            }) ;
      isPron = False
      } ;

    UsePN pn = {
      s = \\c => pn.s ! npform2case c ; 
      a = agrP3 Sg ;
      isPron = False
      } ;
    UsePron p = p ** {isPron = True} ;

    PredetNP pred np = {
      s = \\c => pred.s ! np.a.n ! npform2case c ++ np.s ! c ;
      a = np.a ;
      isPron = np.isPron  -- kaikki minun - ni
      } ;

    DetSg quant ord = {
      s1 = \\c => quant.s1 ! c ++ ord.s ! Sg ! c ;
      s2 = quant.s2 ; 
      n  = Sg ; 
      isNum = False ; 
      isPoss = quant.isPoss ;
      isDef = False -- doesn't matter with Sg
      } ;

    DetPl quant num ord = {
      s1 = \\c => quant.s1 ! c ++ num.s ! Sg ! c ++ ord.s ! Pl ! c ; 
      s2 = quant.s2 ;
      n = Pl ;
      isNum = num.isNum ;
      isPoss = quant.isPoss ;
      isDef = quant.isDef
      } ;

    SgQuant quant = {
      s1 = quant.s1 ! Sg ; 
      s2 = quant.s2 ; 
      isNum = quant.isNum ; 
      isPoss = quant.isPoss ;
      isDef = quant.isDef -- doesn't matter with Sg
      } ;
    PlQuant quant = {
      s1 = quant.s1 ! Pl ; 
      s2 = quant.s2 ; 
      isNum = quant.isNum ; 
      isPoss = quant.isPoss ;
      isDef = quant.isDef
      } ;

    PossPron p = {
      s1 = \\_,_ => p.s ! NPCase Gen ;
      s2 = BIND ++ possSuffix p.a ;
      isNum = False ;
      isPoss = True ;
      isDef = True  --- "minun kolme autoani ovat" ; thus "...on" is missing
      } ;

    NoNum = {s = \\_,_ => [] ; isNum = False} ;
    NoOrd = {s = \\_,_ => []} ;

    NumInt n = {s = \\_,_ => n.s ; isNum = True} ;
    OrdInt n = {s = \\_,_ => n.s ++ "."} ;

    NumNumeral numeral = {s = \\n,c => numeral.s ! NCard (NCase n c) ; isNum = True} ;
    OrdNumeral numeral = {s = \\n,c => numeral.s ! NOrd  (NCase n c)} ;

    AdNum adn num = {s = \\n,c => adn.s ++ num.s ! n ! c ; isNum = num.isNum} ;

    OrdSuperl a = {s = \\n,c => a.s ! Superl ! AN (NCase n c)} ;

    DefArt = {
      s1 = \\_,_ => [] ; 
      s2 = [] ; 
      isNum,isPoss = False ;
      isDef = True   -- autot ovat
      } ;

    IndefArt = {
      s1 = \\_,_ => [] ; -- Nom is Part in Pl: use isDef in DetCN
      s2 = [] ; 
      isNum,isPoss,isDef = False -- autoja on
      } ;

    MassDet = {
      s1 = \\_ => [] ; --- Nom is Part ?
      s2 = [] ; 
      isNum,isPoss,isDef = False
      } ;

    UseN n = n ;

    UseN2 n = n ;
    UseN3 n = n ;

--- If a possessive suffix is added here it goes after the complements...

    ComplN2 f x = {
      s = \\nf => appCompl True Pos f.c2 x ++ f.s ! nf
      } ;
    ComplN3 f x = {
      s = \\nf => appCompl True Pos f.c2 x ++ f.s ! nf ;
      c2 = f.c3
      } ;

    AdjCN ap cn = {
      s = \\nf => ap.s ! True ! AN nf ++ cn.s ! nf
      } ;

    RelCN cn rs = {s = \\nf => cn.s ! nf ++ rs.s ! agrP3 (numN nf)} ;
    AdvCN cn ad = {s = \\nf => cn.s ! nf ++ ad.s} ;

    SentCN cn sc = {s = \\nf=> cn.s ! nf ++ sc.s} ;

    ApposCN cn np = {s = \\nf=> cn.s ! nf ++ np.s ! NPCase Nom} ; --- luvun x

  oper
    numN : NForm -> Number = \nf -> case nf of {
      NCase n _ => n ;
      _ => Sg ---
      } ;

}
