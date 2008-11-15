incomplete concrete AttemptoI of Attempto = SymbolsC ** open 
  Syntax, 
  Symbolic,
  Prelude,
  LexAttempto 
in {

lincat CN = Syntax.CN ;
lincat NP = Syntax.NP ;
lincat Card = Syntax.Card ;
lincat Numeral = Syntax.Numeral ;
lincat PN = Syntax.PN ;
lincat A = Syntax.A ;
lincat A2 = Syntax.A2 ;
lincat AP = Syntax.AP ;
lincat RS = Syntax.RS ;
lincat Pron = Syntax.Pron ;
lincat Prep = Syntax.Prep ;
lincat S = Syntax.S ;
lincat VP = Syntax.VP ;
lincat V = Syntax.V ;
lincat VS = Syntax.VS ;
lincat V2 = Syntax.V2 ;
lincat V3 = Syntax.V3 ;
lincat Adv = Syntax.Adv ;
lincat Conj = Syntax.Conj ;
lincat IP = Syntax.IP ;
lincat IAdv = Syntax.IAdv ;
lincat QS = Syntax.QS ;
lincat Text = Syntax.Text ;
lincat ACEText = Syntax.Text ;
lincat RP = Syntax.RP ;

lincat MCN = Syntax.CN ;
lincat PP = Adv ;

lin aNP = mkNP a_Art ;
lin theNP = mkNP the_Art ;
lin cardNP d = mkNP d ;
lin noNP = mkNP no_Quant ;
lin everyNP = mkNP every_Det ;
lin eachNP = mkNP each_Det ;
lin notEveryNP cn = mkNP not_Predet (mkNP every_Det cn) ;
lin notEachNP cn = mkNP not_Predet (mkNP each_Det cn) ;
lin theCollNP = mkNP the_Art plNum ;
lin someCollNP = mkNP somePl_Det ;
lin allCollNP cn = mkNP all_Predet (mkNP a_Art plNum cn) ;

lin noCollNP = mkNP no_Quant plNum ;
lin eachTheNP cn = mkNP (mkNP each_Det) (mkAdv part_Prep (mkNP the_Art plNum cn)) ;
lin eachSomeNP cn = mkNP (mkNP each_Det) (mkAdv part_Prep (mkNP somePl_Det cn)) ;
lin eachNumNP ca cn = mkNP (mkNP each_Det) (mkAdv part_Prep (mkNP ca cn)) ;

lin someMassNP = mkNP someSg_Det ;
lin allMassNP cn = mkNP all_Predet (mkNP cn) ;

lin noMassNP = mkNP no_Quant ;
lin notAllMassNP cn = mkNP not_Predet (mkNP all_Predet (mkNP cn)) ; 

lin one_Card = mkCard n1_Numeral ;
lin two_Card = mkCard n2_Numeral ;
lin five_Card = mkCard n5_Numeral ;
lin ten_Card = mkCard n10_Numeral ;

lin pnNP = mkNP ;
lin intNP = symb ;
lin floatNP = symb ;

lin it_NP = mkNP it_Pron ;
lin he_NP = mkNP he_Pron ;
lin she_NP = mkNP she_Pron ;
lin he_she_NP = mkNP slash_Conj (mkNP he_Pron) (mkNP she_Pron) ;
lin they_NP = mkNP they_Pron ;

lin conjNP = mkNP and_Conj ;
lin adjCN = mkCN ;

--lin someone_NP : NP ;
lin somebody_NP = Syntax.somebody_NP ;
lin something_NP = Syntax.something_NP ;
--lin noone_NP : NP ;
lin nobody_NP = Syntax.nobody_NP ;
lin nothing_NP = Syntax.nothing_NP ;
--lin not_everyoneNP : NP ;
lin not_everybodyNP = mkNP not_Predet Syntax.everybody_NP ;
lin not_everythingNP = mkNP not_Predet Syntax.everything_NP ;

lin at_leastNP ca = mkNP (mkCard at_least_AdN ca) ;
lin not_at_leastNP ca cn = mkNP not_Predet (mkNP (mkCard at_least_AdN ca) cn) ;
lin at_mostNP ca = mkNP (mkCard at_most_AdN ca) ;
lin not_at_mostNP ca cn = mkNP not_Predet (mkNP (mkCard at_most_AdN ca) cn) ;
lin more_thanNP ca = mkNP (mkCard (mkAdN more_CAdv) ca) ;
lin not_more_thanNP ca cn = mkNP not_Predet (mkNP (mkCard (mkAdN more_CAdv) ca) cn) ;

lin nothing_butNP cn = mkNP nothing_NP (mkAdv except_Prep (mkNP a_Art plNum cn)) ;
lin nothing_butMassNP cn = mkNP nothing_NP (mkAdv except_Prep (mkNP cn)) ;
lin nobody_butNP pn = mkNP nobody_NP (mkAdv except_Prep (mkNP pn)) ;
lin no_butNP cn pn = mkNP (mkNP no_Quant plNum cn) (mkAdv except_Prep (mkNP pn)) ;

lincat Unit = CN ;

lin unitNP = mkNP ;
lin unit_ofNP ca u cn = mkNP (mkNP ca u) (mkAdv part_Prep (mkNP a_Art plNum cn)) ;
lin unit_ofMassNP ca u cn = mkNP (mkNP ca u) (mkAdv part_Prep (mkNP cn)) ;

lin apposVarCN cn v = mkCN cn (symb v) ;

lin termNP x = symb (ss x.s) ;

-- 2.2.1


lin adjCN = mkCN ;
lin positAP = mkAP ;
lin comparAP = Syntax.comparAP ;
lin superlAP a = mkAP (mkOrd a) ;


-- 2.2.2

lin relCN = mkCN ;
lin relNP = mkNP ;

lin andRS = mkRS and_Conj ;
lin orRS = mkRS or_Conj ;
lin eachRP = mkRP part_Prep (mkNP each_Det) Syntax.which_RP ;

lin suchCN cn s = mkCN (mkAP (mkAP such_A) s) cn ;

lin predRS rp vp = mkRS (mkRCl rp vp) ;
lin slashRS rp np v2 = mkRS (mkRCl rp np v2) ;
lin which_RP = Syntax.which_RP ;

-- 2.2.4

lin genNP = genitiveNP ;
lin ofCN cn np = mkCN cn (mkAdv possess_Prep np) ;
lin genOwnNP np cn = genitiveNP np (mkCN own_A cn) ;

-- 2.3.1

lin vpS np vp = mkS (mkCl np vp) ;
lin neg_vpS np vp = mkS negativePol (mkCl np vp) ;

lin not_provably_vpS np vp = mkS negativePol (mkCl np (mkVP vp provably_Adv)) ;

lin vVP  = mkVP ;
lin vsVP = mkVP ;
lin v2VP = mkVP ;
lin v3VP = mkVP ;

-- 2.3.2

lin apVP = mkVP ;
lin compVP a np = mkVP (mkAP a np) ;
lin as_asVP ap np = mkVP (mkAP as_CAdv ap np) ; -- John is as rich as Mary
lin more_thanVP ap np = mkVP (mkAP more_CAdv ap np) ;

---- John is as fond-of Mary as of Sue
---- John is more fond-of Mary than of Sue

lincat PP = Adv ;
--lincat [PP] = Adv ;

--lin BasePP p = p ;

lin ppVP = mkVP ;

lin prepPP = mkAdv ;
lin advPP p = p ;

-- 2.3.5

lin canVP = mkVP can_VV ;
lin mustVP = mkVP must_VV ;

lin have_toVP = mkVP have_VV ;

-- 2.4

lin modVP = mkVP ;

-- 3.2

lin thereNP np = mkS (mkCl np) ;


-- 3.3

lin formulaS f = symb (ss f.s) ;

-- 3.4.1

lin coordS = mkS ;

lin and_Conj = Syntax.and_Conj ;
lin or_Conj = Syntax.or_Conj ;
lin commaAnd_Conj = comma_and_Conj ;
lin commaOr_Conj = comma_or_Conj ;

-- 3.4.3

lin for_everyS cn = mkS (mkAdv for_Prep (mkNP every_Det cn)) ;
lin for_eachS cn = mkS (mkAdv for_Prep (mkNP each_Det cn)) ;
lin for_each_ofS card cn = 
  mkS (mkAdv for_Prep (mkNP (mkNP each_Det) (mkAdv part_Prep (mkNP card cn)))) ;
lin for_allMassS cn =
  mkS (mkAdv for_Prep (mkNP all_Predet (mkNP cn))) ;

-- 3.4.4

lin if_thenS = mkS if_then_Conj ;


oper adj_thatCl : A -> S -> Cl = \a,s -> mkCl (mkVP (mkAP (mkAP a) s)) ;

lin falseS s = mkS (adj_thatCl false_A s) ;
lin not_provableS s = mkS negativePol (adj_thatCl provable_A s) ;
lin possibleS s = mkS (adj_thatCl possible_A s) ;
lin not_possibleS s = mkS negativePol (adj_thatCl possible_A s) ;
lin necessaryS s = mkS (adj_thatCl necessary_A s) ;
lin not_necessaryS s = mkS negativePol (adj_thatCl necessary_A s) ;


-- 3.5

lin npQS np vp = mkQS (mkCl np vp) ;
lin ipQS ip vp = mkQS (mkQCl ip vp) ;
lin iadvQS iadv np vp = mkQS (mkQCl iadv (mkCl np vp)) ;

lin where_IAdv = Syntax.where_IAdv ;
lin when_IAdv = Syntax.when_IAdv ;
lin whoSg_IP = Syntax.whoSg_IP ;
lin whoPl_IP = Syntax.whoPl_IP ;

lin there_ipQS ip = mkQS (mkQCl ip) ; ---- who is there, not there is who
lin whoseIP = mkIP whose_IDet ; 

-- 3.6

lin impVP np vp = mkText (mkPhr (mkUtt (mkImp vp)) (mkVoc np)) exclMarkPunct ; 
        ---- John, go to the bank!


lin consText = mkText ;
lin baseText t = t ;
lin sText = mkText ;
lin qsText = mkText ;

}



