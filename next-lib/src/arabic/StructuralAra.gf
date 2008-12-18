concrete StructuralAra of Structural = CatAra ** 
  open MorphoAra, ResAra, ParadigmsAra, Prelude in {

  flags optimize=all ;  coding=utf8 ;

  lin
  above_Prep = ss "فَوْقَ" ;
  after_Prep = ss "بَعْدَ" ;
  all_Predet = mkPredet "كُلّ" True ;
  almost_AdA = ss "تَقْرِيباً";
  almost_AdN = ss "حَوَالي" ; -- or  "تَقرِيبا"
--  although_Subj = ss "َلتهُْغه" ;
--  always_AdV = ss "َلوَيس" ;
  and_Conj = ss "وَ" ** {n = Pl} ;
--  because_Subj = ss "بعَُسي" ;
  before_Prep = ss "قَبْلَ" ;
  behind_Prep = ss "خَلْفَ" ;
  between_Prep = ss "بَيْنَ" ;
--  both7and_DConj = sd2 "بْته" "َند" ** {n = Pl} ;
--  but_PConj = ss "بُت" ;
  by8agent_Prep = ss "بِ" ;
  by8means_Prep = ss "بِ" ;
--  can8know_VV, can_VV = {
--    s = table VVForm [["بي َبلي تْ"] ; "عَن" ; "عُْلد" ; 
--         ["بّن َبلي تْ"] ; ["بِنغ َبلي تْ"] ; "عَنءت" ; "عُْلدنءت"] ; 
--    isAux = True
--    } ;
  during_Prep = ss "خِلَالَ" ;
--  either7or_DConj = sd2 "ِتهر" "ْر" ** {n = Sg} ;
  everybody_NP = regNP "الجَمِيع" Pl ;
  every_Det = mkDet "كُلّ" Sg Const ;
  everything_NP = regNP "كُلّ" Sg ;
--  everywhere_Adv = ss "ثريوهري" ;
  few_Det = mkDet "بَعض" Pl Const ;
--  first_Ord = ss "فِرست" ;
  from_Prep = ss "مِنَ" ;
  he_Pron = mkPron "هُوَ" "هُ" "هُ" (Per3 Masc Sg) ;
  here_Adv = ss "هُنا" ;
--  here7to_Adv = ss ["تْ هري"] ;
--  here7from_Adv = ss ["فرْم هري"] ;
  how_IAdv = ss "كَيفَ" ;
--  how8many_IDet = mkDeterminer Pl ["هْو مَني"] ;
--  if_Subj = ss "ِف" ;
  in8front_Prep = ss "مُقَابِلَ" ;
  i_Pron  = mkPron "أَنَا" "نِي" "ِي" (Per1 Sing);
  in_Prep = ss "فِي" ;
--  it_Pron  = mkPron "ِت" "ِت" "ِتس" Sg P3 ;
--  less_CAdv = ss "لسّ" ;
  many_Det = mkDet "جَمِيع" Pl Const ;
--  more_CAdv = ss "مْري" ;
  most_Predet = mkPredet  "أَكثَر" True ;
  much_Det = mkDet "الكَثِير مِنَ" Pl Const ;
--  must_VV = {
--    s = table VVForm [["بي هَثي تْ"] ; "مُست" ; ["هَد تْ"] ; 
--         ["هَد تْ"] ; ["هَثِنغ تْ"] ; "مُستنءت" ; ["هَدنءت تْ"]] ; ---- 
--    isAux = True
--    } ;
  no_Utt = {s = \\_ => "لا"} ;
  on_Prep = ss "عَلى" ;
--- DEPREC  one_Quant = mkQuantNum "واحِد" Sg Indef ;
  only_Predet = mkPredet "فَقَط" False;
--  or_Conj = ss "ْر" ** {n = Sg} ;
--  otherwise_PConj = ss "ْتهروِسي" ;
  part_Prep = ss "مِنَ" ;
--  please_Voc = ss "ةلَسي" ;
  possess_Prep = ss "ل" ;
--  quite_Adv = ss "قُِتي" ;
  she_Pron = mkPron "هِيَ" "ها" "ها" (Per3 Fem Sg) ;
--  so_AdA = ss "سْ" ;
  somebody_NP = regNP "أَحَد" Sg ;
  someSg_Det = mkDet "أَحَد" Pl Const ;
  somePl_Det = mkDet "بَعض" Pl Const ;
  something_NP = regNP "شَيْء" Sg ;
--  somewhere_Adv = ss "سْموهري" ;
  that_Quant = mkQuant3 "ذَلِكَ" "تِلكَ" "أُلٱِكَ" Def;
----b  that_NP = indeclNP "ذَلِكَ" Sg ;
  there_Adv = ss "هُناك" ;
--  there7to_Adv = ss "تهري" ;
--  there7from_Adv = ss ["فرْم تهري"] ;
--  therefore_PConj = ss "تهرفْري" ;
----b  these_NP = indeclNP "هَؤُلَاء" Pl ;
 they_Pron = mkPron "هُمْ" "هُمْ" "هُمْ" (Per3 Masc Pl) ; 
  this_Quant = mkQuant7 "هَذا" "هَذِهِ" "هَذَان" "هَذَيْن" "هَاتَان" "هَاتَيْن" "هَؤُلَاء" Def;
----b  this_NP = indeclNP "هَذا" Sg ;
----b  those_NP = indeclNP "هَؤُلَاءكَ" Pl ;
  through_Prep = ss "عَبْرَ" ;
--  too_AdA = ss "تّْ" ;
  to_Prep = ss "إِلى" ;
  under_Prep = ss "تَحْتَ" ;
--  very_AdA = ss "ثري" ;
--  want_VV = P.mkVV (P.regV "وَنت") ;
  we_Pron = mkPron "نَحنُ" "نا" "نا" (Per1 Plur) ;
  whatPl_IP = mkIP "ماذا" Pl ;
  whatSg_IP = mkIP "ماذا" Sg ;
  when_IAdv = ss "مَتَى" ;
--  when_Subj = ss "وهن" ;
  where_IAdv = ss "أَينَ" ;
--  whichPl_IDet = mkDeterminer Pl ["وهِعه"] ;
--  whichSg_IDet = mkDeterminer Sg ["وهِعه"] ;
  whoSg_IP = mkIP "مَنْ" Sg ;
  whoPl_IP = mkIP "مَنْ" Pl ;
--  why_IAdv = ss "وهي" ;
  without_Prep = ss "بِدُونِ" ;
  with_Prep = ss "مَع" ;
  yes_Utt = {s = \\_ => "نَعَم"} ;
  youSg_Pron = mkPron "أَنتَ" "كَ" "كَ" (Per2 Masc Sg) ;
  youPl_Pron = mkPron "أَنتُمْ" "كُمْ" "كُمْ" (Per2 Masc Sg) ;
  youPol_Pron = mkPron "أَنتِ" "كِ" "كِ" (Per2 Fem Sg) ;

}
