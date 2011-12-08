concrete StructuralTha of Structural = CatTha ** 
  open ParadigmsTha, ResTha, Prelude in {

  flags coding = utf8 ;

  lin
  above_Prep = ss (thword "ข้าง" "บน") ;
  after_Prep = ss (thword "หลัง" "จาก") ;
  all_Predet = {s1 = thword "ทั้ง" "หมด" ; s2 = []} ;
  almost_AdA, almost_AdN = ss (thword "เกิ" "อบ") ;
  although_Subj = ss "ถืง" ;
  always_AdV = ss (thword "เส" "มอ") ; --- pronunciation
  and_Conj = {s1 = [] ; s2 = "และ"} ;
  as_CAdv = {s = thword "เท่า" ; p = "กับ"} ; ----
  at_least_AdN = ss (thword "อย่าง" "น้อย") ;
  at_most_AdN = ss (thword "อย่าง" "มาก") ;
  because_Subj = ss (thword "เพ" "ราะ") ;
  before_Prep = ss "ก่อน" ;
  behind_Prep = ss "หลัง" ;
  between_Prep = ss (thword "ระ" "หว่าง") ;
  both7and_DConj = {s1 = "ทั้ง" ; s2 = "และ"} ;
  but_PConj = ss "แต่" ;
  by8agent_Prep = ss [] ;
  by8means_Prep = ss "ผ่าน" ;
  can8know_VV = {s = pen_s ; typ = VVPost} ;
  can_VV = {s = "ได้" ; typ = VVPost} ;
  during_Prep = ss (thword "ระ" "หว่าง") ;
  either7or_DConj = {s1 = [] ; s2 = "หริอ"} ; ---- or: mai - ko
  everybody_NP = mkNP (thword "ทุก" "คน") ;
  every_Det = quantDet "ทุก" ;
  everything_NP = mkNP (thword "ทุก" "สิ่ง") ;
  everywhere_Adv = ss (thword "ทุก" "ที") ;
  except_Prep = ss (thword "นอก" "จาก") ;
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
  if_Subj = ss (thword "ถ้า") ; ---- ... ko
  if_then_Conj = {s1 = "ถ้า" ; s2 = "ก็"} ; ---- ko between subj and verb
  in_Prep = ss (thword "ใน") ;
  it_Pron  = ss "มัน" ;
  less_CAdv = {s = "น้อย" ; p = "กว่า"} ;
  many_Det = quantDet "หลาย" ;
  more_CAdv = {s = "มาก" ; p = "กว่า"} ;
  most_Predet = {s1 = thword "มาก" "ที่" "สุด" ; s2 = []} ;
  much_Det = quantDet "หลาย" ; ---- always?
  must_VV = {s = tog_s ; typ = VVPre} ;
  no_Quant = quantDet (thword "ไม่" "มี") ;
  no_Utt = ss may_s ;
  nobody_NP = mkNP (thword "ไม่" "มี" "ใคร") ;
  not_Predet = {s1 = may_s ; s2 = []} ; ----
  nothing_NP = mkNP "เปล่า" ;
  on_Prep = ss "บน" ;
  only_Predet = {s1 = [] ; s2 = thword "เท่า" "นั้น"} ;
  or_Conj = {s1 = [] ; s2 = "หริอ"} ;
  otherwise_PConj = ss (thword "ไม่" "อย่าง" "นั้น") ;
  part_Prep = ss "" ; ----
  please_Voc = ss "ขอ" ;
  possess_Prep = ss "ของ" ;
  quite_Adv = ss (thword "ค่อน" "ข้าง") ;
  she_Pron = ss "หล่อน" ;
  so_AdA = ss (thword "ดัง" "นั้น") ;
  somebody_NP = mkNP (thword "บาง" "คน") ;
  somePl_Det = quantDet ("บาง") ;
  someSg_Det = quantDet ("บาง") ;
  something_NP = mkNP (thword "บาง" "สิ่ง") ;
  somewhere_Adv = mkAdv (thword "บาง" "แห่ง") ;
  that_Quant = demDet nan_s ;
  that_Subj = ss conjThat ;
  there_Adv = ss (thword "ที่" "นั่น") ;
  there7to_Adv = ss (thword "ที่" "นั่น") ; ----
  there7from_Adv = ss (thword "จาก" "นั่น") ; ----
  therefore_PConj = ss (thword "เพราะ" "ฉะ" "นั้น") ;
  they_Pron = mkNP (thword "พวก" khaw_s) ; --- mkNP (thword "เขา" "ทั้ง" "หลาย") ;
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
  when_Subj = ss "ที" ;
  where_IAdv = ss (thword "ที่" "ไหน") ;
  which_IQuant = demDet "ไหน" ; 
  whoPl_IP, whoSg_IP = ss "ใคร" ;
  why_IAdv = ss (thword "ทำ" "ไม") ;
  without_Prep = ss (thword "ไม่" "มี") ;
  with_Prep = ss "กับ" ;
  yes_Utt = ss chay_s ;
  youSg_Pron = ss khun_s ;
  youPl_Pron = ss (thword "พวก" khun_s) ;
  youPol_Pron = ss khun_s ;
  right_Ord = ss (thword "ขวา") ;
  left_Ord = ss (thword "ซ้าย") ;
}

