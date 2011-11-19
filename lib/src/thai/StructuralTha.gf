concrete StructuralTha of Structural = CatTha ** 
  open ParadigmsTha, ResTha, Prelude in {

  flags coding = utf8 ;

  lin
  above_Prep = ss (thbind "ข้าง" "บน") ;
--  after_Prep = ss "after" ;
--  all_Predet = ss "all" ;
  almost_AdA, almost_AdN = ss (thbind "เกิ" "อบ") ;
--  although_Subj = ss "although" ;
  always_AdV = ss (thbind "ตลอด" "ไป") ;
  and_Conj = {s1 = [] ; s2 = "และ"} ;
--  because_Subj = ss "because" ;
--  before_Prep = ss "before" ;
--  behind_Prep = ss "behind" ;
--  between_Prep = ss "between" ;
--  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
--  but_PConj = ss "but" ;
  by8agent_Prep = ss [] ;
--  by8means_Prep = ss "by" ;
  can8know_VV = {s = pen_s ; typ = VVPost} ;
  can_VV = {s = way_s ; typ = VVPost} ;
--  during_Prep = ss "during" ;
--  either7or_DConj = sd2 "either" "or" ** {n = Sg} ;
--  everybody_NP = regNP "everybody" Sg ;
--  every_Det = mkDeterminer Sg "every" ;
--  everything_NP = regNP "everything" Sg ;
--  everywhere_Adv = ss "everywhere" ;
--  few_Det = mkDeterminer Pl "few" ;
--  first_Ord = ss "first" ;
--  for_Prep = ss "for" ;
--  from_Prep = ss "from" ;
  have_V2 = mkV2 "มี" ;
  he_Pron = ss khaw_s ;
--  here_Adv = ss "here" ;
--  here7to_Adv = ss ["to here"] ;
--  here7from_Adv = ss ["from here"] ;
--  how_IAdv = ss "how" ;
--  how8many_IDet = mkDeterminer Pl ["how many"] ;
--  if_Subj = ss "if" ;
--  in8front_Prep = ss ["in front of"] ;
  i_Pron  = ss chan_s ;
--  in_Prep = ss "in" ;
  it_Pron  = ss "มัน" ;
--  less_CAdv = ss "less" ;
--  many_Det = mkDeterminer Pl "many" ;
--  more_CAdv = ss "more" ;
--  most_Predet = ss "most" ;
--  much_Det = mkDeterminer Sg "much" ;
  must_VV = {s = tog_s ; typ = VVPre} ;
  no_Utt = ss may_s ;
--  on_Prep = ss "on" ;
--  one_Quant = mkDeterminer Sg "one" ;
--  only_Predet = ss "only" ;
  or_Conj = {s1 = [] ; s2 = "หริอ"} ;
--  otherwise_PConj = ss "otherwise" ;
--  part_Prep = ss "of" ;
  please_Voc = ss "ขอ" ;
  possess_Prep = ss "ของ" ;
--  quite_Adv = ss "quite" ;
  she_Pron = ss khaw_s ;
--  so_AdA = ss "so" ;
--  somebody_NP = regNP "somebody" Sg ;
--  someSg_Det = mkDeterminer Sg "some" ;
--  somePl_Det = mkDeterminer Pl "some" ;
--  something_NP = regNP "something" Sg ;
--  somewhere_Adv = ss "somewhere" ;
  that_Quant = ss nan_s ** {hasC = True} ;
--  that_NP = regNP "that" Sg ;
--  there_Adv = ss "there" ;
--  there7to_Adv = ss "there" ;
--  there7from_Adv = ss ["from there"] ;
--  therefore_PConj = ss "therefore" ;
--  these_NP = regNP "these" Pl ;
  they_Pron = mkNP khaw_s ;
  this_Quant = ss nii_s ** {hasC = True} ;
--  this_NP = regNP "this" Sg ;
--  those_NP = regNP "those" Pl ;
--  through_Prep = ss "through" ;
  too_AdA = ss (thbind "เกิน" "ไป") ;
--  to_Prep = ss "to" ;
--  under_Prep = ss "under" ;
  very_AdA = ss "มาก" ;
  want_VV = {s = yaak_s ; typ = VVMid} ;
  we_Pron = ss raw_s ;
  whatPl_IP, whatSg_IP = ss (thbind "อะ" "ไร") ;
--  when_IAdv = ss "when" ;
--  when_Subj = ss "when" ;
  where_IAdv = ss (thbind "ฑี" "ไหน") ;
  which_IQuant = {s1 = "ไหน" ; s2 = [] ; hasC = True} ;
  whoPl_IP, whoSg_IP = ss "ไคร" ;
  why_IAdv = ss (thbind "ฑำ" "ไม") ;
--  without_Prep = ss "without" ;
--  with_Prep = ss "with" ;
  yes_Utt = ss chay_s ;
  youSg_Pron = ss khun_s ;
  youPl_Pron = ss khun_s ;
  youPol_Pron = ss khun_s ;
--
--
--oper
--  mkQuant : Str -> Str -> {s : Number => Str} = \x,y -> {
--    s = table Number [x ; y]
--    } ;
--

-- from Swadesh
  here_Adv = ss (thbind "ที่นี่") ;
  there_Adv = ss (thbind "ที่นั่น") ;
  when_IAdv = ss (thbind "เมื่อไร") ;
  how_IAdv = ss (thbind "อย่างไร") ;
  all_Predet = ss (thbind "ทั้ง" "หมด") ;
  many_Det = {s1 = thbind "หลาย" ; s2 = [] ; hasC = True} ;
  some_Det = {s1 = thbind "บ้าง" ; s2 = [] ; hasC = True} ;
  few_Det = {s1 = thbind "สอง" "สาม" ; s2 = [] ; hasC = True} ;
  right_Ord = ss (thbind "ขวา") ;
  left_Ord = ss (thbind "ซ้าย") ;
  at_Prep = ss (thbind "ที่") ;
  in_Prep = ss (thbind "ใน") ;
  with_Prep = ss (thbind "กับ") ;
--  and_N = mkN (thbind "และ") ;
  if_Subj = ss (thbind "ถ้า") ;
  because_Subj = ss (thbind "เพราะ") ;
  name_N = mkN (thbind "ชื่อ") ;

}

