concrete StructuralHin of Structural = CatHin ** 
  open MorphoHin, ParadigmsHin, Prelude, NounHin,ParamX,CommonHindustani in {

  flags optimize=all ;
  coding = utf8;
  
  lin
  above_Prep = mkPrep ["ke: U:par"] ["ke: U:par"] ;
  after_Prep = mkPrep ["ke: ba:d"]  ["ke: ba:d"] ;
  all_Predet = ss "tama:m" ;
  almost_AdA, almost_AdN = mkAdN "taqari:ban" ;
  although_Subj = ss "Agarci" ;
  always_AdV = ss "hame:s*a:" ;
  and_Conj = sd2 [] "O+r" ** {n = Pl} ;
  because_Subj = ss "kX,yo:m.ki" ;
  before_Prep = mkPrep ["se: pahle:"] ["se: pahle:"] ; 
  behind_Prep = mkPrep ["ke: pi:c'e:"] ["ke: pi:c'e:"] ;
  between_Prep = mkPrep ["ke: darmiya:n"] ["ke: darmiya:n"] ;
  both7and_DConj = sd2 "do:no:m." "O+r" ** {n = Pl} ;
  but_PConj = ss "le:kin" ;
  by8agent_Prep = mkPrep "se:" "se:" ;
  by8means_Prep = mkPrep "par" "par" ;
  can8know_VV,can_VV = mkV "sakna:" ** { isAux = True} ;
  during_Prep = mkPrep ["ke: darmiya:n"] ["ke: darmiya:n"] ;
  either7or_DConj = sd2 "ko:I: E:k" "ya:" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsHin.mkN "har ko:I:" "har ko:I:" "har ko:I:" "har ko:I:" "har ko:I:" "har ko:I:" Masc )); 
  every_Det = mkDet "har" "har" "har" "har" Sg;
  everything_NP = MassNP (UseN (ParadigmsHin.mkN "har ci:z" "har ci:z" "har ci:zo:n~" "sab ci:ze:n~" "sab ci:zo:n~" "sab ci:zo:n~" Masc ));
  everywhere_Adv = mkAdv "har jagah" ;
  few_Det = mkDet "cam.d" "cam.d" "cam.d" "cam.d" Pl ;
  first_Ord = {s = "" ; n = Sg} ; --De:PRe:CATe:D
  for_Prep = mkPrep ["ke: liye:"] ["ke: liye:"]  ;
  from_Prep = mkPrep "se:" "se:" ;
  he_Pron = personalPN "vah" "Us" "" "Us ka:" "Us ki:" "Us ke:" "Us ki:" Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "yaha:n~" ;
  here7to_Adv = mkAdv ["yaha:n~ par"] ;
  here7from_Adv = mkAdv ["yaha:n~ se:"] ;
  how_IAdv = ss "ke+se:" ;
  how8many_IDet = makeIDet "kitne:" "kitni:" Pl ;
  how8much_IAdv  = ss "kitna:" ;
  if_Subj = ss "Agar" ;
  in8front_Prep = mkPrep ["ke: sa:mne:"] ["ke: sa:mne:"] ;
  i_Pron = personalPN "me+m." "muj'" "" "me:ra:" "me:ri:" "me:re:" "me:ri:" Sg Masc Pers1;
  in_Prep = mkPrep "me:m." "me:m." ;
  it_Pron  = personalPN "yah" "Is" "yah" "Is ka:" "Is ki:" "Us ke:" "Us ki:" Sg Masc Pers3_Near;
  less_CAdv = {s = "kam" ; p = ""} ;
  many_Det = mkDet "bahut" "bahut" "bahut" "bahut" Pl ;
  more_CAdv = {s = "zX,ya:da:" ; p = "se:" } ;
  most_Predet = ss "sab se: zX,ya:da:" ;
  much_Det = mkDet "bahut" "bahut" "bahut" "bahut" Sg  ;
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
  no_Utt = ss "nahi:m." ;
  on_Prep = mkPrep "par" "par" ;
--  one_Quant = demoPN "" ; -- De:PRe:CATe:D
  only_Predet = ss "sirX,f" ;
  or_Conj = sd2 [] "ya:" ** {n = Sg} ;
  otherwise_PConj = ss "nahi:m. to:" ;
  part_Prep = mkPrep "" "" ;
  please_Voc = ss "kr.pya:" ;
  possess_Prep = mkPrep "ka:" "ki:" ;
  quite_Adv = ss "ka:fi:" ;
  she_Pron = personalPN "vah" "Us" "Us" "Us ka:" "Us ki:" "Us ke:" "Us ki:"  Sg Fem Pers3_Distant ; -- chek with prasad about 'Us'
  so_AdA = ss "to:" ;
  somebody_NP = MassNP (UseN (ParadigmsHin.mkN "ko:I:" "ko:I:" "ko:I:" "ko:I:" "ko:I:" "ko:I:" Masc ));
  someSg_Det = mkDet "kuc'" "kuc'" "kuc'" "kuc'" Sg ;
  somePl_Det = mkDet "kuc'" "kuc'" "kuc'" "kuc'" Pl ;
  something_NP = MassNP (UseN (ParadigmsHin.mkN ["ko:I: ci:z"] ["ko:I: ci:z"] ["ko:I: ci:z"] ["ko:I: ci:z"] ["ko:I: ci:z"] ["ko:I: ci:z"] Masc ));
  somewhere_Adv = mkAdv ["kahi:m."] ;
  that_Quant = demoPN "vah" "ve:" "Us" "Un" ;
  that_Subj = ss "ki";
  there_Adv = mkAdv "vaha:n~" ;
  there7to_Adv = mkAdv ["vaha:n~ par"] ;
  there7from_Adv = mkAdv ["vaha:n~ se:"] ;
  therefore_PConj = ss "Is liye:" ;
  they_Pron = personalPN "ve:" "ve:" "ve:" "Un ka:" "Un ki:" "Un ke:" "Un ki:" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "yah" "ye:" "Is" "In";      
  through_Prep = mkPrep ["me:m. se:"] ["me:m. se:"] ;
  too_AdA = ss "bahut" ;
  to_Prep = mkPrep "ko:" "ko:" ; -- ** {lock_Prep = <>};
  under_Prep = mkPrep ["ke: ni:ce:"] ["ke: ni:ce:"] ; -- ** {lock_Prep = <>};
  very_AdA = ss "bahut" ;
  want_VV = mkV "ca:hna:" ** { isAux = False} ;
  we_Pron = personalPN "ham" "ham" "ham" "hama:ra:" "hama:ri:" "hama:re:" "hama:ri:" Pl Masc Pers1 ;
  whatSg_IP = mkIP "kX,ya:" "kX,ya:" "kX,ya:" Sg Masc ; -- confirm
  whatPl_IP = mkIP "kX,ya:" "kX,ya:" "kX,ya:" Pl Masc ;
  when_IAdv = ss "kab" ;
  when_Subj = ss "kab" ;
  where_IAdv = ss "kaha:n~" ;
  which_IQuant = mkIQuant ["ko+n sa:"] ["ko+n se:"] "" ["ko+n si:"] ["ko+n si:"] ""
                          ["ko+n se:"] ["ko+n se:"] "" ["ko+n si:"] ["ko+n si:"] "" ; -- need to put right forms Prasad
--  whichPl_IDet = makeDet "" ;
--  whichSg_IDet = makeDet "";
  whoSg_IP = mkIP "ko+n" "kis" "kis" Sg Masc  ;
  whoPl_IP = mkIP "ko+n" "kin" "kinho:m." Pl Masc ;
  why_IAdv = ss "kX,yo:m." ;
--  without_Prep = mkPrep ;
  with_Prep = mkPrep ["ke: sa:t'"] ["ke: sa:t'"] ;
--  yes_Phr = ss "???" ;
  yes_Utt = ss "ha:n~" ;
  youSg_Pron = personalPN "tu:" "tum" "tum" "tumX,ha:ra:" "tumX,ha:ri:" "tumX,ha:re:" "tumX,ha:ri:" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "tum" "tum" "tum" "tumX,ha:ra:" "tumX,ha:ri:" "tumX,ha:re:" "tumX,ha:ri:" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "A:p" "A:p" "A:p" "A:p ka:" "A:p ki:" "A:p ke:" "A:p ki:" Sg Masc Pers2_Respect  ;
--  no_Quant =  demoPN "ko:I: nahi:m." ; 
  not_Predet = {s="nahi:m."} ;
--  if_then_Conj = sd2  "Agar to:" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["kam se: kam"] ;
  at_most_AdN = mkAdN ["zX,ya:da: se: zX,ya:da:"];
--  nothing_NP = MassNP (UseN (ParadigmsHin.mkN "kuc' nahi:m." Masc )); 
  except_Prep = mkPrep "ke: siva:y" "ke: siva:y";
--  nobody_NP = MassNP (UseN (ParadigmsHin.mkN "ko:I: nahi:m." Masc ));  

  as_CAdv = {s = "Itna:" ; p = "jitna:"} ;

  have_V2 = mkV2 "rak'na:";

 language_title_Utt = ss "hinX,di:" ;

}

