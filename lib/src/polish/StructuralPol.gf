--# -path=.:../abstract:../common:../prelude

-- Ilona Nowak Wintersemester 2007/08  

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

-- In Polish language they aren't determiners like in english or german.

concrete StructuralPol of Structural = CatPol ** 
  open ResPol, MorphoPol, ParadigmsPol, Prelude in {


  flags optimize=all; coding=utf8;

lin

  above_Prep = mkPrep "nad" Instr; 
  after_Prep = mkPrep "po"  Loc;

  all_Predet = { s=wszystek; np=wszystko; adj=True };
  almost_AdA, almost_AdN = ss "prawie";
  although_Subj = ss "pomimo";
  always_AdV = ss "zawsze";
  and_Conj = {s1=""; s2 = "i";  sent1=""; sent2=["i"]};
  at_least_AdN = ss "co najmniej";
  at_most_AdN = ss "co najwyżej";
  because_Subj = ss "ponieważ";
  before_Prep = mkPrep "przed" Instr;
  behind_Prep = mkPrep "za" Instr;
  between_Prep = mkPrep "między" Instr;
  both7and_DConj = {s1="zarówno"; s2=["jak i"]; sent1="zarówno"; sent2=[", jak i"]};
  but_PConj = ss "ale";
  by8agent_Prep = mkPrep "przez" Acc;
  by8means_Prep = mkPrep "przez" Acc;
  can8know_VV = mkItVerb (mkMonoVerb "umieć" conj101 Imperfective);
  can_VV  = mkItVerb (mkMonoVerb "móc" conj27 Imperfective);
  during_Prep  = mkPrep "podczas" Gen; -- def. in ParadigmsPol
  either7or_DConj = {s1="albo"; s2="albo";  sent1="albo"; sent2=[", albo"]};
  every_Det  = kazdyDet;
  everybody_NP = wszyscy ** {lock_NP=<>};
  everything_NP  = wszystko ** {lock_NP=<>};
  everywhere_Adv = ss "wszędzie";
  except_Prep = mkPrep "z wyjątkiem" Acc;
  few_Det = pareDet;
  for_Prep = mkPrep "dla" Gen;
  from_Prep  = mkPrep "z" Gen; -- def. in ParadigmsPol
  have_V2 = dirV2 (mkMonoVerb "mieć" conj100 Imperfective); 
  he_Pron  = pronOn;
  here_Adv = ss "tutaj";
  here7to_Adv = ss "tutaj";
  here7from_Adv = ss "stąd";
  how_IAdv  = ss "jak";
  how8many_IDet = ileDet; 
  i_Pron   = pronJa;
  if_Subj    = ss "jeśli";
  if_then_Conj = {s1="jeżeli"; s2=[", to"];  sent1="jeżeli"; sent2=[", to"]};
  in8front_Prep  = mkPrep "przed" Instr;
  in_Prep  =  mkPrep "w" Loc;
  it_Pron    = pronOno;
  language_title_Utt = ss "polski";
  less_CAdv = {s,sn = "mniej" ; p,pn = "niż" } ;
  many_Det  = wieleDet;
  more_CAdv = {s = "bardziej" ; pn,p = "niż"; sn="więcej"} ;
  most_Predet = { s=wszystek; np={nom="większość"; voc="większości"; 
    dep=table{AccPrep|AccNoPrep=>"większość"; InstrPrep|InstrNoPrep=>"większością"; _=>"większości"}; 
    p=P3; gn=FemSg}; adj=False };
  much_Det   = duzoDet;
  must_VV = mkItVerb (mkMonoVerb "musieć" conj93 Imperfective);
  no_Quant = zadenQuant;
  no_Utt  = ss "nie";
  nobody_NP = niktNP;
  not_Predet = { s=zadenQuant.s; np=wszystko; adj=True };
  nothing_NP = nicNP;
  on_Prep = mkPrep "nа" Loc; 
  only_Predet = { s=\\_=>"tylko"; np=wszystko; adj=True };
  or_Conj  = {s1=""; s2="lub";  sent1=""; sent2=["lub"]};
  otherwise_PConj  = ss "inaczej"; 
  part_Prep = mkPrep "z" Gen; 
  please_Voc = ss "proszę";
  possess_Prep  = mkPrep "" Gen; --overgenerating with pronouns
  quite_Adv = ss "całkiem";
  she_Pron   = pronOna;
  so_AdA = ss "tak";
  somebody_NP = ktos ** {lock_NP = <>};
  someSg_Det = pewienDet;
  somePl_Det = pewniDet;
  something_NP  = cos ** {lock_NP = <>};
  somewhere_Adv  = ss "gdzieś";
  that_Quant = demPronTen "tamten";
  there_Adv = ss "tam";
  there7to_Adv = ss "tam";
  there7from_Adv = ss "stamtąd";
  therefore_PConj  = ss "dlatego";
  they_Pron = pronOni;-- pronOneFem; pronOneNeut};
  this_Quant = demPronTen "ten";
  through_Prep  = mkPrep "przez" Acc;
  to_Prep = mkPrep "do" Gen; -- def. in ParadigmsPol.gf
  too_AdA = ss "za"; 
  under_Prep = mkPrep "pod" Instr; -- with Acc too
  very_AdA = ss "bardzo";
  want_VV = mkV "chcieć" conj45 "zechcieć" conj45;
  we_Pron = pronMy;
  whatPl_IP = co;
  whatSg_IP = co;
  when_IAdv = ss "kiedy";
  when_Subj = ss "jeśli";
  where_IAdv = ss "gdzie";
  which_IQuant = { s = ktory };
  whoPl_IP = kto;
  whoSg_IP = kto;
  why_IAdv = ss "dlaczego";
  with_Prep = mkPrep "z" Instr;
  without_Prep = mkPrep "bez" Gen; -- def. in ParadigmsPol.gf
  youPl_Pron = pronWy;
  yes_Utt = ss "tak";
  youSg_Pron = pronTy;
  youPol_Pron =  pronTy;

  as_CAdv = { s,sn="tak"; p,pn="jak"} ;

};
