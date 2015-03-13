--# -path=.:../abstract:../common:../prelude

concrete StructuralMon of Structural = CatMon ** open ResMon, MorphoMon, ParadigmsMon, Prelude, NounMon in {

 flags optimize=all ; coding=utf8 ;

lin

 above_Prep = mkPrep Gen "дээгүүр" ;
 after_Prep = mkPrep Gen "дараа" ;
 all_Predet = {
    s = "бүх" ; 
    isPre = True ;
	isDef = False
    } ;
 almost_AdA, almost_AdN = ss "бараг" ;
 although_Subj = {s = "боловч" ; isPre = False} ;
 always_AdV = ss "үргэлж" ;
 and_Conj = mkConj "ба" ;
 because_Subj = {s = "яагаад гэвэл" ; isPre = False} ;
 before_Prep = mkPrep Abl "өмнө" ;
 behind_Prep = mkPrep Gen "ард" ;
 between_Prep = mkPrep Gen "хооронд" ;
 both7and_DConj = mkConj "" "мөн" ;
 but_PConj = ss "гэвч" ;
 by8agent_Prep = mkPrep Gen "ачаар" ; 
 by8means_Prep = noPrep Inst ;
 can8know_VV = verbToAux (regV "чадах") ;
 can_VV = verbToAux (regV "чадах") ;
 during_Prep = mkPrep Gen "үеэр" ;
 either7or_DConj = mkConj "эсвэл" "эсвэл" ;
 every_Det = {
    s = "бүр" ;
	sp = \\rc => (regN "бүр").s ! (SF Sg (toNCase rc Definite)) ; 
    isNum, isPoss, isPre = False ;
	isDef = True
    } ;  
 everybody_NP = mkNP "хүн бүр" Definite ;
 everything_NP = mkNP "бүгд" Definite ;
 everywhere_Adv = ss "хаа сайгүй" ;
 few_Det = {
    s = "багагүй" ; 
    sp = \\rc => (regN "багагүй").s ! (SF Sg (toNCase rc Indefinite)) ; 
    isNum, isPoss, isDef = False ;
    isPre = True
    } ;
 for_Prep = noPrep Dat ; 
 from_Prep = noPrep Abl ;
 he_Pron = mkPron "тэр" "түүний" "түүнд" "түүнийг" "түүнээс" "түүнээр" "түүнтэй" "түүн рүү" Sg P3 ;
 here_Adv = ss "энд" ;
 here7to_Adv = ss "ийшээ" ;
 here7from_Adv = ss "эндээс" ;
 how_IAdv  = ss "яаж" ;
 how8many_IDet = {
    s = \\_ => "хэдэн" ; 
    n = Pl
    } ; 
 how8much_IAdv = ss "хэд" ;
 i_Pron = mkPron "би" "миний" "надад" "намайг" "надаас" "надаар" "надтай" "над руу" Sg P1 ;
 if_Subj = {s = "хэрэв" ; isPre = True} ;
 in8front_Prep = mkPrep Gen "урд" ; 
 in_Prep = noPrep Dat ; 
 it_Pron = mkPron "тэр" "түүний" "түүнд" "түүнийг" "түүнээс" "түүнээр" "түүнтэй" "түүн рүү" Sg P3 ;
 less_CAdv = lin CAdv {s = "бага" ; c2 = noPrep Abl} ;
 many_Det = {
    s = "олон" ; 
    sp = \\rc => (regN "олон").s ! (SF Sg (toNCase rc Indefinite)) ; 
    isNum, isPoss, isDef = False ;
    isPre = True
    } ; 
 more_CAdv = lin CAdv {s = "илүү" ; c2 = noPrep Abl};
 most_Predet = {
    s = "ихэнх" ; 
    isPre = True ;
	isDef = False
    } ;  
 much_Det = {
    s = "нилээд" ; 
    sp = \\rc => (regN "нилээд").s ! (SF Sg (toNCase rc Indefinite)) ; 
    isNum, isPoss, isDef = False ; 
    isPre = True
    } ;
 must_VV = verbToAux (regV ("хэрэгтэй байх")) ;
 no_Utt = ss "үгүй" ;
 on_Prep = mkPrep Gen "дээрх" ; 
 only_Predet = {
    s = "зөвхөн" ; 
    isPre = True ;
	isDef = True
    } ;
 or_Conj = mkConj "эсвэл" ;
 otherwise_PConj = ss "үгүй бол" ;
 part_Prep = noPrep Gen ;
 please_Voc = ss [] ;
 possess_Prep = noPrep Gen ; 
 quite_Adv = ss "бүрэн" ;
 she_Pron = mkPron "тэр" "түүний" "түүнд" "түүнийг" "түүнээс" "түүнээр" "түүнтэй" "түүн рүү" Sg P3 ;
 so_AdA = ss "ийм" ;
 somebody_NP = mkNP "хэн нэгэн" Indefinite ;
 someSg_Det = {
    s = "зарим нэг" ; 
    sp = \\rc => (regN "зарим нэг").s ! (SF Sg (toNCase rc Indefinite)) ; 
    isNum, isPoss, isDef = False ;
    isPre = True
    } ;
 somePl_Det = {
    s = "зарим" ; 
    sp = \\rc => (regN "зарим").s ! (SF Sg (toNCase rc Indefinite)) ; 
    isNum, isPoss, isDef = False ;
    isPre = True
    } ;
 something_NP = mkNP "ямар нэгэн юм" Indefinite ;
 somewhere_Adv = ss "хаа нэгтээ" ;
 that_Quant = {
    s = table (ParadigmsMon.Number) {
        Sg => "тэр" ; 
        Pl => "тэдгээр" 
        } ;
    sp = \\n,nc => case n of {
        Sg => case nc of {
		   NNom => "тэр" ;
           NInst => "түүгээр" ;
		   _ => (regN "түүн").s ! SF Sg nc
		   } ;
        Pl => (regN "тэдгээр").s ! SF Sg nc 
		};
	isPoss = False ;
	isDef = True
    } ;
 that_Subj = {s = [] ; isPre = True} ;
 there_Adv = ss "тэнд" ;
 there7to_Adv = ss "цаашаа" ;
 there7from_Adv = ss "цаанаас" ;
 therefore_PConj = ss "тийм учраас" ;
 they_Pron = mkPron "тэд" "тэдний" "тэднийд" "тэднийг" "тэднээс" "тэднээр" "тэдэнтэй" "тэдэн рүү" Pl P3 ;
 this_Quant = {
    s = table (ParadigmsMon.Number) {
        Sg => "энэ" ; 
        Pl => "эдгээр" 
        } ;
    sp = \\n,nc => case n of {
        Sg => case nc of {
		   NNom => "энэ" ;
           NInst => "үүгээр" ;
		   _ => (regN "үүн").s ! SF Sg nc
		   } ;
        Pl => (regN "эдгээр").s ! SF Sg nc 
		} ;
	isPoss = False ;
	isDef = True
    } ;
 through_Prep = noPrep Inst ; 
 to_Prep = mkPrep Acc "хүртэл" ;
 too_AdA = ss "дэндүү" ;
 under_Prep = mkPrep Gen "доор" ;
 very_AdA = ss "маш" ;
 want_VV = verbToAux (regV "хүсэх") ;
 we_Pron = mkPron "бид" "бидний" "бидэнд" "биднийг" "биднээс" "биднээр" "бидэнтэй" "бидэн рүү" Pl P1 ;
 whatPl_IP = {
    s = \\rc => (regN "юу").s ! SF Sg (toNCase rc Definite) ; 
    n = Pl
    } ;
 whatSg_IP = {
    s = \\rc => (regN "юу").s ! SF Sg (toNCase rc Definite) ; 
    n = Sg
    } ;
 when_IAdv = ss "хэзээ" ;
 when_Subj = {s = "хэрэв" ; isPre = True} ;
 where_IAdv = ss "хаана" ;
 which_IQuant = {
    s = \\rc => (regN "ямар").s ! SF Sg (toNCase rc Definite)
    } ; 
 whoPl_IP = {
    s = \\rc => (regN "хэн").s ! SF Sg (toNCase rc Definite) ; 
    n = Pl
    } ;
 whoSg_IP = {
    s = \\rc => (regN "хэн").s ! SF Sg (toNCase rc Definite) ; 
    n = Sg
    } ;
 why_IAdv = ss "яагаад" ;
 with_Prep = noPrep Com ; 
 without_Prep = mkPrep Nom "-гүй" ;
 yes_Utt = ss "За" ;
 youSg_Pron = mkPron "чи" "чиний" "чамд" "чамайг" "чамаас" "чамаар" "чамтай" "чам руу" Sg P2 ;
 youPl_Pron = mkPron "та нар" "та нарын" "та нарт" "та нарыг" "та нараас" "та нараар" "та нартай" "та нар луу" Pl P2 ;
 youPol_Pron = mkPron "та" "таны" "танд" "таныг" "танаас" "танаар" "тантай" "тан руу" Sg P2 ;
 no_Quant = {
    s = \\_ => "ямар ч" ;
    sp = \\_,nc => (regN "ямар ч").s ! SF Sg nc ;
	isPoss = False ;
	isDef = False
    } ;
 not_Predet = {
    s = "биш" ; 
    isPre = False ;
	isDef = True
    } ; 
 if_then_Conj = mkConj "хэрэв" "" ;
 at_least_AdN = ss "хамгийн багадаа" ;
 at_most_AdN = ss "хамгийн ихдээ" ;
 nobody_NP = mkNP "хэн ч" Definite ;
 nothing_NP = mkNP "юу ч" Definite ;
 except_Prep = mkPrep Abl "гадна" ;
 as_CAdv = lin CAdv {s = "шиг" ; c2 = noPrep Nom} ;
 have_V2 = mkV2 (mkV "байх") ;

 lin language_title_Utt = ss "Монгол" ;

}

