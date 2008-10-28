incomplete concrete AttemptoI of Attempto = open 
  Syntax, 
  Symbolic,
  LexAttempto 
in {

lincat CN = Syntax.CN ;
lincat NP = Syntax.NP ;
lincat Card = Syntax.Card ;
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
lincat V2 = Syntax.V2 ;
lincat V3 = Syntax.V3 ;
lincat Adv = Syntax.Adv ;
lincat Conj = Syntax.Conj ;
lincat IP = Syntax.IP ;
lincat IAdv = Syntax.IAdv ;
lincat QS = Syntax.QS ;
lincat Text = Syntax.Text ;
lincat ACEText = Syntax.Text ;

lincat MCN = Syntax.CN ;
--lincat Var = Symb ;
lincat PP = Adv ;

lin aNP = mkNP a_Art ;
lin theNP = mkNP the_Art ;
lin cardNP d = mkNP d ;
--lin noNP : CN -> NP ;
lin everyNP = mkNP every_Det ;
--lin eachNP : CN -> NP ;
--lin notEveryNP : CN -> NP ;
--lin notEachNP : CN -> NP ;
lin theCollNP = mkNP the_Art plNum ;
lin someCollNP = mkNP somePl_Det ;
lin allCollNP cn = mkNP all_Predet (mkNP a_Art plNum cn) ;

--lin noCollNP : CN -> NP ;
--lin eachTheNP : CN -> NP ;
--lin eachSomeNP : CN -> NP ;
--lin eachNumNP : Card -> CN -> NP ;

lin someMassNP = mkNP someSg_Det ;
lin allMassNP cn = mkNP all_Predet (mkNP cn) ;

--lin noMassNP : MCN -> NP ;
--lin notAllMassNP : MCN -> NP ;

lin pnNP = mkNP ;
lin intNP = symb ;
lin floatNP = symb ;
--lin intNegNP : Int -> NP ;

lin it_NP = mkNP it_Pron ;
lin he_NP = mkNP he_Pron ;
lin she_NP = mkNP she_Pron ;
lin they_NP = mkNP they_Pron ;

lin conjNP = mkNP and_Conj ;
lin adjCN = mkCN ;

{-
lin someone_NP : NP ;
lin somebody_NP : NP ;
lin something_NP : NP ;
lin noone_NP : NP ;
lin nothing_NP : NP ;
lin not_everyoneNP : NP ;
lin not_everybodyNP : NP ;
lin not_everythingNP : NP ;

lin at_leastNP : Card -> CN -> NP ;
lin not_at_leastNP : Card -> CN -> NP ;
lin at_mostNP : Card -> CN -> NP ;
lin not_at_mostNP : Card -> CN -> NP ;
lin more_thanNP : Card -> CN -> NP ;
lin not_more_thanNP : Card -> CN -> NP ;

lin nothing_butNP : CN -> NP ; -- nothing but apples
lin nothing_butMassNP : MCN -> NP ; -- nothing but water
lin nobody_butNP : PN -> NP ; -- nobody but John
lin no_butNP : CN -> PN -> NP ; -- no man but John

cat Unit ; -- SI measurement units
cat Var ;

lin unitNP : Card -> Unit -> NP ;
lin unit_ofNP : Card -> Unit -> CN -> NP ;      -- 3 kg of apples
lin unit_ofMassNP : Card -> Unit -> MCN -> NP ; -- 3 l of water
-}
lin apposVarCN cn v = mkCN cn (symb v) ;

lin varNP = symb ;

-- 2.2.1


lin adjCN = mkCN ;
lin positAP = mkAP ;
lin comparAP = comparAP ;
lin superlAP a = mkAP (mkOrd a) ;


-- 2.2.2

lin relCN = mkCN ;
--lin relNP = mkNP ;

{-
lin andRS : RS -> RS -> RS ;
lin orRS : RS -> RS -> RS ;
lin eachRS : RS -> RS ; -- each of who
-}

-- 2.2.4

lin genNP = genitiveNP ;
lin ofCN cn np = mkCN cn (mkAdv possess_Prep np) ;
lin genOwnNP np cn = genitiveNP np (mkCN own_A cn) ;

-- 2.3.1

lin vpS np vp = mkS (mkCl np vp) ;
lin neg_vpS np vp = mkS negativePol (mkCl np vp) ;


--lin not_provably_vpS : NP -> VP -> S ;

lin vVP  = mkVP ;
lin v2VP = mkVP ;
lin v3VP = mkVP ;

-- 2.3.2

lin apVP = mkVP ;
lin compVP a np = mkVP (mkAP a np) ;
--lin as_asVP : A -> NP -> S ; -- John is as rich as Mary

-- John is as fond-of Mary as Bill
-- John is more fond-of Mary than Bill
-- John is as fond-of Mary as of Sue
-- John is more fond-of Mary than of Sue


lincat PP = Adv ;
lincat [PP] = Adv ;

lin BasePP p = p ;

lin ppVP = mkVP ;

lin prepPP = mkAdv ;

-- 2.3.5

lin canVP = mkVP can_VV ;
lin mustVP = mkVP must_VV ;

lin have_toVP = mkVP have_VV ;

-- 2.4

lin modVP = mkVP ;

-- 3.2

lin thereNP np = mkS (mkCl np) ;

{-
-- 3.3
-- Boolean formulas = \= < > <= >= 
-}

-- 3.4.1

lin coordS = mkS ;

lin and_Conj = Syntax.and_Conj ;
lin or_Conj = Syntax.or_Conj ;
--lin comma_and_Conj : Conj ; -- lower precedence
--lin comma_or_Conj : Conj ;

-- 3.4.3
{-
lin for_everyS : CN -> S -> S ;
lin for_eachS : CN -> S -> S ;
lin for_each_ofS : Card -> CN -> S -> S ; -- for each of 3 men
lin for_allMassS : MCN -> S -> S ; -- for all water

-- 3.4.4

lin if_thenS : S -> S -> S ;
-}

oper adj_thatCl : A -> S -> Cl = \a,s -> mkCl (mkVP (mkAP (mkAP a) s)) ;

lin falseS s = mkS (adj_thatCl false_A s) ;
lin not_provableS s = mkS negativePol (adj_thatCl provable_A s) ;
lin possibleS s = mkS (adj_thatCl possible_A s) ;
lin not_possibleS s = mkS negativePol (adj_thatCl possible_A s) ;
lin necessaryS s = mkS (adj_thatCl necessary_A s) ;
lin not_necessaryS s = mkS negativePol (adj_thatCl necessary_A s) ;


--lin thatS s t = mkS ;

-- 3.5

lin npQS np vp = mkQS (mkCl np vp) ;
lin ipQS ip vp = mkQS (mkQCl ip vp) ;
lin iadvQS iadv np vp = mkQS (mkQCl iadv (mkCl np vp)) ;

lin where_IAdv = Syntax.where_IAdv ;
lin when_IAdv = Syntax.when_IAdv ;
lin whoSg_IP = Syntax.whoSg_IP ;
lin whoPl_IP = Syntax.whoPl_IP ;

{-
lin there_ipQS : IP -> QS ; -- there is who

lin whoseIP : CN -> IP ;  -- whose dog
-}
-- 3.6

lin impVP np vp = mkText (mkPhr (mkUtt (mkImp vp)) (mkVoc np)) exclMarkPunct ; 
        ---- John, go to the bank!


lin consText = mkText ;
lin baseText t = t ;
lin sText = mkText ;
lin qsText = mkText ;

}



