concrete NounEng of Noun = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! det.n ! c ; 
      a = agrP3 det.n
      } ;

    UsePN pn = pn ** {a = agrP3 Sg} ;
    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPPart ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetSg quant ord = {
      s = quant.s ! Sg ++ ord.s ; 
      n = Sg
      } ;

    DetPl quant num ord = {
      s = quant.s ! num.n ++ num.s ++ ord.s ; 
      n = num.n
      } ;

    DetSgNP quant ord = {
      s = \\c => quant.s ! Sg ++ ord.s ; ---- case 
      a = agrP3 Sg
      } ;

    DetPlNP quant num ord = {
      s = \\c => quant.s ! num.n ++ num.s ++ ord.s ; ---- case
      a = agrP3 num.n
      } ;

    ArtQuant q = q ;

    PossPron p = {s = \\_ => p.s ! Gen} ;

    NoNum = {s = []; n = Pl } ;
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

    OrdSuperlNP a = {
      s = \\c => "the" ++ a.s ! AAdj Superl ; ---- case
      a = agrP3 Sg
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

    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;

    AdjCN ap cn = {
      s = \\n,c => preOrPost ap.isPre (ap.s ! agrP3 n) (cn.s ! n ! c)
      } ;
    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;
    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s} ;

    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s} ;

    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! c} ;

}
