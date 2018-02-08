concrete StructuralDan of Structural = CatDan ** 
  open MorphoDan, ParadigmsDan, (X = ConstructX), (M=MakeStructuralDan),  IrregDan, Prelude in {

  flags optimize=all ;
    coding=utf8 ;

  lin
  above_Prep = ss "ovenfor" ;
  after_Prep = ss "efter" ;
  by8agent_Prep = ss "af" ;
  all_Predet = {s = detForms "all" "alt" "alle" ; p = [] ; a = PNoAg} ;
  almost_AdA, almost_AdN = ss "næsten" ;
  although_Subj = ss ["selv om"] ;
  always_AdV = ss "altid" ;
  and_Conj = {s1 = [] ; s2 = "og" ; n = Pl ; isDiscont = False} ;
  because_Subj = ss "fordi" ;
  before_Prep = ss "før" ;
  behind_Prep = ss "bag" ;
  between_Prep = ss "mellem" ;
  both7and_DConj = sd2 "både" "og" ** {n = Pl ; isDiscont = True} ;
  but_PConj = ss "men" ;
  by8means_Prep = ss "med" ;
  can8know_VV, can_VV = 
    mkV "kunne" "kan" "kan" "kunne" "kunnet" "kan" **
    {c2 = mkComplement [] ; lock_VV = <>} ;
  during_Prep = ss "under" ;
  either7or_DConj = sd2 "enten" "eller" ** {n = Sg ; isDiscont = True} ;
  everybody_NP = regNP "alle" "alles" Utr Pl ;
  every_Det = {s = \\_,_ => "hver" ; sp = \\_,_ => "enhver" ; n = Sg ; det = DDef Indef} ;
  everything_NP = regNP "alt" "alts" Neutr Sg ;
  everywhere_Adv = ss "overalt" ;
  few_Det  = {s,sp = \\_,_ => "få" ; n = Pl ; det = DDef Indef} ;
---  first_Ord = {s = "første" ; isDet = True} ;
  for_Prep = ss "for" ;
  from_Prep = ss "fra" ;
  he_Pron = MorphoDan.mkNP "han"  "ham"  "hans" "hans" "hans"  Utr Sg P3 ;
  here_Adv = ss "her" ;
  here7to_Adv = ss "hit" ;
  here7from_Adv = ss "herfra" ;
  how_IAdv = ss "hvor" ;
  how8many_IDet = {s = \\_ => ["hvor mange"] ; n = Pl ; det = DDef Indef} ;
  if_Subj = ss "hvis" ;
  in8front_Prep = ss "foran" ;
  i_Pron = 
    MorphoDan.mkNP "jeg" "mig" "min" "mit" "mine"  Utr Sg P1 ;
  in_Prep = ss "i" ;
  it_Pron = MorphoDan.regNP "det" "dets" Neutr Sg ;
  less_CAdv = X.mkCAdv "mindre" conjThan ;
  many_Det = {s,sp = \\_,_ => "mange" ; n = Pl ; det = DDef Indef} ;
  more_CAdv = X.mkCAdv "mer" conjThan ;
  most_Predet = {s = detForms ["den meste"] ["det meste"] ["de fleste"] ; p = [] ; a = PNoAg} ;
  much_Det = {s,sp = \\_,_ => "meget" ; n = Pl ; det = DDef Indef} ;
  must_VV = 
    mkV "måtte" "må" "må" "måtte" "måttet" "mått" ** 
    {c2 = mkComplement [] ; lock_VV = <>} ;
  no_Utt = ss ["nej"] ;
  on_Prep = ss "på" ;
  only_Predet = {s = \\_,_ => "kun" ; p = [] ; a = PNoAg} ;
  or_Conj = {s1 = [] ; s2 = "eller" ; n = Pl ; isDiscont = False} ;
  otherwise_PConj = ss "anderledes" ;
  part_Prep = ss "af" ;
  please_Voc = ss "tak" ; ---
  possess_Prep = ss "af" ;
  quite_Adv = ss "temmelig" ;
  she_Pron = MorphoDan.mkNP "hun" "hende" "hendes" "hendes" "hendes"  Utr Sg P3 ;
  so_AdA = ss "så" ;
  someSg_Det = {s,sp = \\_ => genderForms "nogen" "noget" ; n = Sg ; det = DIndef} ;
  somePl_Det = {s,sp = \\_,_ => "nogle" ; n = Pl ; det = DIndef} ;
  somebody_NP = regNP "nogen" "nogens" Utr Sg ;
  something_NP = regNP "noget" "nogets" Neutr Sg ;
  somewhere_Adv = ss ["et eller annet sted"] ; ---- ?
  that_Quant = 
    {s,sp = table {
       Sg => \\_,_ => genderForms ["den der"] ["det der"] ; 
       Pl => \\_,_,_ => ["de der"]
       } ;
     det = DDef Indef
    } ;
  there_Adv = ss "der" ;
  there7to_Adv = ss "dit" ;
  there7from_Adv = ss "derfra" ;
  therefore_PConj = ss "derfor" ;
  they_Pron = MorphoDan.mkNP "de" "dem" "deres" "deres" "deres" Utr Pl P1 ;
  this_Quant = 
    {s,sp = table {
       Sg => \\_,_ => genderForms ["denne"] ["dette"] ; 
       Pl => \\_,_,_ => ["disse"]
       } ;
     det = DDef Indef
    } ;
  through_Prep = ss "gennem" ;
  too_AdA = ss "for" ;
  to_Prep = ss "til" ;
  under_Prep = ss "under" ;
  very_AdA = ss "meget" ;
  want_VV = 
    mkV "ville" "vil" "vil" "ville" "villet" "villed" ** 
    {c2 = mkComplement [] ; lock_VV = <>} ;
  we_Pron = MorphoDan.mkNP "vi"  "os"  "vores" "vores" "vores"  Utr Pl P1 ;
  whatSg_IP = {s = \\_ => "hvad" ; g = Utr ; n = Sg} ; ---- infl
  whatPl_IP = {s = \\_ => "hvilke" ; g = Utr ; n = Pl} ; ---- infl
  when_IAdv = ss "hvornår" ;
  when_Subj = ss "når" ;
  where_IAdv = ss "hvor" ;
  which_IQuant = {
    s = table {
      Sg => genderForms "hvilken" "hvilket" ;
      Pl => \\_ => "hvilke" 
      } ; 
    det = DIndef
    } ;
  whoSg_IP = {s = vem.s ; g = Utr ; n = Sg} ;
  whoPl_IP = {s = \\_ => "hvilke" ; g = Utr ; n = Pl} ;
  why_IAdv = ss "hvorfor" ;
  without_Prep = ss "uden" ;
  with_Prep = ss "med" ;
  yes_Utt = ss ["ja"] ;
  youSg_Pron = 
    MorphoDan.mkNP "du" "dig" "din" "dit" "dine" Utr Sg P2 ; ----
  youPl_Pron = MorphoDan.mkNP "I" "jer" "jeres" "jeres" "jeres"  Utr Pl P2 ;
  youPol_Pron = MorphoDan.mkNP "De" "Dem" "Deres" "Deres" "Deres"  Utr Sg P2 ; --- wrong in refl
  have_V2 = dirV2 have_V ;

 not_Predet = {s = \\_,_ => "ikke" ; p = [] ; a = PNoAg} ;
 
no_Quant = 
    {s,sp = table {
       Sg => \\_,_ => genderForms "ingen" "intet" ; 
       Pl => \\_,_,_ => "ingen"
       } ;
     det = DIndef
    } ;

 if_then_Conj = {s1 = "hvis" ; s2 = "så" ; n = singular ; isDiscont = False} ; ----
  nobody_NP = regNP "ingen" "ingens" Utr Sg ;
  nothing_NP = regNP "intet" "intets" Neutr Sg ;

  at_least_AdN = ss "mindst" ;
  at_most_AdN = ss "højst" ;

  except_Prep = ss "uden" ;
  as_CAdv = X.mkCAdv "lige" "som" ;
  
-- Auxiliaries that are used repeatedly.

  oper
    vem = MorphoDan.mkNP "hvem" "hvem" "hvis" "hvis" "hvis" Utr Sg P3 ;

  lin language_title_Utt = ss "dansk" ;

}

