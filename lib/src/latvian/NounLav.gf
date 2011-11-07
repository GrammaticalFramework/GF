concrete NounLav of Noun = CatLav ** open MorphoLav, ResLav, Prelude in {
flags optimize=all_subs ;

  lin

    UseN n   = {s = \\_ => n.s ; g = n.g} ;
	UsePN pn = { s = pn.s ; a = agrgP3 Sg pn.g } ;
	UsePron p = p ;
	
    PredetNP pred np = {
      s = \\c => pred.s ! (fromAgr np.a).g ++ np.s ! c ;
      a = np.a
    } ;

	UseN2 n = {s = \\_ => n.s ; g = n.g};
	UseN3 n = n;
	
    ComplN2 f x = {
		s = \\_,n,c => preOrPost f.isPre (f.p.s ++ x.s ! (f.p.c ! (fromAgr x.a).n)) (f.s ! n ! c); 
		g = f.g
	} ;
    ComplN3 f x = {
	  s = \\n,c => preOrPost f.isPre1 (f.p1.s ++ x.s ! (f.p1.c ! (fromAgr x.a).n)) (f.s ! n ! c);
      g = f.g ;
      p = f.p2 ;
	  isPre = f.isPre2
    } ;
	Use2N3 n = { s = n.s ; g = n.g ; p = n.p1 ; isPre = n.isPre1 };
	Use3N3 n = { s = n.s ; g = n.g ; p = n.p2 ; isPre = n.isPre2 };
	  
    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
    } ;	
    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
      a = np.a
    } ;  
	
	DetCN det cn = {
		s = \\c => det.s ! cn.g ! c ++ cn.s ! det.d ! det.n ! c ;
		a = AgP3 det.n cn.g;
	} ;
	
    DetQuant quant num = {
      s  = \\g,c => quant.s ! g ! num.n ! c ++ num.s ! g ! c;
	  n = num.n ;
	  d = quant.d  --FIXME - ja ir kârtas skaitïa vârds, tad tikai noteiktâs formas drîkst bût
	} ;
	
    DetQuantOrd quant num ord = {
      s  = \\g,c => quant.s ! g ! num.n ! c ++ num.s ! g ! c ++ ord.s ! g ! c;       
      n  = num.n;
	  d  = quant.d  --FIXME - ja ir kârtas skaitïa vârds, tad tikai noteiktâs formas drîkst bût
    } ;

	DetNP det = {
      s = \\c => det.s ! Masc ! c ;  
      a = AgP3 det.n Masc
    } | { 
      s = \\c => det.s ! Fem ! c ;  
      a = AgP3 det.n Fem	
	};
	 	
    AdjCN ap cn = {
		s = \\d,n,c => ap.s ! d ! cn.g ! n ! c ++ cn.s ! d ! n ! c ;
		g = cn.g
    } ;
	
	DefArt = {
		s = \\_,_,_ =>[];
		d = Def
	} ;
	
	IndefArt = {
		s = \\_,_,_ => [];
		d = Indef
	} ;
	
    PossPron p = {
      s = p.possessive ;
	  d = Def ;
    } ;

    MassNP cn = {
      s = cn.s ! Indef ! Sg ;   -- FIXME a 'ðis alus'? der tak gan 'zaïð alus' gan 'zaïais alus'
      a = AgP3 Sg cn.g
      } ;	
	
    NumSg = {s = \\_,_ => []; n = Sg ; hasCard = False} ;
    NumPl = {s = \\_,_ => []; n = Pl ; hasCard = False} ;
	
	NumCard n = n ** {hasCard = True} ;

    NumDigits n = {s = \\g,c => n.s ! NCard ; n = n.n} ;
    OrdDigits n = {s = \\g,c => n.s ! NOrd} ;
	
	NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;
	
    OrdSuperl a = {s = \\g,c => a.s ! (AAdj Superl Def g Sg c) } ;
	
	AdNum adn num = {s = \\g,c => adn.s ++ num.s!g!c ; n = num.n; hasCard = num.n} ;

    AdvCN cn ad = {s = \\d,n,c => cn.s ! d ! n ! c ++ ad.s ; g = cn.g} ;

    ApposCN cn np = {                    -- 'Pielikums'
		s = \\d,n,c => case (fromAgr np.a).n of {
			n => cn.s ! d ! n ! c ++ np.s ! c; -- FIXME - comparison not working
			_ => NON_EXISTENT };
		g = cn.g
	} ; 

    RelCN cn rs = {
      s = \\d, n,c => cn.s ! d ! n ! c ++ "," ++ rs.s ! AgP3 n cn.g ;
      g = cn.g
    } ;

	-- FIXME - placeholder
	SentCN cn sc = {s = \\_,_,_ => NON_EXISTENT ; g = cn.g};
	PPartNP np v2 = {s = \\_ => NON_EXISTENT ; a = np.a};
	
{-
     TODO - ðim vajag -ts -ta divdabjus (+ noteiktâs formas tiem)
    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPPart ;
      a = np.a
      } ;

    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g} ;

-}
}
