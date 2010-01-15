concrete NounUrd of Noun = CatUrd ** open ResUrd, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => detcn2NP det.s cn c det.n  ;
      a = agrP3 cn.g det.n
      } ;

    UsePN pn = {s = \\c => toNP pn.s c ; a = agrP3 pn.g Sg} ;
    UsePron p = {s = \\c => np2pronCase p.s c ; a = p.a} ;

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => v2.s ! VF Imperf Pers1 Sg Fem   ++ np.s ! c   ;
      a = np.a
      } ;

    RelNP np rs = {
	  s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
--      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetQuantOrd quant num ord = {
      s = \\ c => detquant2det quant.s num c  ++ ord.s ; 
      n = Sg
      } ;

   DetQuant quant num = {
      s = \\c => detquant2det quant.s num c; 
	  n = Sg
      } ;

    DetNP det = {
      s = \\c => det2NP det.s c ; ---- case
      a = agrP3 Masc Sg
      } ;

--    PossPron p = {s = \\_,_,_ => p.s ! PPoss} ;
--
--    NumSg = {s = []; n = Sg} ;
--    NumPl = {s = []; n = Pl} ;

--    NumCard n = n ** {hasCard = True} ;
--
--    NumDigits n = {s = n.s ! NCard ; n = n.n} ;
--    OrdDigits n = {s = n.s ! NOrd} ;
--
--    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
--    OrdNumeral numeral = {s = numeral.s ! NOrd} ;
--
--    AdNum adn num = {s = adn.s ++ num.s ; n = num.n} ;
--
--    OrdSuperl a = {s = a.s ! AAdj Superl} ;
--
--    DetArtOrd art num ord = {
--      s = art.s ! num.hasCard ! num.n ++ num.s ++ ord.s ;
--      n = num.n
--      } ;
--
--    DetArtCard art card = {
--      s = art.s ! True ! card.n ++ card.s ;
--      n = card.n
--      } ;

    DetArtSg art cn = {
      s = \\c => art.s ++ toNP (cn.s ! Sg) c ;
      a = agrP3 cn.g Sg
      } ;

    DetArtPl art cn = {
      s = \\c => art.s ++ toNP (cn.s ! Pl) c ;
      a = agrP3 cn.g Pl
      } ;

--      DefArt = {s = []} ;
--      IndefArt = {s = []} ;

    MassNP cn = {s = \\c => toNP (cn.s ! Sg) c ; a = agrP3 cn.g Sg} ;

    UseN n = n ;
    UseN2 n = { s = n.s  ; g = n.g };

    Use2N3 f = {
      s = f.s;
      g = f.g ;
      c2 = f.c2
      } ;

    Use3N3 f = {
      s = f.s ;
      g = f.g ;
      c2 = f.c2
      } ;

--      ComplN2 f x = {s = \\n,c => x.s ! NPC c ++ f.c2! PP (giveNumber x.a)  f.g ++ f.s ! n ! c  ; g = f.g} ;
    ComplN2 f x = {s = \\n,c => case c of {
       Dir => x.s ! NPC c ++ f.c2! PP (giveNumber x.a)  f.g ++ f.s ! n ! c ;
	   Obl => x.s ! NPC c ++ f.c2! PP Pl  f.g ++ f.s ! n ! c ;
	   Voc => x.s ! NPC c ++ f.c2! PP (giveNumber x.a)  f.g ++ f.s ! n ! c 
	   };
	   g = f.g;
	   };
    ComplN3 f x = {
      s = \\n,c =>  x.s ! NPObj ++ f.c3  ++ f.s ! n ! Dir  ;
      g = f.g ;
      c2 = f.c2
      } ;

    AdjCN ap cn = {
      s = \\n,c => ap.s ! n ! cn.g ! c ! Posit ++ cn.s ! n ! c ;
      g = cn.g
      } ;

--    RelCN cn rs = {
--      s = \\n,c => cn.s ! n ! c ++ rs.s ! agrgP3 n cn.g ;
--      g = cn.g
--      } ;
    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s ; g = cn.g} ;
--
--    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g} ;
--
--    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! c ; g = cn.g} ;
--
}
