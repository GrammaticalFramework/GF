concrete StructuralNno of Structural = CatNno **
  open MorphoNno, ParadigmsNno, (X = ConstructX), IrregNno, Prelude in {

  flags optimize=all ;
    coding=utf8 ;

  lin
  above_Prep = ss "ovanfor" ;
  after_Prep = ss "etter" ;
  by8agent_Prep = ss "av" ;
  all_Predet = {s = detForms "all" "alt" "alle" ; p = [] ; a = PNoAg} ;
  almost_AdA, almost_AdN = ss "nesten" ;
  although_Subj = ss ["sjølv om"] ;
  always_AdV = ss "alltid" ;
  and_Conj = {s1 = [] ; s2 = "og" ; n = Pl ; isDiscont = False} ;
  because_Subj = ss "fordi" ;
  before_Prep = ss "før" ;
  behind_Prep = ss "bakom" ;
  between_Prep = ss "mellom" ;
  both7and_DConj = sd2 "både" "og" ** {n = Pl ; isDiscont = True} ;
  but_PConj = ss "men" ;
  by8means_Prep = ss "med" ;
  can8know_VV, can_VV =
    mkV "kunne" "kan" "kunn" "kunne" "kunna" "kunn" **
    {c2 = mkComplement [] ; lock_VV = <>} ;
  during_Prep = ss "under" ;
  either7or_DConj = sd2 "anten" "eller" ** {n = Sg ; isDiscont = True} ;
  everybody_NP = regNP "alle" "alles" Utr Pl ;
  every_Det = {s = \\_,_ => "kvar" ; sp = \\_,_ =>"einkvar" ; n = Sg ; det = DDef Indef} ;
  everything_NP = regNP "alt" "alts" Neutr Sg ;
  everywhere_Adv = ss "overalt" ;
  few_Det  = {s,sp = \\_,_ => "få" ; n = Pl ; det = DDef Indef} ;
---  first_Ord = {s = "første" ; isDet = True} ; DEPREC
  for_Prep = ss "for" ;
  from_Prep = ss "frå" ;
  he_Pron = MorphoNno.mkNP "han"  "han"  "hans" "hans" "hans"  Utr Sg P3 ;
  here_Adv = ss "her" ;
  here7to_Adv = ss "hit" ;
  here7from_Adv = ss "herifrå" ;
  how_IAdv = ss "korleis" ;
  how8many_IDet = {s = \\_ => ["kor mange"] ; n = Pl ; det = DDef Indef} ;
  if_Subj = ss "viss" ;
  in8front_Prep = ss "framfor" ;
  i_Pron =
    MorphoNno.mkNP "eg" "meg" "min" "mitt" "mine"  Utr Sg P1 ; --- mi
---    MorphoNno.mkNP "eg" "meg" (variants {"min" ; "mi"}) "mitt" "mine"  Utr Sg P1 ;
  in_Prep = ss "i" ;
  it_Pron = MorphoNno.regNP "det" "dets" Neutr Sg ;
  less_CAdv = X.mkCAdv "mindre" conjThan ;
  many_Det = {s,sp = \\_,_ => "mange" ; n = Pl ; det = DDef Indef} ;
  more_CAdv = X.mkCAdv "meir" conjThan ;
  most_Predet = {s = detForms ["den mest"] ["det meste"] ["dei fleste"] ; p = [] ; a = PNoAg} ;
  much_Det = {s,sp = \\_,_ => "mykje" ; n = Pl ; det = DDef Indef} ;
  must_VV =
    mkV "måtte" "må" "må" "måtte" "måtte" "mått" **
    {c2 = mkComplement [] ; lock_VV = <>} ;
  no_Utt = ss ["nei"] ;
  on_Prep = ss "på" ;

  only_Predet = {s = \\_,_ => "kun" ; p = [] ; a = PNoAg} ;
  or_Conj = {s1 = [] ; s2 = "eller" ; n = Pl ; isDiscont = False} ;
  otherwise_PConj = ss "elles" ;
  part_Prep = ss "av" ;
  please_Voc = ss "takk" ; ---
  possess_Prep = ss "av" ;
  quite_Adv = ss "temmeleg" ;
  she_Pron = MorphoNno.mkNP "ho" "henne" "hennar" "hennar" "hennar"  Utr Sg P3 ;
  so_AdA = ss "så" ;
  someSg_Det = {s,sp = \\_ => genderForms "nokon" "noko" ; n = Sg ; det = DIndef} ;
  somePl_Det = {s,sp = \\_,_ => "nokre" ; n = Pl ; det = DIndef} ;
  somebody_NP = regNP "nokon" "nokons" Utr Sg ;
  something_NP = regNP "noko" "nokos" Neutr Sg ;
  somewhere_Adv = ss ["ein eller anna plass"] ; ---- ?
  that_Quant =
    {s,sp = table {
       Sg => \\_,_ => genderForms ["den der"] ["det der"] ;
       Pl => \\_,_,_ => ["de der"]
       } ;
     det = DDef Def
    } ;
  there_Adv = ss "der" ;
  there7to_Adv = ss "dit" ;
  there7from_Adv = ss "derifrå" ;
  therefore_PConj = ss "derfor" ;
  they_Pron = MorphoNno.mkNP "dei" "dei" "deira" "deira" "deira" Utr Pl P1 ;
  this_Quant =
    {s,sp = table {
       Sg => \\_,_ => genderForms ["denne"] ["dette"] ;
       Pl => \\_,_,_ => ["desse"]
       } ;
     det = DDef Def
    } ;
  through_Prep = ss "gjennom" ;
  too_AdA = ss "for" ;
  to_Prep = ss "til" ;
  under_Prep = ss "under" ;
  very_AdA = ss "mykje" ;
  want_VV =
    mkV "vilje" "vil" "vil" "ville" "ville" "ville" **
    {c2 = mkComplement [] ; lock_VV = <>} ;
  we_Pron = MorphoNno.mkNP "vi"  "oss"  "vår" "vårt" "våre"  Utr Pl P1 ;
  whatSg_IP = {s = \\_ => "kva" ; g = Neutr ; n = Sg} ; ---- infl
  whatPl_IP = {s = \\_ => "kva" ; g = Neutr ; n = Pl} ; ---- infl
  when_IAdv = ss "når" ;
  when_Subj = ss "når" ;
  where_IAdv = ss "kvar" ;
  which_IQuant = {
    s = table {
      Sg => genderForms "kva" "kva" ;
      Pl => \\_ => "kva"
      } ;
    det = DIndef
    } ;
  whoSg_IP = {s = vem.s ; g = Utr ; n = Sg} ;
  whoPl_IP = {s = \\_ => "kven" ; g = Utr ; n = Pl} ;
  why_IAdv = ss "kvifor" ;
  without_Prep = ss "utan" ;
  with_Prep = ss "med" ;
  yes_Utt = ss ["ja"] ;
  youSg_Pron =
    MorphoNno.mkNP "du" "deg" "din" "ditt" "dine" Utr Sg P2 ; ----
---    MorphoNno.mkNP "du" "deg" (variants {"din" ; "di"}) "ditt" "dine" Utr Sg P2 ; ----
  youPl_Pron = MorphoNno.mkNP "de" "dykk" "dykkar" "dykkar" "dykkar"  Utr Pl P2 ;
  youPol_Pron = MorphoNno.mkNP "De" "Dykk" "Dykkar" "Dykkar" "Dykkar"  Utr Sg P2 ; --- wrong in refl
  have_V2 = dirV2 IrregNno.ha_V ;

-- Auxiliaries that are used repeatedly.

  oper
    vem = MorphoNno.mkNP "kven" "kven" "kvens" "kvens" "kvens" Utr Sg P3 ;

  lin language_title_Utt = ss "nynorsk" ;

}
