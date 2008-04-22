concrete NounEng of Noun = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! det.n ! c ; 
      a = agrgP3 det.n cn.g
      } ;

    UsePN pn = pn ** {a = agrgP3 Sg pn.g} ;
    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPPart ;
      a = np.a
      } ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetArt quant num ord = {
      s = quant.s ! num.n ++ num.s ++ ord.s ; 
      n = num.n
      } ;

    DetQuant quant num ord = {
      s = \\c => quant.s ! num.n ++ num.s ++ ord.s ; ---- case
      a = agrP3 num.n
      } ;

    ArtQuant q = q ;

    PossPron p = {s = \\_ => p.s ! Gen} ;

    NumSg = {s = []; n = Sg} ;
    NumPl = {s = []; n = Pl} ;
    NoOrd = {s = []} ;

    NumDigits n = {s = n.s ! NCard ; n = n.n} ;

        --table (Predef.Ints 1 * Predef.Ints 9) {
	--		        <0,1>  => Sg ;
	--			_ => Pl  -- DEPRECATED
	--		   } ! <1,2> ---- parser bug (AR 2/6/2007) 
        --                       ---- <n.size,n.last>
        -- } ;

    OrdDigits n = {s = n.s ! NOrd} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;

    AdNum adn num = {s = adn.s ++ num.s; n = num.n } ;

    OrdSuperl a = {s = a.s ! AAdj Superl} ;

    NumNumeralNP num = {
      s = \\c => num.s ! NCard ; ---- case
      a = agrP3 num.n
      } ;

    OrdNumeralNP ord = {
      s = \\c => "the" ++ ord.s ! NOrd ; ---- case
      a = agrP3 Sg
      } ;

    OrdSuperlNP n a = {
      s = \\c => "the" ++ n.s ++ a.s ! AAdj Superl ; ---- case
      a = agrP3 n.n
      } ;

    DefArt = {s = \\_ => artDef} ;

    IndefArt = {
      s = table {
        Sg => artIndef ; 
        Pl => []
        }
      } ;

    MassDet = {s = \\_ => []} ;

    UseN n = n ;
    UseN2 n = n ;
    UseN3 n = n ;

    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; g = f.g} ;
    ComplN3 f x = {
      s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ;
      g = f.g ;
      c2 = f.c3
      } ;

    AdjCN ap cn = {
      s = \\n,c => preOrPost ap.isPre (ap.s ! agrgP3 n cn.g) (cn.s ! n ! c) ;
      g = cn.g
      } ;
    RelCN cn rs = {
      s = \\n,c => cn.s ! n ! c ++ rs.s ! agrgP3 n cn.g ;
      g = cn.g
      } ;
    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s ; g = cn.g} ;

    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g} ;

    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! c ; g = cn.g} ;

}
