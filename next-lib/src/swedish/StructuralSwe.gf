concrete StructuralSwe of Structural = CatSwe ** 
  open MorphoSwe, ParadigmsSwe, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = ss "ovanför" ;
  after_Prep = ss "efter" ;
  by8agent_Prep = ss "av" ;
  all_Predet = {s = gennumForms "all" "allt" "alla"} ;
  almost_AdA, almost_AdN = ss "nästan" ;
  although_Subj = ss "fast" ;
  always_AdV = ss "alltid" ;
  and_Conj = {s1 = [] ; s2 = "och" ; n = Pl} ;
  because_Subj = ss "eftersom" ;
  before_Prep = ss "före" ;
  behind_Prep = ss "bakom" ;
  between_Prep = ss "mellan" ;
  both7and_DConj = sd2 "både" "och" ** {n = Pl} ;
  but_PConj = ss "men" ;
  by8means_Prep = ss "med" ;
  can8know_VV, can_VV = 
    mkV "kunna" "kan" "kunn" "kunde" "kunnat" "kunnen" **
    {c2 = mkComplement [] ; lock_VV = <>} ;
  during_Prep = ss "under" ;
  either7or_DConj = sd2 "antingen" "eller" ** {n = Sg} ;
  everybody_NP = regNP "alla" "allas" Plg ;
  every_Det = {s = \\_,_ => "varje" ; n = Sg ; det = DIndef} ;
  everything_NP = regNP "allting" "alltings" SgNeutr ;
  everywhere_Adv = ss "överallt" ;
  few_Det  = {s = \\_,_ => "få" ; n = Pl ; det = DDef Indef} ;
---  first_Ord = {s = "första" ; isDet = True} ;
  for_Prep = ss "för" ;
  from_Prep = ss "från" ;
  he_Pron = MorphoSwe.mkNP "han"  "honom"  "hans" "hans" "hans"  SgUtr P3 ;
  here_Adv = ss "här" ;
  here7to_Adv = ss "hit" ;
  here7from_Adv = ss "härifrån" ;
  how_IAdv = ss "hur" ;
  how8many_IDet = {s = \\_ => ["hur många"] ; n = Pl ; det = DDef Indef} ;
  if_Subj = ss "om" ;
  in8front_Prep = ss "framför" ;
  i_Pron = MorphoSwe.mkNP "jag"  "mig"  "min" "mitt" "mina"  SgUtr P1 ;
  in_Prep = ss "i" ;
  it_Pron = MorphoSwe.regNP "det" "dess" SgNeutr ;
  less_CAdv = ss "mindre" ;
  many_Det = {s = \\_,_ => "många" ; n = Pl ; det = DDef Indef} ;
  more_CAdv = ss "mer" ;
  most_Predet = {s = gennumForms ["den mesta"] ["det mesta"] ["de flesta"]} ;
  much_Det = {s = \\_,_ => "mycket" ; n = Pl ; det = DDef Indef} ;
  must_VV = 
    mkV "få" "måste" "få" "fick" "måst" "måst" ** 
    {c2 = mkComplement [] ; lock_VV = <>} ;
  no_Utt = ss ["nej"] ;
  on_Prep = ss "på" ;
---  one_Quant = {s = \\_,_ => genderForms ["en"] ["ett"] ; n = Sg ; det = DIndef} ;
  only_Predet = {s = \\_ => "bara"} ;
  or_Conj = {s1 = [] ; s2 = "eller" ; n = Sg} ;
  otherwise_PConj = ss "annars" ;
  part_Prep = ss "av" ;
  please_Voc = ss "tack" ; ---
  possess_Prep = ss "av" ;
  quite_Adv = ss "ganska" ;
  she_Pron = MorphoSwe.mkNP "hon" "henne" "hennes" "hennes" "hennes"  SgUtr P3 ;
  so_AdA = ss "så" ;
  someSg_Det = {s = \\_ => genderForms "någon" "något" ; n = Sg ; det = DIndef} ;
  somePl_Det = {s = \\_,_ => "några" ; n = Pl ; det = DIndef} ;
  somebody_NP = regNP "någon" "någons" SgUtr ;
  something_NP = regNP "något" "någots" SgNeutr ;
  somewhere_Adv = ss "någonstans" ;
  that_Quant = 
    {s = table {
       Sg => \\_,_ => genderForms ["den där"] ["det där"] ; 
       Pl => \\_,_,_ => ["de där"]
       } ;
     det = DDef Def
    } ;
  there_Adv = ss "där" ;
  there7to_Adv = ss "dit" ;
  there7from_Adv = ss "därifrån" ;
  therefore_PConj = ss "därför" ;
  they_Pron = MorphoSwe.mkNP "de" "dem" "deras" "deras" "deras" Plg P1 ;
  this_Quant = 
    {s = table {
       Sg => \\_,_ => genderForms ["den här"] ["det här"] ; 
       Pl => \\_,_,_ => ["de här"]
       } ;
     det = DDef Def
    } ;
  through_Prep = ss "genom" ;
  too_AdA = ss "för" ;
  to_Prep = ss "till" ;
  under_Prep = ss "under" ;
  very_AdA = ss "mycket" ;
  want_VV = 
    mkV "vilja" "vill" "vilj" "ville" "velat" "velad" ** 
    {c2 = mkComplement [] ; lock_VV = <>} ;
  we_Pron = MorphoSwe.mkNP "vi"  "oss"  "vår" "vårt" "våra"  Plg P1 ;
  whatSg_IP = {s = \\_ => "vad" ; gn = SgUtr} ; ---- infl
  whatPl_IP = {s = \\_ => "vad" ; gn = Plg} ; ---- infl
  when_IAdv = ss "när" ;
  when_Subj = ss "när" ;
  where_IAdv = ss "var" ;
  which_IQuant = {
    s = table {
      Sg => genderForms "vilken" "vilket" ;
      Pl => \\_ => "vilka" 
      } ; 
    det = DIndef
    } ;
  whoSg_IP = {s = vem.s ; gn = SgUtr} ;
  whoPl_IP = {s = \\_ => "vilka" ; gn = Plg} ;
  why_IAdv = ss "varför" ;
  without_Prep = ss "utan" ;
  with_Prep = ss "med" ;
  yes_Utt = ss ["ja"] ;
  youSg_Pron = MorphoSwe.mkNP "du" "dig" "din" "ditt" "dina" SgUtr P2 ;
  youPl_Pron = MorphoSwe.mkNP "ni" "er" "er" "ert" "era"  Plg P2 ;
  youPol_Pron = MorphoSwe.mkNP "ni" "er" "er" "ert" "era"  SgUtr P2 ; --- wrong in refl

-- Auxiliaries that are used repeatedly.

  oper
    vem = MorphoSwe.mkNP "vem" "vem" "vems" "vems" "vems" SgUtr P3 ;

lin
  not_Predet = {s = \\_ => "inte"} ;
  nothing_but_Predet = {s = \\_ => "inget förutom"} ;
  nobody_but_Predet = {s = \\_ => "ingen förutom"} ;
  no_Quant = 
    {s = table {
       Sg => \\_,_ => genderForms "ingen" "inget" ; 
       Pl => \\_,_,_ => "inga"
       } ;
     det = DIndef
    } ;

  if_then_Conj = {s1 = "om" ; s2 = "så" ; n = singular} ;
  nobody_NP = regNP "ingen" "ingens" SgUtr ;
  nothing_NP = regNP "inget" "ingets" SgNeutr ;

  at_least_AdN = ss "minst" ;
  at_most_AdN = ss "högst" ;
}

