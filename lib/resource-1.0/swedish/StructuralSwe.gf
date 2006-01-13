concrete StructuralSwe of Structural = CatSwe ** 
  open MorphoSwe, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = ss "ovanför" ;
  after_Prep = ss "efter" ;
  by8agent_Prep = ss "av" ;
  all_Predet = {s = gennumForms "all" "allt" "alla"} ;
  almost_AdA, almost_AdN = ss "nästan" ;
  although_Subj = ss "fast" ;
  always_AdV = ss "alltid" ;
  and_Conj = ss "och" ** {n = Pl} ;
  because_Subj = ss "eftersom" ;
  before_Prep = ss "före" ;
  behind_Prep = ss "bakom" ;
  between_Prep = ss "mellan" ;
  both7and_DConj = sd2 "både" "och" ** {n = Pl} ;
  but_PConj = ss "men" ;
  by8means_Prep = ss "med" ;
  can8know_VV, can_VV = 
    mkVerb6 "kunna" "kan" "kunn" "kunde" "kunnat" "kunnen" **
    {c2 = [] ; lock_VV = <>} ;
  during_Prep = ss "under" ;
  either7or_DConj = sd2 "antingen" "eller" ** {n = Sg} ;
  everybody_NP = regNP "alla" "allas" Plg ;
  every_Det = {s = \\_,_ => "varje" ; n = Sg ; det = DDef Indef} ;
  everything_NP = regNP "allting" "alltings" SgNeutr ;
  everywhere_Adv = ss "överallt" ;
  from_Prep = ss "från" ;
  he_Pron = mkNP "han"  "honom"  "hans" "hans" "hans"  SgUtr P3 ;
  here_Adv = ss "här" ;
  here7to_Adv = ss "hit" ;
  here7from_Adv = ss "härifrån" ;
  how_IAdv = ss "hur" ;
  how8many_IDet = {s = \\_ => ["hur många"] ; n = Pl ; det = DDef Indef} ;
  if_Subj = ss "om" ;
  in8front_Prep = ss "framför" ;
  i_Pron = mkNP "jag"  "mig"  "min" "mitt" "mina"  SgUtr P1 ;
  in_Prep = ss "i" ;
  it_Pron = regNP "det" "dess" SgNeutr ;
  less_CAdv = ss "mindre" ;
  many_Det = {s = \\_,_ => "många" ; n = Pl ; det = DDef Indef} ;
  more_CAdv = ss "mer" ;
  most_Predet = {s = gennumForms ["den mesta"] ["det mesta"] ["de flesta"]} ;
  much_Det = {s = \\_,_ => "mycket" ; n = Pl ; det = DDef Indef} ;
  must_VV = 
    mkVerb6 "få" "måste" "få" "fick" "måst" "måst" ** {c2 = [] ; lock_VV = <>} ;
  no_Phr = ss ["Nej"] ;
  on_Prep = ss "på" ;
  only_Predet = {s = \\_ => "bara"} ;
  or_Conj = ss "eller" ** {n = Sg} ;
  otherwise_PConj = ss "annars" ;
  part_Prep = ss "av" ;
  please_Voc = ss "tack" ; ---
  possess_Prep = ss "av" ;
  quite_Adv = ss "ganska" ;
  she_Pron = mkNP "hon" "henne" "hennes" "hennes" "hennes"  SgUtr P3 ;
  so_AdA = ss "så" ;
  someSg_Det = {s = \\_ => genderForms "någon" "något" ; n = Sg ; det = DDef Indef} ;
  somePl_Det = {s = \\_,_ => "några" ; n = Pl ; det = DDef Indef} ;
  somebody_NP = regNP "någon" "någons" SgUtr ;
  something_NP = regNP "något" "någots" SgNeutr ;
  somewhere_Adv = ss "någonstans" ;
  that_Quant = 
    {s = \\_ => genderForms ["den där"] ["det där"] ; n = Sg ; det = DDef Def} ;
  that_NP = regNP ["det där"] ["det därs"] SgNeutr ;
  there_Adv = ss "där" ;
  there7to_Adv = ss "dit" ;
  there7from_Adv = ss "därifrån" ;
  therefore_PConj = ss "därför" ;
  these_NP = regNP ["de här"] ["det härs"] Plg ;
  these_Quant = {s = \\_,_ => ["de här"] ; n = Pl ; det = DDef Def} ;
  they_Pron = mkNP "de" "dem" "deras" "deras" "deras" Plg P1 ;
  this_Quant = 
    {s = \\_ => genderForms ["den här"] ["det här"] ; n = Sg ; det = DDef Def} ;
  this_NP = regNP ["det här"] ["det härs"] SgNeutr ;
  those_NP = regNP ["de där"] ["det därs"] Plg ;
  those_Quant = {s = \\_,_ => ["de där"] ; n = Pl ; det = DDef Def} ;
  thou_Pron = mkNP "du" "dig" "din" "ditt" "dina" SgUtr P2 ;
  through_Prep = ss "genom" ;
  too_AdA = ss "för" ;
  to_Prep = ss "till" ;
  under_Prep = ss "under" ;
  very_AdA = ss "mycket" ;
  want_VV = 
    mkVerb6 "vilja" "vill" "vilj" "ville" "velat" "velad" ** 
    {c2 = [] ; lock_VV = <>} ;
  we_Pron = mkNP "vi"  "oss"  "vår" "vårt" "våra"  Plg P1 ;
----  whatPl_IP = intPronWhat plural ;
----  whatSg_IP = intPronWhat singular ;
  when_IAdv = ss "när" ;
  when_Subj = ss "när" ;
  where_IAdv = ss "var" ;
----  whichPl_IDet = vilkenDet ;
----  whichSg_IDet = mkDeterminerPl "vilka" IndefP ;
  whoSg_IP = {s = vem.s ; gn = SgUtr} ;
  whoPl_IP = {s = vem.s ; gn = Plg} ;
  why_IAdv = ss "varför" ;
  without_Prep = ss "utan" ;
  with_Prep = ss "med" ;
  ye_Pron = mkNP "ni" "er" "er" "ert" "era"  Plg P2 ;
  yes_Phr = ss ["ja"] ;
  you_Pron = mkNP "ni" "er" "er" "ert" "era"  SgUtr P2 ; --- wrong in refl

-- Auxiliaries that are used repeatedly.

  oper
    vem = mkNP "vem" "vem" "vems" "vems" "vems" SgUtr P3 ;

}

