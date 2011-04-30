concrete StructuralPnb of Structural = CatPnb ** 
  open MorphoPnb, ParadigmsPnb, Prelude, NounPnb in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = ss "atE" ;
  after_Prep = ss "twN bed" ;
  all_Predet = ss "sarE" ;
  almost_AdA, almost_AdN = ss "tqryba" ;
  although_Subj = ss "pawyN" ;
  always_AdV = ss "hmyXh" ;
  and_Conj = sd2 [] "tE" ** {n = Pl} ;
  because_Subj = ss "kywnkh'" ;
  before_Prep = ss "plE" ;
  behind_Prep = ss "pych'E" ;
  between_Prep = ss "wckar" ;
  both7and_DConj = sd2 "dwwyN" "tE" ** {n = Pl} ;
  but_PConj = ss "mgr" ;
  by8agent_Prep = ss "" ;
  by8means_Prep = ss "" ;
  can8know_VV,can_VV = mkV "skna" ** { isAux = True} ;
  during_Prep = ss ["dE wc"] ;
  either7or_DConj = sd2 "kwy ak" "ya" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (MorphoPnb.mkN11 "hr kwy")); -- not a good way coz need to include NounPnb
  every_Det = mkDet "hr" "hr" "hr" "hr" Sg;
  everything_NP = MassNP (UseN (MorphoPnb.mkN11 "hr XE"));
  everywhere_Adv = mkAdv "hr th'aN" ;
  few_Det = mkDet "kch'" "kch'" "kch'" "kch'" Pl ;
  first_Ord = {s = "pehla" ; n = Sg} ; --DEPRECATED
  for_Prep = ss "[dE wast-E]" ;
  from_Prep = ss "twN" ;
  he_Pron = personalPN "aw" "awnwN" "aw" "awrE" "awra"  Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "ayth'E" ;
  here7to_Adv = mkAdv "ayth'E" ;
  here7from_Adv = mkAdv "ayth'wN" ;
  how_IAdv = ss "ksraN" ;
  how8many_IDet = makeIDet "kynE" "kyny" Pl ;
  how8much_IAdv  = ss "kyna" ;
  if_Subj = ss "agr" ;
  in8front_Prep = ss ["dE samnE"] ;
  i_Pron = personalPN "myN" "mynwN" "mynwN" "mytwN" "myra" Sg Masc Pers1;
  in_Prep = ss "wc" ;
  it_Pron  = personalPN "aE" "aynwN" "aynwN" "" "ayra" Sg Masc Pers3_Near;
  less_CAdv = {s = "kT" ; p = ""} ;
  many_Det = mkDet "bht zyadh" "bht zyadh" "bht zyadh" "bht zyadh" Pl ;
  more_CAdv = {s = "hwr" ; p = "" } ;
  most_Predet = ss "zyadh tr" ;
  much_Det = mkDet "bht" "bht" "bht" "bht" Sg  ;
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
  no_Utt = ss "nyN" ;
  on_Prep = ss "atE" ;
  one_Quant = demoPN "ak" "ak" "ak"  ; -- DEPRECATED
  only_Predet = ss "Srf" ;
  or_Conj = sd2 [] "ya" ** {n = Sg} ;
  otherwise_PConj = ss "ya fyr" ;
  part_Prep = ss "hSh" ;
  please_Voc = ss "mhrbani" ;
  possess_Prep = ss "da" ;
  quite_Adv = ss "khamosh" ;
  she_Pron = personalPN "aw" "awnwN" "awnw" "awrE" "awra" Sg Fem Pers3_Distant ;
  so_AdA = ss "so" ;
  somebody_NP = MassNP (UseN (MorphoPnb.mkN11 "kwy" ));
  someSg_Det = mkDet "kch'" "kch'" "kch'" "kch'" Sg ;
  somePl_Det = mkDet "kch'" "kch'" "kch'" "kch'" Pl ;
  something_NP = MassNP (UseN (MorphoPnb.mkN11 "kwy XE"));
  somewhere_Adv = mkAdv "ktlE" ;
  that_Quant = demoPN "aw" "as" "an" ;
  that_Subj = ss "kh";
  there_Adv = mkAdv "awth'E" ;
  there7to_Adv = mkAdv "awth'E" ;
  there7from_Adv = mkAdv "awth'wN" ;
  therefore_PConj = ss "as ly" ;
  they_Pron = personalPN "aw" "[awnaN nwN]" "aw" "awnaN" "awnaN da" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "aE" "ayra" "aynaN";      
  through_Prep = ss "wcwN" ;
  too_AdA = ss "bht" ;
--  to_Prep = ss "awnwN" ** {lock_Prep = <>};
  to_Prep = ss "nwN" ** {lock_Prep = <>};
  under_Prep = ss "th'lE" ** {lock_Prep = <>};
  very_AdA = ss "bht" ;
  want_VV = mkV "cana" ** { isAux = False} ;
  we_Pron = personalPN "asy" "sanwN" "sanwN" "satwN" "saDa" Pl Masc Pers1 ;
  whatSg_IP = mkIP "kya" "kra" "kra" "kra" Sg Masc ; -- check it
--  whatPl_IP = mkIP "kya" "kin" "kin" Pl Masc ;
  when_IAdv = ss "kdwN" ;
  when_Subj = ss "kdwN" ;
  where_IAdv = ss "kth'E" ;
  which_IQuant = mkIQuant "kyRa" "kyRy" "kyRE" "kyRy" ;
--  whichPl_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
--  whichSg_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
  whoSg_IP = mkIP "kwn" "kra" "kra" "kra" Sg Masc  ;
--  whoPl_IP = mkIP "kwn" "kn" "knhwN" Pl Masc ;
  why_IAdv = ss "kywN" ;
  without_Prep = ss ["twN bGyr"] ;
  with_Prep = ss ["dE nal"] ;
--  yes_Phr = ss "haN" ;
  yes_Utt = ss "haN" ;
  youSg_Pron = personalPN "twN" "tynwN" "tynwN" "tyrE" "twwaDa" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "tsy" "twanwN" "twanwN" "twaDE" "twwaDa" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "tsy" "twanwN" "twanwN" "twaDE" "twwaDa" Sg Masc Pers2_Respect  ;
  no_Quant =  demoPN " kwy nhyN" "kwy nhyN" "kwy nhyN" ; 
  not_Predet = {s="nhyN"} ;
  if_then_Conj = sd2 "agr" "tE" ** {n = Sg} ; 
  at_least_AdN = ss ["km twN km"] ;
  at_most_AdN = ss ["zyadh twN zyadh"];
  nothing_NP = MassNP (UseN (MorphoPnb.mkN11 "kch' nyN" )); 
  except_Prep = ss "swaE" ;
  nobody_NP = MassNP (UseN (MorphoPnb.mkN11 "kwy nhyN"));  

  as_CAdv = {s = "aynaN" ; p = "jnaN"} ;

  have_V2 = mkV2 (mkV "rakh'na") "" ;

 language_title_Utt = ss "pnjaby" ;

}

