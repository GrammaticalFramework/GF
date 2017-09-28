concrete StructuralPes of Structural = CatPes ** 
  open MorphoPes, ParadigmsPes, Prelude, NounPes, (R=ResPes) in {

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
  can_VV = mkV_1 " توانستن " ** { isAux = True} ; ---- AR
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
  must_VV = invarV " بایستن " ** {isAux = True} ;  ---- AR
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

----  have_V2 = mkV2 (mkV "داشتن" "دار") "را" ;

 language_title_Utt = ss "پeرسن" ;

---- AR from Nasrin

have_V2 = {
  s = table {
  (VF Pos (PPresent2 PrPerf) PPers1 Sg) => "داشته ام" ;
  (VF Pos (PPresent2 PrPerf) PPers1 Pl) => "داشته ایم" ;
  (VF Pos (PPresent2 PrPerf) PPers2 Sg) => "داشته ای" ;
  (VF Pos (PPresent2 PrPerf) PPers2 Pl) => "داشته اید" ;
  (VF Pos (PPresent2 PrPerf) PPers3 Sg) => "داشته است" ;
  (VF Pos (PPresent2 PrPerf) PPers3 Pl) => "داشته اند" ;
  (VF Pos (PPresent2 PrImperf) PPers1 Sg) => "دارم" ;
  (VF Pos (PPresent2 PrImperf) PPers1 Pl) => "داریم" ;
  (VF Pos (PPresent2 PrImperf) PPers2 Sg) => " داری" ;
  (VF Pos (PPresent2 PrImperf) PPers2 Pl) => "دارید" ;
  (VF Pos (PPresent2 PrImperf) PPers3 Sg) => "دارد" ;
  (VF Pos (PPresent2 PrImperf) PPers3 Pl) => "دارند" ;
  (VF Pos (PPast2 PstPerf) PPers1 Sg) => "داشته بودم" ;
  (VF Pos (PPast2 PstPerf) PPers1 Pl) => "داشته بودیم" ;
  (VF Pos (PPast2 PstPerf) PPers2 Sg) => "داشته بودی" ;
  (VF Pos (PPast2 PstPerf) PPers2 Pl) => "داشته بودید" ;
  (VF Pos (PPast2 PstPerf) PPers3 Sg) => "داشته بود" ;
  (VF Pos (PPast2 PstPerf) PPers3 Pl) => "داشته بودند" ;
  (VF Pos (PPast2 PstImperf) PPers1 Sg) => "می داشتم" ;
  (VF Pos (PPast2 PstImperf) PPers1 Pl) => "می داشتیم" ;
  (VF Pos (PPast2 PstImperf) PPers2 Sg) => "می داشتی" ;
  (VF Pos (PPast2 PstImperf) PPers2 Pl) => "می داشتید" ;
  (VF Pos (PPast2 PstImperf) PPers3 Sg) => "می داشت" ;
  (VF Pos (PPast2 PstImperf) PPers3 Pl) => "می داشتند" ;
  (VF Pos (PPast2 PstAorist) PPers1 Sg) => "داشتم" ;
  (VF Pos (PPast2 PstAorist) PPers1 Pl) => "داشتیم" ;
  (VF Pos (PPast2 PstAorist) PPers2 Sg) => "داشتی" ;
  (VF Pos (PPast2 PstAorist) PPers2 Pl) => "داشتید" ;
  (VF Pos (PPast2 PstAorist) PPers3 Sg) => "داشت" ;
  (VF Pos (PPast2 PstAorist) PPers3 Pl) => "داشتند" ;
  (VF Pos (PFut2 FtAorist) PPers1 Sg) => "خواهم داشت" ;
  (VF Pos (PFut2 FtAorist) PPers1 Pl) => "خواهیم داشت" ;
  (VF Pos (PFut2 FtAorist) PPers2 Sg) => "خواهی داشت" ;
  (VF Pos (PFut2 FtAorist) PPers2 Pl) => "خواهید داشت" ;
  (VF Pos (PFut2 FtAorist) PPers3 Sg) => "خواهد داشت" ;
  (VF Pos (PFut2 FtAorist) PPers3 Pl) => "خواهند داشت" ;
  (VF Pos (Infr_Past2 InfrPerf) PPers1 Sg) => "داشته بوده ام" ;
  (VF Pos (Infr_Past2 InfrPerf) PPers1 Pl) => "داشته بوده ایم" ;
  (VF Pos (Infr_Past2 InfrPerf) PPers2 Sg) => "داشته بوده ای" ;
  (VF Pos (Infr_Past2 InfrPerf) PPers2 Pl) => "داشته بوده اید" ;
  (VF Pos (Infr_Past2 InfrPerf) PPers3 Sg) => "داشته بوده است" ;
  (VF Pos (Infr_Past2 InfrPerf) PPers3 Pl) => "داشته بوده اند" ;
  (VF Pos (Infr_Past2 InfrImperf) PPers1 Sg) => "می داشته ام" ;
  (VF Pos (Infr_Past2 InfrImperf) PPers1 Pl) => "می داشته ایم" ;
  (VF Pos (Infr_Past2 InfrImperf) PPers2 Sg) => "می داشته ای" ;
  (VF Pos (Infr_Past2 InfrImperf) PPers2 Pl) => "می داشته اید" ;
  (VF Pos (Infr_Past2 InfrImperf) PPers3 Sg) => "می داشته است" ;
  (VF Pos (Infr_Past2 InfrImperf) PPers3 Pl) => "می داشته اند" ;
  (VF Neg (PPresent2 PrPerf) PPers1 Sg) => "نداشته ام" ;
  (VF Neg (PPresent2 PrPerf) PPers1 Pl) => "نداشته ایم" ;
  (VF Neg (PPresent2 PrPerf) PPers2 Sg) => "نداشته ای" ;
  (VF Neg (PPresent2 PrPerf) PPers2 Pl) => "نداشته اید" ;
  (VF Neg (PPresent2 PrPerf) PPers3 Sg) => "نداشته است" ;
  (VF Neg (PPresent2 PrPerf) PPers3 Pl) => "نداشته اند" ;
  (VF Neg (PPresent2 PrImperf) PPers1 Sg) => "ندارم" ;
  (VF Neg (PPresent2 PrImperf) PPers1 Pl) => "نداریم" ;
  (VF Neg (PPresent2 PrImperf) PPers2 Sg) => "نداری" ;
  (VF Neg (PPresent2 PrImperf) PPers2 Pl) => "ندارید" ;
  (VF Neg (PPresent2 PrImperf) PPers3 Sg) => "ندارد" ;
  (VF Neg (PPresent2 PrImperf) PPers3 Pl) => "ندارند" ;
  (VF Neg (PPast2 PstPerf) PPers1 Sg) => "نداشته بودم" ;
  (VF Neg (PPast2 PstPerf) PPers1 Pl) => "نداشته بودیم" ;
  (VF Neg (PPast2 PstPerf) PPers2 Sg) => "نداشته بودی" ;
  (VF Neg (PPast2 PstPerf) PPers2 Pl) => "نداشته بودید" ;
  (VF Neg (PPast2 PstPerf) PPers3 Sg) => "نداشته بود" ;
  (VF Neg (PPast2 PstPerf) PPers3 Pl) => "نداشته بودند" ;
  (VF Neg (PPast2 PstImperf) PPers1 Sg) => "نمی داشتم" ;
  (VF Neg (PPast2 PstImperf) PPers1 Pl) => "نمی داشتیم" ;
  (VF Neg (PPast2 PstImperf) PPers2 Sg) => "نمی داشتی" ;
  (VF Neg (PPast2 PstImperf) PPers2 Pl) => "نمی داشتید" ;
  (VF Neg (PPast2 PstImperf) PPers3 Sg) => "نمی داشت" ;
  (VF Neg (PPast2 PstImperf) PPers3 Pl) => "نمی داشتند" ;
  (VF Neg (PPast2 PstAorist) PPers1 Sg) => "نداشتم" ;
  (VF Neg (PPast2 PstAorist) PPers1 Pl) => "نداشتیم" ;
  (VF Neg (PPast2 PstAorist) PPers2 Sg) => "نداشتی" ;
  (VF Neg (PPast2 PstAorist) PPers2 Pl) => "نداشتید" ;
  (VF Neg (PPast2 PstAorist) PPers3 Sg) => "نداشت" ;
  (VF Neg (PPast2 PstAorist) PPers3 Pl) => "نداشتند" ;
  (VF Neg (PFut2 FtAorist) PPers1 Sg) => "نخواهم داشت" ;
  (VF Neg (PFut2 FtAorist) PPers1 Pl) => "نخواهیم داشت" ;
  (VF Neg (PFut2 FtAorist) PPers2 Sg) => "نخواهی داشت" ;
  (VF Neg (PFut2 FtAorist) PPers2 Pl) => "نخواهید داشت" ;
  (VF Neg (PFut2 FtAorist) PPers3 Sg) => "نخواهد داشت" ;
  (VF Neg (PFut2 FtAorist) PPers3 Pl) => "نخواهند داشت" ;
  (VF Neg (Infr_Past2 InfrPerf) PPers1 Sg) => "نداشته بوده ام" ;
  (VF Neg (Infr_Past2 InfrPerf) PPers1 Pl) => "نداشته بوده ایم" ;
  (VF Neg (Infr_Past2 InfrPerf) PPers2 Sg) => "نداشته بوده ای" ;
  (VF Neg (Infr_Past2 InfrPerf) PPers2 Pl) => "نداشته بوده اید" ;
  (VF Neg (Infr_Past2 InfrPerf) PPers3 Sg) => "نداشته بوده است" ;
  (VF Neg (Infr_Past2 InfrPerf) PPers3 Pl) => "نداشته بوده اند" ;
  (VF Neg (Infr_Past2 InfrImperf) PPers1 Sg) => "نمی داشته ام" ;
  (VF Neg (Infr_Past2 InfrImperf) PPers1 Pl) => "نمی داشته ایم" ;
  (VF Neg (Infr_Past2 InfrImperf) PPers2 Sg) => "نمی داشته ای" ;
  (VF Neg (Infr_Past2 InfrImperf) PPers2 Pl) => "نمی داشته اید" ;
  (VF Neg (Infr_Past2 InfrImperf) PPers3 Sg) => "نمی داشته است" ;
  (VF Neg (Infr_Past2 InfrImperf) PPers3 Pl) => "نمی داشته اند" ;
  (Vvform (AgPes Sg PPers1)) => "بدارم" ;
  (Vvform (AgPes Sg PPers2)) => "بداری" ;
  (Vvform (AgPes Sg PPers3)) => "بدارد" ;
  (Vvform (AgPes Pl PPers1)) => "بداریم" ;
  (Vvform (AgPes Pl PPers2)) => "بدارید" ;
  (Vvform (AgPes Pl PPers3)) => "بدارند" ;
  (R.Imp Pos Sg) => "بدار" ;
  (R.Imp Pos Pl) => "بدارید" ;
  (R.Imp Neg Sg) => "ندار" ;
  (R.Imp Neg Pl) => "ندارید" ;
  Inf => "داشتن" ;
  Root1 => "داشت" ;
  Root2 => "دار" 
  } ;
  c2 = {
    s  = [] ;
    ra = [] ; --- "را" ;  ---- AR 18/9/2017: usually no ra acc. to Nasrin, but this is tricky 
    c = R.VTrans
    }
  } ;


}


