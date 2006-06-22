--# -path=.:../abstract:../common:../../prelude

concrete StructuralRus of Structural = CatRus ** 
  open ResRus, MorphoRus, (P = ParadigmsRus), Prelude, NounRus, in {

  flags optimize=all ; coding=utf8 ;

lin
-- First mount the numerals.
--  UseNumeral i = i ;   

-- Then an alphabetical list of structural words

  above_Prep = { s = "над" ; c = Inst} ;
  after_Prep  = { s = "после" ; c = Gen };
--  all8mass_Det = vesDet ** {n = Sg; g = PNoGen;  c = Nom} ; 
  all_Predet  = vseDetPl ** { g = PNoGen; c = Nom} ; 
  almost_AdA = {s= "почти"} ;
  almost_AdN = {s= "почти"} ;
  although_Subj  = ss "хотя" ;
  always_AdV = ss "всегда" ;
  and_Conj  = ss "и"  ** {n = Pl} ;
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
  every_Det  = kazhdujDet ** {n = Sg ; g = PNoGen; c= Nom} ; 
  everybody_NP = mkNP Pl (UseN ((eEnd_Decl "вс")**{lock_N=<>})) ;
  everything_NP  = UsePron (pronVseInanimate ** {lock_Pron=<>}) ;
  everywhere_Adv = ss "везде" ;
  few_Det = (ij_EndK_G_KH_Decl "немног") **{lock_Det= <>; n= Sg; g = PNoGen; c = Nom}; -- AMalenkij  
  first_Ord = (uy_j_EndDecl  "перв" ) ** {lock_A = <>};  --AStaruyj 
  from_Prep  = { s = "от" ; c = Gen };
  he_Pron  = pronOn ;
  here_Adv = ss "здесь" ;
  here7to_Adv = ss "сюда" ;
  here7from_Adv = ss "отсюда" ;
  how_IAdv  = ss "как" ;
  how8many_IDet   = skolkoSgDet ** {n = Pl; g = (PGen Neut); c= Gen}; 
  i_Pron   = pronYa ;
  if_Subj    = ss "если" ;
  in8front_Prep  = { s = "перед" ; c = Inst};
  in_Prep  = { s = "в" ; c = Prepos };
  it_Pron    = pronOno ;
  less_CAdv = ss "менее" ;
  many_Det  = mnogoSgDet ** {n = Sg; g = (PGen Neut); c= Gen} ; 
  more_CAdv = ss "более" ;
  most_Predet   = bolshinstvoSgDet ** {n = Sg; g = (PGen Neut); c= Gen} ; 
  -- inanimate, Sg: "большинство телефонов безмолству-ет" 
--  most8many_Det = bolshinstvoPlDet ** {n = Pl; g = (PGen Neut); c= Gen} ;  
  -- animate, Pl: "большинство учащихся хорошо подготовлен-ы"
 much_Det   = mnogoSgDet ** {n = Sg; g = (PGen Neut); c= Gen} ; -- same as previous
 must_VV  = verbDolzhen ;
 no_Phr  = ss ["Нет ."] ;
 on_Prep = { s = "на" ; c = Prepos };
 one_Quant = odinDet  ** {lock_QuantSg = <>; n= Sg; g = PNoGen; c = Nom };
--AStaruyj :
 only_Predet = (uy_j_EndDecl  "единственн" ) ** {lock_Predet = <>; n= Sg; g = PNoGen; c = Nom };
 or_Conj  = ss "или"  ** {n = Sg} ;
 otherwise_PConj  = ss "иначе" ;
  part_Prep = { s = "" ; c = Nom}; -- missing in Russian
  please_Voc = ss "пожалуйста" ;
  possess_Prep  = { s = "" ; c = Gen}; --- ?? AR 19/2/2004
  quite_Adv = ss "довольно" ;
  she_Pron   = pronOna ;
  so_AdA = ss "так";
  somebody_NP = UsePron (pronKtoTo** {lock_Pron = <>});
  someSg_Det   = nekotorujDet ** {n = Sg; g = PNoGen; c= Nom} ;
  somePl_Det = nekotorujDet ** {n = Pl; g = PNoGen; c= Nom} ;  
  something_NP  = UsePron (pronChtoTo** {lock_Pron=<> }) ;
  somewhere_Adv  = ss "где-нибудь" ;
  these_NP =  UsePron (pronEti** {lock_Pron = <>}); -- missing in Russian
  those_NP =  UsePron (pronTe** {lock_Pron = <>}); -- missing in Russian
  that_Quant   = totDet ** {n = Sg; g = PNoGen; c= Nom} ;
  that_NP  = det2NounPhrase totDet ; -- inanimate form only
  there_Adv = ss "там" ;
  there7to_Adv = ss "туда" ;
  there7from_Adv = ss "оттуда" ;
  therefore_PConj  = ss "следовательно" ;
--  these_NDet  = etotDet ** { g = PNoGen; c= Nom} ;  
--  they8fem_NP = UsePron pronOni Animate;
  they_Pron  = pronOni;
  this_Quant   = etotDet ** {n = Sg; g = PNoGen; c= Nom} ;
  this_NP  = det2NounPhrase etotDet ; -- inanimate form only
--  those_NDet  = totDet ** {g = PNoGen; c= Nom} ;    
--  thou_NP = UsePron pronTu Animate;
  through_Prep  = { s = "через" ; c = Acc };
  to_Prep = { s = "к" ; c = Dat };
  too_AdA = ss "слишком" ;
  under_Prep  = { s = "под"  ; c = Inst };
  very_AdA  = ss "очень" ;
  want_VV  = verbKhotet ;
  we_Pron  = pronMu ;
  whatPl_IP = pron2NounPhraseNum pronChto Inanimate Pl;
  whatSg_IP = pron2NounPhraseNum pronChto Inanimate Sg;
  when_IAdv = ss "когда" ;
  when_Subj  = ss "когда" ;
  where_IAdv  = ss "где" ;
  whichPl_IDet = kotorujDet ** {n = Pl; g = PNoGen; c= Nom} ;  
  whichSg_IDet = kotorujDet ** {n = Sg; g = PNoGen; c= Nom} ;
  whoPl_IP = pron2NounPhraseNum pronKto Animate Pl;
  whoSg_IP = pron2NounPhraseNum pronKto Animate Sg;
  why_IAdv  = ss "почему" ;
  with_Prep  = { s = "с" ; c = Inst};
  without_Prep  = { s = "без" ; c = Gen};
  youPl_Pron  = pronVu;
  yes_Phr  = ss ["Да ."] ;
  youSg_Pron   = pronVu;
  youPol_Pron =  pronVu;

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
}

