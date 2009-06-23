concrete StructuralLat of Structural = CatLat ** 
  open ResLat, (P = ParadigmsLat), Prelude in 
  {

  flags optimize=all ;

  lin
  above_Prep = mkPrep "super" Acc ;
  after_Prep = mkPrep "post" Acc ;
--  all_Predet = ss "all" ;
  almost_AdA, almost_AdN = ss "quasi" ;
--  although_Subj = ss "although" ;
  always_AdV = ss "semper" ;
--  and_Conj = sd2 [] "and" ** {n = Pl} ;
-----b  and_Conj = ss "and" ** {n = Pl} ;
--  because_Subj = ss "because" ;
  before_Prep = mkPrep "ante" Acc ;
--  behind_Prep = ss "behind" ;
  between_Prep = mkPrep "inter" Acc ;
--  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
  but_PConj = ss "sed" ;
  by8agent_Prep = mkPrep "a" Abl ;
  by8means_Prep = mkPrep "per" Acc ;
--  can8know_VV, can_VV = {
--    s = table { 
--      VVF VInf => ["be able to"] ;
--      VVF VPres => "can" ;
--      VVF VPPart => ["been able to"] ;
--      VVF VPresPart => ["being able to"] ;
--      VVF VPast => "could" ;      --# notpresent
--      VVPastNeg => "couldn't" ;   --# notpresent
--      VVPresNeg => "can't"
--      } ;
--    isAux = True
--    } ;
--  during_Prep = ss "during" ;
--  either7or_DConj = sd2 "either" "or" ** {n = Sg} ;
--  everybody_NP = regNP "everybody" Sg ;
--  every_Det = mkDeterminer Sg "every" ;
--  everything_NP = regNP "everything" Sg ;
--  everywhere_Adv = ss "everywhere" ;
--  few_Det = mkDeterminer Pl "few" ;
-----  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "pro" Abl ;
  from_Prep = mkPrep "de" Abl ;
  he_Pron = personalPronoun Masc Sg P3 ;
  here_Adv = ss "hic" ;
--  here7to_Adv = ss ["to here"] ;
--  here7from_Adv = ss ["from here"] ;
--  how_IAdv = ss "how" ;
--  how8many_IDet = mkDeterminer Pl ["how many"] ;
--  if_Subj = ss "if" ;
  in8front_Prep = mkPrep "coram" Abl ;
  i_Pron = personalPronoun Masc Sg P1 ;
  in_Prep = mkPrep "in" Abl ;
  it_Pron = personalPronoun Neutr Sg P3 ;
--  less_CAdv = ss "less" ;
--  many_Det = mkDeterminer Pl "many" ;
--  more_CAdv = ss "more" ;
--  most_Predet = ss "most" ;
--  much_Det = mkDeterminer Sg "much" ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["have to"] ;
--      VVF VPres => "must" ;
--      VVF VPPart => ["had to"] ;
--      VVF VPresPart => ["having to"] ;
--      VVF VPast => ["had to"] ;      --# notpresent
--      VVPastNeg => ["hadn't to"] ;      --# notpresent
--      VVPresNeg => "mustn't"
--      } ;
--    isAux = True
--    } ;
-----b  no_Phr = ss "no" ;
  no_Utt = ss "non" ;
--  on_Prep = ss "on" ;
------  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = ss "tantum" ;
--  or_Conj = sd2 [] "or" ** {n = Sg} ;
--  otherwise_PConj = ss "otherwise" ;
  part_Prep = mkPrep [] Gen ;
--  please_Voc = ss "please" ;
  possess_Prep = mkPrep [] Gen ;
--  quite_Adv = ss "quite" ;
  she_Pron = personalPronoun Fem Sg P3 ;
  so_AdA = ss "sic" ;
--  somebody_NP = regNP "somebody" Sg ;
--  someSg_Det = mkDeterminer Sg "some" ;
--  somePl_Det = mkDeterminer Pl "some" ;
--  something_NP = regNP "something" Sg ;
--  somewhere_Adv = ss "somewhere" ;
  that_Quant = ille_Quantifier ;
--  there_Adv = ss "there" ;
--  there7to_Adv = ss "there" ;
--  there7from_Adv = ss ["from there"] ;
--  therefore_PConj = ss "therefore" ;
  they_Pron = personalPronoun Masc Pl P3 ;
  this_Quant = hic_Quantifier ;
--  through_Prep = ss "through" ;
--  too_AdA = ss "too" ;
--  to_Prep = ss "to" ;
  under_Prep = mkPrep "sub" Acc ;
  very_AdA = ss "valde" ;
--  want_VV = P.mkVV (P.regV "want") ;
  we_Pron = personalPronoun Masc Pl P1 ;
--  whatPl_IP = mkIP "what" "what" "what's" Pl ;
--  whatSg_IP = mkIP "what" "what" "what's" Sg ;
--  when_IAdv = ss "when" ;
--  when_Subj = ss "when" ;
--  where_IAdv = ss "where" ;
--  which_IQuant = {s = \\_ => "which"} ;
-----b  whichPl_IDet = mkDeterminer Pl ["which"] ;
-----b  whichSg_IDet = mkDeterminer Sg ["which"] ;
--  whoPl_IP = mkIP "who" "whom" "whose" Pl ;
--  whoSg_IP = mkIP "who" "whom" "whose" Sg ;
--  why_IAdv = ss "why" ;
  without_Prep = mkPrep "sine" Abl ;
  with_Prep = mkPrep "cum" Abl ;
  yes_Utt = ss "sic" ;
  youSg_Pron = personalPronoun Masc Sg P2 ;
  youPl_Pron = personalPronoun Masc Pl P2 ;
  youPol_Pron = personalPronoun Masc Sg P2 ;

  lin language_title_Utt = ss "latina" ;


}

