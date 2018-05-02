--# -path=.:../abstract:../common:../../prelude

concrete StructuralRus of Structural = CatRus ** 
  open ResRus, MorphoRus, (P = ParadigmsRus), Prelude, NounRus in {

  flags optimize=all ; coding=utf8 ;

lin
-- First mount the numerals.
--  UseNumeral i = i ;   

-- Then an alphabetical list of structural words

  above_Prep = { s = "над" ; c = Inst} ;
  after_Prep  = { s = "после" ; c = Gen };
--  all8mass_Det = vesDet ** {n = Sg; g = PNoGen;  c = Nom} ; 
  all_Predet  = vseDetPl ** { g = PNoGen; c = Nom; size = nom} ; 
  almost_AdA = {s= "почти"} ;
  almost_AdN = {s= "почти"} ;
  although_Subj  = ss "хотя" ;
  always_AdV = ss "всегда" ;
  and_Conj  = {s1 = [] ; s2 = "и" ; n = Pl} ;
  because_Subj  = ss ["потому что"] ;
  before_Prep   ={ s = "перед" ; c = Inst};
  behind_Prep  = { s = "за" ; c = Inst };
  between_Prep  = { s = "между" ; c = Inst};
  both7and_DConj = sd2 "как" [", так и"]  ** {n = Pl} ;
  but_PConj = ss "но" ;
  by8agent_Prep  = { s = ["с помощью"] ; c = Gen};
  by8means_Prep  = { s = ["с помощью"] ; c = Gen};
  can8know_VV  = verbMoch ;
  can_VV  =  verbMoch ;
  during_Prep  = { s = ["в течение"] ; c = Gen};
  either7or_DConj  = sd2 "либо" [", либо"]  ** {n = Sg} ;
-- comma is not visible in GUI!
  every_Det = {
    s = \\c,a,g => kazhdujDet.s ! AF c a (gennum g Sg) ;
    n = Sg ; g = PNoGen ; c = Nom ; size = nom} ;
  everybody_NP = DetCN (DetQuant IndefArt NumPl) (UseN ((eEnd_Decl "вс")**{lock_N=<>})) ;
  everything_NP  = UsePron (pronVseInanimate ** {lock_Pron=<>}) ;
  everywhere_Adv = ss "везде" ;
  few_Det = {
    s = \\c,a,g => nemnogoSgDet.s ! AF c a (gennum g Sg) ;
    n = Sg ; g = PNoGen ; c = Nom ; size = plg} ;
--- DEPREC  first_Ord = (uy_j_EndDecl  "перв" ) ** {lock_A = <>};  --AStaruyj 
  for_Prep = { s = "для" ; c = Gen };
  from_Prep  = { s = "от" ; c = Gen };
  he_Pron  = pronOn ;
  here_Adv = ss "здесь" ;
  here7to_Adv = ss "сюда" ;
  here7from_Adv = ss "отсюда" ;
  how_IAdv  = ss "как" ;
  how8many_IDet   = skolkoSgDet ** {n = Pl; g = (PGen Neut); c= Gen}; 
  how8much_IAdv   = ss "сколько" ;
  i_Pron   = pronYa Masc ;
  if_Subj    = ss "если" ;
  in8front_Prep  = { s = "перед" ; c = Inst};
  in_Prep = { s = "в" ; c = Prepos PrepVNa } ;
  it_Pron    = pronOno ;
  less_CAdv = {s="менее"; p=""} ;
  many_Det  = {
    s = \\c,a,g => mnogoSgDet.s ! AF c a (gennum g Sg) ;
    n = Sg; g = (PGen Neut); c = Gen; size = plg} ; 
  more_CAdv = {s="более"; p=""} ;
  most_Predet   = bolshinstvoSgDet ** {n = Sg; g = (PGen Neut); c= Gen; size = plg} ; 
  -- inanimate, Sg: "большинство телефонов безмолвству-ет" 
--  most8many_Det = bolshinstvoPlDet ** {n = Pl; g = (PGen Neut); c= Gen} ;  
  -- animate, Pl: "большинство учащихся хорошо подготовлен-ы"
 much_Det = {
    s = \\c,a,g => mnogoSgDet.s ! AF c a (gennum g Sg) ;
    n = Sg ; g = (PGen Neut) ; c= Gen ; size = plg} ; -- same as previous
 must_VV  = verbDolzhen ;
 no_Utt  = ss ["Нет"] ;
 on_Prep = { s = "на" ; c = Prepos PrepVNa };
--- DEPREC one_Quant = odinDet  ** {lock_QuantSg = <>; n= Sg; g = PNoGen; c = Nom };
--AStaruyj :
 only_Predet = (uy_j_EndDecl  "единственн" ) ** {lock_Predet = <>; n= Sg; g = PNoGen; c = Nom; size = nom };
 or_Conj  = {s1= [] ; s2 = "или" ; n = Sg} ;
 otherwise_PConj  = ss "иначе" ;
  part_Prep = { s = "" ; c = Nom}; -- missing in Russian
  please_Voc = ss "пожалуйста" ;
  possess_Prep  = { s = "" ; c = Gen}; --- ?? AR 19/2/2004
  quite_Adv = ss "довольно" ;
  she_Pron   = pronOna ;
  so_AdA = ss "так";
  somebody_NP = UsePron (pronKtoTo** {lock_Pron = <>});
  someSg_Det   = {
    s = \\c,a,g => nekotorujDet.s ! AF c a (gennum g Sg) ;
    n = Sg ; g = PNoGen ; c= Nom ; size = nom} ;
  somePl_Det = {
    s = \\c,a,g => nekotorujDet.s ! AF c a (gennum g Pl) ;
    n = Pl ; g = PNoGen ; c= Nom ; size = nom} ;  
  something_NP  = UsePron (pronChtoTo** {lock_Pron=<> }) ;
  somewhere_Adv  = ss "где-нибудь" ;
  that_Quant   = totDet ** {n = Sg; g = PNoGen; c= Nom; size = nom} ;
  there_Adv = ss "там" ;
  there7to_Adv = ss "туда" ;
  there7from_Adv = ss "оттуда" ;
  therefore_PConj  = ss "следовательно" ;
  they_Pron  = pronOni;
  this_Quant   = etotDet ** {n = Sg; g = PNoGen; c= Nom; size = nom} ;
  through_Prep  = { s = "через" ; c = Acc };
  to_Prep = { s = "к" ; c = Dat };
  too_AdA = ss "слишком" ;
  under_Prep  = { s = "под"  ; c = Inst };
  very_AdA  = ss "очень" ;
  want_VV  = verbKhotet ;
  we_Pron  = pronMu Masc;
  whatPl_IP = pron2NounPhraseNum pronChto Inanimate Pl;
  whatSg_IP = pron2NounPhraseNum pronChto Inanimate Sg;
  when_IAdv = ss "когда" ;
  when_Subj  = ss "когда" ;
  where_IAdv  = ss "где" ;
  which_IQuant = {
    s = \\_ => kotorujDet.s ; 
    g = PNoGen; 
    c= Nom
    } ;  
  whoPl_IP = pron2NounPhraseNum pronKto Animate Pl;
  whoSg_IP = pron2NounPhraseNum pronKto Animate Sg;
  why_IAdv  = ss "почему" ;
  with_Prep  = {s = pre {#sconsonant => "со" ; ("щ"|"Щ") => "со" ; _ => "с"} ; c = Inst} ;
  without_Prep  = { s = "без" ; c = Gen};
  youPl_Pron  = pronVu Masc;
  yes_Utt  = ss ["Да"] ;
  youSg_Pron   = pronTu Masc;
  youPol_Pron =  pronVu Masc;

  have_V2= P.dirV2 (P.regV P.imperfective P.first "име" "ю" "имел" "имей" "иметь" );
  have_V3 = P.mkV3 (P.mkV P.imperfective "есть" "есть" "есть" "есть" "есть" "есть" "был" "будь" "есть") "" "у" Nom Gen;

  have_not_V3 = P.mkV3 (P.mkV P.imperfective "нет" "нет" "нет" "нет" "нет" "нет" "не было" "не будь" "нет") "" "у" Gen Gen;

---  NoDet    = nikakojDet ** {n = Sg; g = PNoGen; c= Nom} ;
---  AnyDet   = lubojDet ** {n = Sg; g = PNoGen; c= Nom} ;
---  AnyNumDet  = mkDeterminerNum (lubojDet ** {n = Pl; g = PNoGen; c= Nom} );  
---  NoNumDet   = mkDeterminerNum (nikakojDet ** {n = Pl; g = PNoGen; c= Nom} );  
---NobodyNP = UsePron pronNikto Animate;
---NothingNP = UsePron pronNichto Inanimate;

-- In case of "neither..  no" expression double negation is not 
-- only possible, but also required in Russian.
-- There is no means of control for this however in the resource grammar.
---  NeitherNor = sd2 "ни" [", ни"]  ** {n = Sg} ;
---  NowhereNP = ss "нигде" ;
---  AgentPrep = { s = "" ; c = Nom}; -- missing in Russian

  lin language_title_Utt = ss "Русский" ;
  
oper
  sconsonant : pattern Str = #(("с"|"з"|"ж"|"ш"|"л"|"ль"|"р"|"м"|"в"|"С"|"З"|"Ж"|"Ш"|"Л"|"Ль"|"Р"|"М"|"В"|"ЛЬ") + 
               ("б" | "в" | "г" | "д" | "ж" | "з" | "й" | "к" | "л" | "м" | "н" | "п" | "р" | "с" | "т" | "ф" | "х" | "ц" | "ч" | "ш" | "щ" |
                "Б" | "В" | "Г" | "Д" | "Ж" | "З" | "Й" | "К" | "Л" | "М" | "Н" | "П" | "Р" | "С" | "Т" | "Ф" | "Х" | "Ц" | "Ч" | "Ш" | "Щ")) ;
}
