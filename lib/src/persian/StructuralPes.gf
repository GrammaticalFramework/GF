concrete StructuralPes of Structural = CatPes ** 
  open MorphoPes, ParadigmsPes, Prelude, NounPes in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = ss "بالای" ;
  after_Prep = ss ["بعد از"] ;
  all_Predet = ss ["همه ی"] ;
  almost_AdA, almost_AdN = ss "تقریباً" ;
  although_Subj = ss ["با وجود این"] ;
  always_AdV = ss "همیشه" ;
  and_Conj = sd2 [] "و" ** {n = Pl} ;
  because_Subj = ss ["برای این"] ;
  before_Prep = ss ["قبل از"] ;
  behind_Prep = ss "پشت" ;
  between_Prep = ss "بین" ;
  both7and_DConj = sd2 "هم" ["و هم"] ** {n = Pl} ;
  but_PConj = ss "اما" ;
  by8agent_Prep = ss "توسط" ;
  by8means_Prep = ss "با" ;
--  can8know_VV,can_VV = mkV "سکن" ** { isAux = True} ;
  during_Prep = ss ["در طول"] ;
  either7or_DConj = sd2 "یا" "یا" ** {n = Sg} ;
--  everybody_NP =  MassNP (UseN (MorphoPnb.mkN11 ["هر کwی"])); -- not a good way coz need to include NounPnb
  every_Det = mkDet "هر" Sg ;
--  everything_NP = MassNP (UseN (MorphoPnb.mkN11 ["هر XE"]));
  everywhere_Adv = ss ["هر جا"] ;
  few_Det = mkDet ["تعداد کمی"] Pl True; -- check
--  first_Ord = {s = "اولین" ; n = Sg} ; --DEPRECATED
  for_Prep = ss "برای" ;
  from_Prep = ss "از" ;
  he_Pron = personalPN "او"  Sg PPers3 ;
  here_Adv = ss "اینجا" ;
  here7to_Adv = ss "اینجا" ;
  here7from_Adv = ss "اینجا" ;
  how_IAdv = ss "چطور" ;
  how8many_IDet = {s = "چند" ; n = Pl ; isNum = True} ;
  how8much_IAdv  = ss "چقدر" ;
  if_Subj = ss "اگر" ;
  in8front_Prep = ss "جلوی" ;
  i_Pron = personalPN "من" Sg PPers1;
  in_Prep = ss "در" ;
  it_Pron  = personalPN "آن" Sg PPers3;
  less_CAdv = {s = "کمتر" ; p = ""} ;
  many_Det = mkDet ["تعداد زیادی"] Pl True; -- check
  more_CAdv = {s = "بیشتر" ; p = "" } ; 
  most_Predet = ss "اکثر";
  much_Det = mkDet ["مقدار زیادی"]  Pl ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["هوe تْ"] ;
--      VVF VPres => "مست" ;
--      VVF VPPart => ["هد تْ"] ;
--      VVF VPresPart => ["هونگ تْ"] ;
--      VVF VPast => ["هد تْ"] ;      --# notpresent
--      VVPastNeg => ["هدn'ت تْ"] ;      --# notpresent
--      VVPresNeg => "مستn'ت"
--      } ;
--    isAux = True
--    } ;
-----b  no_Phr = ss "نْ" ;


  no_Utt = ss "نه" ;
  on_Prep = ss "روی" ;
--  one_Quant = demoPN "یک"  ; -- DEPRECATED
  only_Predet = ss "فقط" ;
  or_Conj = sd2 [] "یا" ** {n = Sg} ;
  otherwise_PConj = ss ["درغیراین صورت"] ;
  part_Prep = ss "از" ; -- the object following it should be in Ezafa form  
  please_Voc = ss "لطفاً" ;
  possess_Prep = ss "" ; -- will be handeled in Ezafeh
  quite_Adv = ss "کاملاً" ;
  she_Pron = personalPN "او" Sg PPers3 ;
  so_AdA = ss "بسیار" ; 
--  somebody_NP = MassNP (UseN (MorphoPnb.mkN11 "کwی" ));
  someSg_Det = mkDet "مقداری" Sg True ;
  somePl_Det = mkDet "چند" Pl True ;
--  something_NP = MassNP (UseN (MorphoPnb.mkN11 "چیزی"));
  somewhere_Adv = ss "جایی" ; 
  that_Quant = mkQuant "آن" "آن"; 
  that_Subj = ss "آن"; 
  there_Adv = ss "آنجا" ; 
  there7to_Adv = ss "آنجا" ;
  there7from_Adv = ss "آنجا" ;
  therefore_PConj = ss ["به همین دلیل"] ; 
  they_Pron = personalPN ["آن ها"] Pl PPers3 ; 
  this_Quant = mkQuant "این" "این" ;  
  through_Prep = ss ["از طریق"] ;
  too_AdA = ss "خیلی" ; 
  to_Prep = ss "به" ** {lock_Prep = <>};
  under_Prep = ss "زیر" ** {lock_Prep = <>};
  very_AdA = ss "خیلی" ;
  want_VV = mkV "خواستن" "خواه" ** { isAux = False} ; 
  we_Pron = personalPN "ما" Pl PPers1 ;
  whatSg_IP = {s = ["چه چیزی"] ; n = Sg } ;
  whatPl_IP = {s = ["چه چیزهایی"] ; n = Pl } ;
  when_IAdv = ss "کی" ; 
  when_Subj = ss "وقتی" ;
  where_IAdv = ss "کجا" ;
  which_IQuant = {s = "کدام" ; n = Sg} ;
  whichPl_IDet = {s = "کدام" ; n = Pl ; isNum = False} ;
  whichSg_IDet = { s = "کدام" ; n = Sg ; isNum = False} ;
  whoSg_IP = {s = ["چه کسی"] ; n =  Sg}  ;
  whoPl_IP = {s = ["چه کسانی"] ;n = Pl} ;
  why_IAdv = ss "چرا" ;
  without_Prep = ss "بدون" ;
  with_Prep = ss "با";
--  yes_Phr = ss "بله" ;
  yes_Utt = ss "بله" ;
  youSg_Pron = personalPN "تو" Sg PPers2 ;
  youPl_Pron = personalPN "شما" Pl PPers2 ;
  youPol_Pron = personalPN "شما"  Pl PPers2  ; 
--  no_Quant =  demoPN "هیچ" ; 
  not_Predet = {s="نه"} ;
  if_then_Conj = sd2 "اگر" "آنگاه" ** {n = Sg} ; 
  at_least_AdN = ss "حداقل" ;
  at_most_AdN = ss "حداکثر";
--  nothing_NP = MassNP (UseN (MorphoPnb.mkN11 "هیچ چیز" )); 
  except_Prep = ss ["به جز"] ;
--  nobody_NP = MassNP (UseN (MorphoPnb.mkN11 "هیچ کس"));  

  as_CAdv = {s = ["به اندازه ی"] ; p = ""} ;

  have_V2 = mkV2 (mkV "داشتن" "دار") "را" ;

 language_title_Utt = ss "پeرسن" ;

}


