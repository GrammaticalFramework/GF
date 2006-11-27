concrete StructuralNor of Structural = CatNor ** 
  open MorphoNor, ParadigmsNor, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = ss "ovenfor" ;
  after_Prep = ss "etter" ;
  by8agent_Prep = ss "av" ;
  all_Predet = {s = gennumForms "all" "alt" "alle"} ;
  almost_AdA, almost_AdN = ss "nesten" ;
  although_Subj = ss ["selv om"] ;
  always_AdV = ss "altid" ;
  and_Conj = ss "og" ** {n = Pl} ;
  because_Subj = ss "fordi" ;
  before_Prep = ss "før" ;
  behind_Prep = ss "bakom" ;
  between_Prep = ss "mellom" ;
  both7and_DConj = sd2 "både" "og" ** {n = Pl} ;
  but_PConj = ss "men" ;
  by8means_Prep = ss "med" ;
  can8know_VV, can_VV = 
    mkV "kunne" "kan" nonExist "kunne" "kunnet" nonExist **
    {c2 = [] ; lock_VV = <>} ;
  during_Prep = ss "under" ;
  either7or_DConj = sd2 "enten" "eller" ** {n = Sg} ;
  everybody_NP = regNP "alle" "alles" Plg ;
  every_Det = {s = \\_,_ => "hver" ; n = Sg ; det = DDef Indef} ;
  everything_NP = regNP "alt" "alts" SgNeutr ;
  everywhere_Adv = ss "overalt" ;
  few_Det  = {s = \\_,_ => "få" ; n = Pl ; det = DDef Indef} ;
  first_Ord = {s = "første" ; isDet = True} ;
  for_Prep = ss "for" ;
  from_Prep = ss "fra" ;
  he_Pron = MorphoNor.mkNP "han"  "ham"  "hans" "hans" "hans"  SgUtr P3 ;
  here_Adv = ss "her" ;
  here7to_Adv = ss "hit" ;
  here7from_Adv = ss "herfra" ;
  how_IAdv = ss "hvor" ;
  how8many_IDet = {s = \\_ => ["hur mange"] ; n = Pl ; det = DDef Indef} ;
  if_Subj = ss "hvis" ;
  in8front_Prep = ss "foran" ;
  i_Pron = 
    MorphoNor.mkNP "jeg" "meg" (variants {"min" ; "mi"}) "mit" "mine"  SgUtr P1 ; --- mi
  in_Prep = ss "i" ;
  it_Pron = MorphoNor.regNP "det" "dets" SgNeutr ;
  less_CAdv = ss "mindre" ;
  many_Det = {s = \\_,_ => "mange" ; n = Pl ; det = DDef Indef} ;
  more_CAdv = ss "mer" ;
  most_Predet = {s = gennumForms ["den meste"] ["det meste"] ["de fleste"]} ;
  much_Det = {s = \\_,_ => "mye" ; n = Pl ; det = DDef Indef} ;
  must_VV = 
    mkV "måtte" "må" "få" "måtte" "måttet" "mått" ** {c2 = [] ; lock_VV = <>} ;
  no_Phr = ss ["Nei"] ;
  on_Prep = ss "på" ;
  one_Quant = {s = \\_ => genderForms ["en"] ["et"] ; n = Sg ; det = DIndef} ; --- ei
  only_Predet = {s = \\_ => "kun"} ;
  or_Conj = ss "eller" ** {n = Sg} ;
  otherwise_PConj = ss "annarledes" ;
  part_Prep = ss "av" ;
  please_Voc = ss "takk" ; ---
  possess_Prep = ss "av" ;
  quite_Adv = ss "temmelig" ;
  she_Pron = MorphoNor.mkNP "hun" "henne" "hennes" "hennes" "hennes"  SgUtr P3 ;
  so_AdA = ss "så" ;
  someSg_Det = {s = \\_ => genderForms "noen" "noe" ; n = Sg ; det = DIndef} ;
  somePl_Det = {s = \\_,_ => "noen" ; n = Pl ; det = DIndef} ;
  somebody_NP = regNP "noen" "noens" SgUtr ;
  something_NP = regNP "noe" "noes" SgNeutr ;
  somewhere_Adv = ss ["et eller annet sted"] ; ---- ?
  that_Quant = 
    {s = table {
       Sg => \\_ => genderForms ["den der"] ["det der"] ; 
       Pl => \\_,_ => ["de der"]
       } ;
     det = DDef Indef
    } ;
  that_NP = regNP ["det der"] ["det ders"] SgNeutr ;
  there_Adv = ss "der" ;
  there7to_Adv = ss "dit" ;
  there7from_Adv = ss "derfra" ;
  therefore_PConj = ss "derfor" ;
  these_NP = regNP ["disse"] ["disses"] Plg ;
  they_Pron = MorphoNor.mkNP "de" "dem" "deres" "deres" "deres" Plg P1 ;
  this_Quant = 
    {s = table {
       Sg => \\_ => genderForms ["denne"] ["dette"] ; 
       Pl => \\_,_ => ["disse"]
       } ;
     det = DDef Def
    } ;
  this_NP = regNP ["dette"] ["dettes"] SgNeutr ;
  those_NP = regNP ["de der"] ["de ders"] Plg ;
  through_Prep = ss "gjennom" ;
  too_AdA = ss "for" ;
  to_Prep = ss "til" ;
  under_Prep = ss "under" ;
  very_AdA = ss "mye" ;
  want_VV = 
    mkV "ville" "vil" nonExist "ville" "villet" "villed" ** 
    {c2 = [] ; lock_VV = <>} ;
  we_Pron = MorphoNor.mkNP "vi"  "oss"  "vår" "vårt" "våre"  Plg P1 ;
  whatSg_IP = {s = \\_ => "hva" ; gn = SgUtr} ; ---- infl
  whatPl_IP = {s = \\_ => "hva" ; gn = Plg} ; ---- infl
  when_IAdv = ss "når" ;
  when_Subj = ss "når" ;
  where_IAdv = ss "hver" ;
  whichPl_IDet = {s = \\_ => "hvilke" ; n = Pl ; det = DIndef} ;
  whichSg_IDet = {s = genderForms "hvilken" "hvilket" ; n = Sg ; det = DIndef} ;
  whoSg_IP = {s = vem.s ; gn = SgUtr} ;
  whoPl_IP = {s = \\_ => "hvilke" ; gn = Plg} ;
  why_IAdv = ss "hvorfor" ;
  without_Prep = ss "uten" ;
  with_Prep = ss "med" ;
  yes_Phr = ss ["ja"] ;
  youSg_Pron = 
    MorphoNor.mkNP "du" "deg" (variants {"din" ; "di"}) "dit" "dine" SgUtr P2 ; ----
  youPl_Pron = MorphoNor.mkNP "dere" "dere" "deres" "deres" "deres"  Plg P2 ;
  youPol_Pron = MorphoNor.mkNP "Dere" "Dere" "Deres" "Deres" "Deres"  SgUtr P2 ; --- wrong in refl

-- Auxiliaries that are used repeatedly.

  oper
    vem = MorphoNor.mkNP "hvem" "hvem" "hvis" "hvis" "hvis" SgUtr P3 ;

}

