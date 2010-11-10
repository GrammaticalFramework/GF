--# -path=.:../Romance:../common:../abstract:../common:prelude
-- (c) 2010 Markos KG
-- Licensed under LGPL


concrete StructuralAmh of Structural = CatAmh ** 

open MorphoAmh, ResAmh, ParadigmsAmh,(C = ConstructX),ParamX, Prelude in {
--
flags optimize=all ;  coding=utf8 ;
--
lin

		above_Prep = mkPrep  "ከ"  "በላይ" False;
		after_Prep = mkPrep  "ከ"  "በኋላ" False;
		all_Predet = mkPredet"ሁሉ"  False ;
		-- almost_AdA = ss "ገደማ";
		-- almost_AdN = ss "حَوَالي" ; -- or  "تَقرِيبا"
		although_Subj = ss "ይሁን እንጂ" ;
		always_AdV = ss "ሁልጊዜ" ;
		and_Conj = sd2 [] "እና" ** {n = Pl} ; --and_Conj = mkConj "እና" Pl ; -- and_Conj = ss "እና" ** {n = Pl} ;
		because_Subj = ss "ሰለዚህ" ;
		before_Prep = mkPrep "ከ" "በፊት "  False ;
		behind_Prep = mkPrep "ከ" "በስተጀርባ" False;
		between_Prep = mkPrep "በ" "መካከል" False ;
		both7and_DConj = sd2 "" "እና" ** {n = Pl} ;
		but_PConj = ss "ነገር ግን" ;
		by8means_Prep = mkPrep "በ" "" True  ;
		by8agent_Prep = mkPrep "" "ጋ" False ;
		--can8know_VV, can_VV = {
		--s = table VVForm [["بي َبلي تْ"] ; "عَن" ; "عُْلد" ; 
		----         ["بّن َبلي تْ"] ; ["بِنغ َبلي تْ"] ; "عَنءت" ; "عُْلدنءت"] ; 
		----    isAux = True
		----    } ;
		--  during_Prep = mkPrep "ሳለ" ;
		either7or_DConj = sd2 "ወይ " " ካለበለዚያ" ** {n = Sg} ;
		everybody_NP = regNP "ሁሉምሰው" Sg ;
		every_Det = mkDet (regAdj "እያንዳንዱ") Sg Indef ;
		everything_NP = regNP "ሁሉነገር" Sg ;
		everywhere_Adv = ss "በየቦታው" ;
		few_Det =   mkDet (regAdj "ጥቂት") Pl Indef ;
		first_Ord = ss "መጀመሪያ" ;
		from_Prep = mkPrep "ከ" ""True ;
		he_Pron = pronNP "እርሱ" "እርሱን" "የእርሱ" "ለእርሱ"  (Per3 Sg Masc)  ;
		here_Adv = ss "እዚህ" ;
		here7to_Adv = ss "ወደዚህ" ;
		here7from_Adv = ss "ከዚህ" ;
		how_IAdv = ss "እንዴት" ;
		how8many_IDet = mkDeterminer Pl ["ስንት"] ;
		--if_Subj = ss "ِف" ;
		in8front_Prep = mkPrep "ከ" "ፊትለፊት" False;
		i_Pron  = pronNP "እኔ" "እኔን" "የእኔ" "ለእኔ" (Per1 Sg)  ;
		in_Prep = mkPrep "" "ውስጥ" False;
		it_Pron  = pronNP "" "" "" ""  (Per3 Sg Masc)  ; 
		less_CAdv = C.mkCAdv "በ" "አነስ";
		many_Det = mkDet (regAdj "ብዙ") Pl Indef ;
		more_CAdv = C.mkCAdv "በ" "ተሻለ";
		as_CAdv  = C.mkCAdv "ልክ" "እንደ" ;
		most_Predet = mkPredet  "አብዛኛው" True ;
		much_Det =  mkDet (regAdj "ብዙ") Pl Indef ;
		--must_VV = {
		--s = table VVForm [["بي هَثي تْ"] ; "مُست" ; ["هَد تْ"] ; 
		----         ["هَد تْ"] ; ["هَثِنغ تْ"] ; "مُستنءت" ; ["هَدنءت تْ"]] ; ---- 
		--    isAux = True
		--    } ;
		--  no_Utt = {s = \\_ => "لا"} ;
		on_Prep = mkPrep "በ" "ላይ" False ;
		--DEPREC  one_Quant = mkQuantNum "واحِد" Sg Indef ;
		only_Predet = mkPredet "ብቻ" False;
		or_Conj = sd2 [] "ወይም" ** {n = Sg} ; 
		otherwise_PConj = ss "ካለበለዚያ" ;
		-- part_Prep = mkPrep "مِنَ" ;
	        please_Voc = ss "ስለእግዚአብሐር" ; --  cant be here in structural : 
		-- possess_Prep = mkPrep "ل" ;
		-- quite_Adv = ss "قُِتي" ;
		she_Pron = pronNP "እርሷ" "እርሷን" "የእርሷ" "ለእርሷ" (Per3 Sg Fem)  ;
		so_AdA = ss "በጣም";
		somebody_NP = regNP "የሆነሰው" Sg ;
		someSg_Det = mkDet (regAdj "የሆነ" ) Sg Indef ;
		somePl_Det = mkDet (regAdj "ጥቂት" ) Pl Indef ;
		something_NP = regNP "የሆነነገር" Sg ;
		somewhere_Adv = ss "የሆነቦታ" ;
		--  that_Quant = mkQuant3 "ذَلِكَ" "تِلكَ" "أُلٱِكَ" Def;
		------b  that_NP = indeclNP "ذَلِكَ" Sg ;
		for_Prep = mkPrep "ለ" "" False;
		there_Adv = ss "እዚያ" ;
		there7to_Adv = ss "ወደዚያ" ;
		there7from_Adv = ss "ከዚያ" ;
		 therefore_PConj = ss "ሰለዚህ" ;
		--b  these_NP = indeclNP "هَؤُلَاء" Pl ;
		they_Pron = pronNP "እነርሱ" "እነርሱን" "የእነርሱ" "ለእነርሱ" (Per3 Pl Masc)  ; 
		--this_Quant = mkQuant7 "هَذا" "هَذِهِ" "هَذَان" "هَذَيْن" "هَاتَان" "هَاتَيْن" "هَؤُلَاء" Def;
		this_Quant =  mkQuant (mkAdjyh "ይህ") Indef ;
		--these_Quant = adjDet (mkDetyh "ይህ") Pl False;
		that_Quant =  mkQuant (mkAdjya "ያ")  Indef;
		--those_Quant = adjDet (mkDetya "ያ") Pl False;
		--b  this_NP = indeclNP "هَذا" Sg ;
		--b  those_NP = indeclNP "هَؤُلَاءكَ" Pl ;
		through_Prep = mkPrep "በ" "በኩል" False ;
		 too_AdA = ss "በጣም" ;
		 to_Prep = mkPrep "ወደ" "" True;
		under_Prep = mkPrep "ከ" "ታች" False ;
		very_AdA = ss "በጣም" ;
		want_VV = mkV3mls"flg"; 
		we_Pron = pronNP "እኛ" "እኛን" "የእኛ" "ለእኛ"   (Per1 Pl) ;
		--whatPl_IP = mkIP "ماذا" Pl ;
		--whatSg_IP = mkIP "ماذا" Sg ;
		when_IAdv = ss "መቼ" ;
		--when_Subj = ss "وهن" ;
		where_IAdv = ss "የት" ;
		which_IQuant = {s = \\_ =>"የምን"} ;
		whichPl_IDet = mkDeterminer Pl ["የትኞቹ"] ;
		whichSg_IDet = mkDeterminer Sg ["የትኛው"] ;
		whoSg_IP = mkIP "ማን" Sg ;
		whoPl_IP = mkIP "እነማን" Pl ;
		why_IAdv = ss "ለምን" ;
		without_Prep = mkPrep "ካለ" "" True ;
		with_Prep = mkPrep "ከ" "ጋር" False ;
		--yes_Utt = {s = \\_ => "نَعَم"} ;
		youSg_Pron = pronNP "አንተ" "አንተን" "የአንተ" "ለአንተ" (Per2 Sg Masc);	
		youPl_Pron = pronNP "እናንተ" "እናንተን" "የእናንተ" "ለእናንተ"  (Per2 Pl Masc);
		youPol_Pron = pronNP "እርስዎ" "እርስዎን" "የእርስዎ" "ለእርስዎ"  (Per3 Pl Masc) ;  -- discuss this i the report : 
		have_V2      = mkV2 (mkV3al "äl") (mkPrep "" "" True);
		-- dirV2 (regV "يَملِك") ; 
		lin language_title_Utt = ss "አማርኛ"  ;
		
}
