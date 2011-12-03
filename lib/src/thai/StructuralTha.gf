concrete StructuralTha of Structural = CatTha ** 
  open ParadigmsTha, ResTha, Prelude in {

  flags coding = utf8 ;

  lin
  above_Prep = ss (thword "ข้าง" "บน") ;
  after_Prep = ss "หลัง" ;
  all_Predet = ss (thword "ทั้ง" "หมด") ;
  almost_AdA, almost_AdN = ss (thword "เกิ" "อบ") ;
  although_Subj = ss "ถืง" ;
  always_AdV = ss (thword "ตลอด" "ไป") ;
  and_Conj = {s1 = [] ; s2 = "และ"} ;
  because_Subj = ss (thword "เพ" "ราะ") ;
  before_Prep = ss "ก่อน" ;
  behind_Prep = ss "หลัง" ;
  between_Prep = ss (thword "ระ" "หวา่ง") ;
--  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
  but_PConj = ss "แต่" ;
  by8agent_Prep = ss [] ;
  by8means_Prep = ss "ผ่าน" ;
  can8know_VV = {s = pen_s ; typ = VVPost} ;
  can_VV = {s = "ได้" ; typ = VVPost} ;
  during_Prep = ss "ที" ;
--  either7or_DConj = sd2 "either" "or" ** {n = Sg} ;
  everybody_NP = mkNP (thword "ทัว" "ห้นา") ;
  every_Det = quantDet "ทุก" ;
  everything_NP = mkNP (thword "ทุก" "สิ่ง") ;
  everywhere_Adv = ss (thword "ทุก" "ที") ;
  few_Det = quantDet (thword "สอง" "สาม") ;
  for_Prep = ss "ให้" ;
  from_Prep = ss "จาก" ;
  have_V2 = mkV2 "มี" ;
  he_Pron = ss khaw_s ;
  here_Adv = ss (thword "ที่" "นี่") ;
  here7to_Adv = ss "ที่นี่" ; ----
  here7from_Adv = ss (thword "จาก" "นี่") ; ----
  how_IAdv = ss (thword "อย่าง" "ไร") ;
  how8many_IDet = quantDet "กี่" ;
  how8much_IAdv = ss (thword "เท่า" "ไร") ;
  in8front_Prep = ss "หน้า" ;
  i_Pron  = ss chan_s ;
  if_Subj = ss (thword "ถ้า") ;
  in_Prep = ss (thword "ใน") ;
  it_Pron  = ss "มัน" ;
  less_CAdv = {s = "น้อย" ; p = "กว่า"} ; ----
  many_Det = quantDet "หลาย" ;
  more_CAdv = {s = "มาก" ; p = "กว่า"} ; ----
  most_Predet = ss (thword "มาก" "ที่" "สุด") ;
  much_Det = quantDet "มาก" ;
  must_VV = {s = tog_s ; typ = VVPre} ;
  no_Utt = ss may_s ;
  on_Prep = ss "บน" ;
  only_Predet = ss (thword "เฑา" "นั้น") ;
  or_Conj = {s1 = [] ; s2 = "หริอ"} ;
  otherwise_PConj = ss (thword "ไม่" "งัน") ;
  part_Prep = ss "" ; ----
  please_Voc = ss "ขอ" ;
  possess_Prep = ss "ของ" ;
  quite_Adv = ss (thword "คอน" "ข้าง") ;
  she_Pron = ss khaw_s ;
  so_AdA = ss (thword "เท่า" "กัน") ; ----
  somebody_NP = mkNP (thword "บาง" "คน") ;
  somePl_Det = quantDet ("บ้าง") ;
  someSg_Det = quantDet ("บ้าง") ;
  something_NP = mkNP (thword "บาง" "สิ่ง") ;
  somewhere_Adv = mkAdv (thword "บาง" "แห่ง") ;
  that_Quant = demDet nan_s ;
  there_Adv = ss (thword "ที่" "นั่น") ;
  there7to_Adv = ss (thword "ที่" "นั่น") ; ----
  there7from_Adv = ss (thword "จาก" "นั่น") ; ----
  therefore_PConj = ss (thword "เพราะ" "ฉะ" "นั้น") ;
  they_Pron = mkNP khaw_s ;
  this_Quant = demDet nii_s ;
  through_Prep = ss "ผ่าน" ;
  too_AdA = ss (thword "เกิน" "ไป") ;
  to_Prep = ss "ถืง" ;
  under_Prep = ss "ใต้" ;
  very_AdA = ss "มาก" ;
  want_VV = {s = yaak_s ; typ = VVMid} ;
  we_Pron = ss raw_s ;
  whatPl_IP, whatSg_IP = ss (thword "อะ" "ไร") ;
  when_IAdv = ss (thword "เมื่อไร") ;
  when_Subj = ss "ฑี" ;
  where_IAdv = ss (thword "ที่" "ไหน") ;
  which_IQuant = demDet "ไหน" ; 
  whoPl_IP, whoSg_IP = ss "ไคร" ;
  why_IAdv = ss (thword "ฑำ" "ไม") ;
  without_Prep = ss (thword "ไ่ม" "มี") ;
  with_Prep = ss "กับ" ;
  yes_Utt = ss chay_s ;
  youSg_Pron = ss khun_s ;
  youPl_Pron = ss khun_s ;
  youPol_Pron = ss khun_s ;

  right_Ord = ss (thword "ขวา") ;
  left_Ord = ss (thword "ซ้าย") ;
}

