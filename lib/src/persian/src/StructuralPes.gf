concrete StructuralPes of Structural = CatPes ** 
  open MorphoPes, ParadigmsPes, Prelude, NounPes in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = ss "bAlAy" ;
  after_Prep = ss ["bcd Az"] ;
  all_Predet = ss ["hmh y"] ;
  almost_AdA, almost_AdN = ss "tqrybAa." ;
  although_Subj = ss ["bA vjvd Ayn"] ;
  always_AdV = ss "hmyCh" ;
  and_Conj = sd2 [] "v" ** {n = Pl} ;
  because_Subj = ss ["brAy Ayn"] ;
  before_Prep = ss ["qbl Az"] ;
  behind_Prep = ss "pCt" ;
  between_Prep = ss "byn" ;
  both7and_DConj = sd2 "hm" ["v hm"] ** {n = Pl} ;
  but_PConj = ss "AmA" ;
  by8agent_Prep = ss "tvsT" ;
  by8means_Prep = ss "bA" ;
--  can8know_VV,can_VV = mkV "skna" ** { isAux = True} ;
  during_Prep = ss ["dr Tvl"] ;
  either7or_DConj = sd2 "yA" "yA" ** {n = Sg} ;
--  everybody_NP =  MassNP (UseN (MorphoPnb.mkN11 ["hr kwy"])); -- not a good way coz need to include NounPnb
  every_Det = mkDet "hr" Sg ;
--  everything_NP = MassNP (UseN (MorphoPnb.mkN11 ["hr XE"]));
  everywhere_Adv = ss ["hr jA"] ;
  few_Det = mkDet ["tcdAd kmy"] Pl True; -- check
--  first_Ord = {s = "Avlyn" ; n = Sg} ; --DEPRECATED
  for_Prep = ss "brAy" ;
  from_Prep = ss "Az" ;
  he_Pron = personalPN "Av"  Sg PPers3 ;
  here_Adv = ss "AynjA" ;
  here7to_Adv = ss "AynjA" ;
  here7from_Adv = ss "AynjA" ;
  how_IAdv = ss "c^Tvr" ;
  how8many_IDet = {s = "c^nd" ; n = Pl ; isNum = True} ;
  how8much_IAdv  = ss "c^qdr" ;
  if_Subj = ss "Agr" ;
  in8front_Prep = ss "jlvy" ;
  i_Pron = personalPN "mn" Sg PPers1;
  in_Prep = ss "dr" ;
  it_Pron  = personalPN "A:n" Sg PPers3;
  less_CAdv = {s = "kmtr" ; p = ""} ;
  many_Det = mkDet ["tcdAd zyAdy"] Pl True; -- check
  more_CAdv = {s = "byCtr" ; p = "" } ; 
  most_Predet = ss "Akt-r";
  much_Det = mkDet ["mqdAr zyAdy"]  Pl ;
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


  no_Utt = ss "nh" ;
  on_Prep = ss "rvy" ;
--  one_Quant = demoPN "yk"  ; -- DEPRECATED
  only_Predet = ss "fqT" ;
  or_Conj = sd2 [] "yA" ** {n = Sg} ;
  otherwise_PConj = ss ["drGyrAyn Svrt"] ;
  part_Prep = ss "Az" ; -- the object following it should be in Ezafa form  
  please_Voc = ss "lTfAa." ;
  possess_Prep = ss "" ; -- will be handeled in Ezafeh
  quite_Adv = ss "kAmlAa." ;
  she_Pron = personalPN "Av" Sg PPers3 ;
  so_AdA = ss "bsyAr" ; 
--  somebody_NP = MassNP (UseN (MorphoPnb.mkN11 "kwy" ));
  someSg_Det = mkDet "mqdAry" Sg True ;
  somePl_Det = mkDet "c^nd" Pl True ;
--  something_NP = MassNP (UseN (MorphoPnb.mkN11 "c^yzy"));
  somewhere_Adv = ss "jAyy" ; 
  that_Quant = mkQuant "A:n" "A:n"; 
  that_Subj = ss "A:n"; 
  there_Adv = ss "A:njA" ; 
  there7to_Adv = ss "A:njA" ;
  there7from_Adv = ss "A:njA" ;
  therefore_PConj = ss ["bh hmyn dlyl"] ; 
  they_Pron = personalPN ["A:n hA"] Pl PPers3 ; 
  this_Quant = mkQuant "Ayn" "Ayn" ;  
  through_Prep = ss ["Az Tryq"] ;
  too_AdA = ss "Kyly" ; 
  to_Prep = ss "bh" ** {lock_Prep = <>};
  under_Prep = ss "zyr" ** {lock_Prep = <>};
  very_AdA = ss "Kyly" ;
  want_VV = mkV "KvAstn" "KvAh" ** { isAux = False} ; 
  we_Pron = personalPN "mA" Pl PPers1 ;
  whatSg_IP = {s = ["c^h c^yzy"] ; n = Sg } ;
  whatPl_IP = {s = ["c^h c^yzhAyy"] ; n = Pl } ;
  when_IAdv = ss "ky" ; 
  when_Subj = ss "vqty" ;
  where_IAdv = ss "kjA" ;
  which_IQuant = {s = "kdAm" ; n = Sg} ;
  whichPl_IDet = {s = "kdAm" ; n = Pl ; isNum = False} ;
  whichSg_IDet = { s = "kdAm" ; n = Sg ; isNum = False} ;
  whoSg_IP = {s = ["c^h ksy"] ; n =  Sg}  ;
  whoPl_IP = {s = ["c^h ksAny"] ;n = Pl} ;
  why_IAdv = ss "c^rA" ;
  without_Prep = ss "bdvn" ;
  with_Prep = ss "bA";
--  yes_Phr = ss "blh" ;
  yes_Utt = ss "blh" ;
  youSg_Pron = personalPN "tv" Sg PPers2 ;
  youPl_Pron = personalPN "CmA" Pl PPers2 ;
  youPol_Pron = personalPN "CmA"  Pl PPers2  ; 
--  no_Quant =  demoPN "hyc^" ; 
  not_Predet = {s="nh"} ;
  if_then_Conj = sd2 "Agr" "A:ngAh" ** {n = Sg} ; 
  at_least_AdN = ss "HdAql" ;
  at_most_AdN = ss "HdAkt-r";
--  nothing_NP = MassNP (UseN (MorphoPnb.mkN11 "hyc^ c^yz" )); 
  except_Prep = ss ["bh jz"] ;
--  nobody_NP = MassNP (UseN (MorphoPnb.mkN11 "hyc^ ks"));  

  as_CAdv = {s = ["bh AndAzh y"] ; p = ""} ;

  have_V2 = mkV2 (mkV "dACtn" "dAr") "rA" ;

 language_title_Utt = ss "persian" ;

}


