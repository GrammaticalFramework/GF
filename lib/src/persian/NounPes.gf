concrete NounPes of Noun = CatPes ** open ResPes, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s =  \\_ => case <det.isNum,det.fromPron> of {
                 <False,True> => cn.s ! aEzafa ! det.n ++ det.s ; -- det.n  ;
		 <False,False> => det.s  ++ cn.s ! bEzafa ! det.n ; -- det.n  ;
		 <True,True> => cn.s ! aEzafa ! Sg ++ det.s ;
		 <True,False> =>  det.s ++ cn.s ! bEzafa ! Sg 
		 };
      a = agrPesP3 det.n ;
      animacy = cn.animacy 
      } ;

    UsePN pn = {s = \\_ => pn.s ; a = agrPesP3 Sg ; animacy = pn.animacy } ;
    UsePron p = {s = \\_ => p.s ; a = p.a ; animacy = Animate} ;

    PredetNP pred np = {
      s = \\ez => pred.s ++ np.s ! ez ;
      a = np.a;
      animacy = np.animacy
      } ;

    PPartNP np v2 = {
      s =  \\ez => np.s ! ez ++ partNP (v2.s ! Root1)    ;
      a = np.a ;
      animacy = np.animacy
      } ;

    RelNP np rs = {
	  s = \\ez => np.s ! ez  ++ rs.s ! np.a ;
      a = np.a ;
      animacy = np.animacy
      } ;

    AdvNP np adv = {
      s = \\ez => np.s ! NPC aEzafa ++ adv.s ;
      a = np.a  ;
      animacy = np.animacy
      } ;

    DetQuantOrd quant num ord = {
        s = quant.s ! num.n ++ num.s ++ ord.s ;
	isNum = True;
	fromPron = quant.fromPron ;
      n = num.n
      } ;

    DetQuant quant num = {
        s = quant.s ! num.n ++ num.s;
	isNum = True ; -- this does not work in case of 'these women' but  works in case of 'five women' 
	fromPron = quant.fromPron ;
	  n = num.n 
      } ;

    DetNP det = {
      s = \\_ => det.s  ; ---- case
      a = agrPesP3 det.n ;
      animacy = Inanimate
      } ;

    PossPron p = {s = \\_ => p.ps ; a = p.a ; fromPron = True} ;

    NumSg = {s = [] ; n = Sg} ;
    NumPl = {s = [] ; n = Pl} ;
-- from here
    NumCard n = n ** {hasCard = True} ;

    NumDigits n = {s = n.s ! NCard ; n = n.n} ;
    OrdDigits n = {s = n.s ! NOrd; n = n.n} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd ; n = numeral.n} ;
-- to here
    AdNum adn num = {s = adn.s ++ num.s ; n = num.n} ;

    OrdSuperl a = {s = a.s ! bEzafa ++ taryn; n = Sg} ; -- check the form of adjective

    DefArt = {s = \\_ => [] ; a = defaultAgrPes ; fromPron = False} ;
    IndefArt = {s = \\_ => IndefArticle ; a =defaultAgrPes ; fromPron = False} ;

    MassNP cn = {s =\\c => case c of {
      NPC bEzafa => cn.s ! bEzafa ! Sg ;
      NPC aEzafa => cn.s ! aEzafa ! Sg ;
      NPC enClic => cn.s ! enClic ! Sg 
      };
      a = agrPesP3 Sg ;
      animacy = cn.animacy
      } ;

    UseN n = n ;
    UseN2 n = n ;
 
    Use2N3 f = {
      s = f.s;
      c = f.c2;
      animacy = f.animacy;
      definitness = True
      } ;

   Use3N3 f = {
      s = f.s ;
      c = f.c3;
      animacy = f.animacy;
      definitness = True
      } ;

    ComplN2 f x = {
      s = \\ez,n => f.s ! ez ! n  ++ f.c ++ x.s ! NPC ez ;
      animacy = f.animacy;
      definitness = True
	   };
    ComplN3 f x = {
      s = \\ez,n => f.s ! ez ! n ++ f.c2 ++ x.s ! NPC ez ; 
      c = f.c3;
      animacy = f.animacy;
      definitness = True;
      } ;

    AdjCN ap cn = {
      s = \\ez,n =>  cn.s ! aEzafa ! n ++ ap.s ! ez; -- check the form of adjective and also cn.s!ez!n changed from cn.s!aEzafa!n to have correct enclicitic form other wise it creats wrong enclictic form of old man
      animacy = cn.animacy ;
      definitness = cn.definitness
      } ;

    RelCN cn rs = {
      s = \\ez,n => cn.s ! enClic ! n ++ rs.s ! agrPesP3 n ; 
      animacy = cn.animacy ;
      definitness = cn.definitness
      } ;
      
    AdvCN cn ad = {s = \\ez,n => cn.s ! aEzafa ! n ++ ad.s ; animacy = cn.animacy ; definitness = cn.definitness} ;

    SentCN cn sc = {s = \\ez,n => cn.s ! ez ! n ++ sc.s ; animacy = cn.animacy ; definitness = cn.definitness} ;

    ApposCN cn np = {s = \\ez,n => cn.s ! ez ! n  ++ np.s ! NPC aEzafa ; animacy = cn.animacy ; definitness = True} ; -- ezafa form of city to be used

}
