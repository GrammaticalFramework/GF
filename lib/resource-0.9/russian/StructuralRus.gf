--# -path=.:../abstract:../../prelude
--1 The Top-Level Russian Resource Grammar
--
-- Janna Khegai 2003
-- on the basis of code for other languages by Aarne Ranta
--
-- This is the Russian concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.RusU.gf$.
-- However, for the purpose of documentation, we make here explicit the
-- linearization types of each category, so that their structures and
-- dependencies can be seen.
-- Another substantial part is the linearization rules of some
-- structural words.
--
-- The users of the resource grammar should not look at this file for the
-- linearization rules, which are in fact hidden in the document version.
-- They should use $resource.Abs.gf$ to access the syntactic rules.
-- This file can be consulted in those, hopefully rare, occasions in which
-- one has to know how the syntactic categories are
-- implemented. The parameter types are defined in $types.RusU.gf$.

concrete StructuralRus of Structural = CategoriesRus, NumeralsRus ** open Prelude, SyntaxRus in {
flags 
 coding=utf8 ;

lin

-- First mount the numerals.

  UseNumeral i = i ;   


-- Then an alphabetical list of structural words

  above_Prep = { s2 = "над" ; c = Inst} ;
  after_Prep  = { s2 = "после" ; c = Gen };
  all8mass_Det = vesDet ** {n = Sg; g = PNoGen;  c = Nom} ; 
  all_NDet  = vseDetPl ** { g = PNoGen; c = Nom} ; 
  almost_Adv = ss "почти" ;
  although_Subj  = ss "хотя" ;
  and_Conj  = ss "и"  ** {n = Pl} ;
  because_Subj  = ss ["потому что"] ;
  before_Prep   ={ s2 = "перед" ; c = Inst};
  behind_Prep  = { s2 = "за" ; c = Inst };
  between_Prep  = { s2 = "между" ; c = Inst};
  both_AndConjD = sd2 "как" [", так и"]  ** {n = Pl} ;
  by8agent_Prep  = { s2 = ["с помощью"] ; c = Gen};
  by8means_Prep  = { s2 = ["с помощью"] ; c = Gen};
  can8know_VV  = verbMoch ;
  can_VV  =  verbMoch ;
  during_Prep  = { s2 = ["в течение"] ; c = Gen};
  either8or_ConjD  = sd2 "либо" [", либо"]  ** {n = Sg} ;
-- comma is not visible in GUI!
  every_Det  = kazhdujDet ** {n = Sg ; g = PNoGen; c= Nom} ; 
  everybody_NP = mkNounPhrase Pl (noun2CommNounPhrase (eEnd_Decl "вс")) ;
  everything_NP  = pron2NounPhrase pronVseInanimate Inanimate;
  everywhere_Adv = ss "везде" ;
  from_Prep  = { s2 = "от" ; c = Gen };
  he_NP  = pron2NounPhrase pronOn Animate;
  how_IAdv  = ss "как" ;
  how8many_IDet   = skolkoSgDet ** {n = Sg; g = (PGen Neut); c= Gen}; 
  i_NP   = pron2NounPhrase pronYa Animate;
  if_Subj    = ss "если" ;
  in8front_Prep  = { s2 = "перед" ; c = Inst};
  in_Prep  = { s2 = "в" ; c = Prepos };
  it_NP    = pron2NounPhrase pronOno Inanimate;
  many_Det  = mnogoSgDet ** {n = Sg; g = (PGen Neut); c= Gen} ; 

  most_Det   = bolshinstvoSgDet ** {n = Sg; g = (PGen Neut); c= Gen} ; 
  -- inanimate, Sg: "большинство телефонов безмолству-ет" 
  most8many_Det = bolshinstvoPlDet ** {n = Pl; g = (PGen Neut); c= Gen} ;  
  -- animate, Pl: "большинство учащихся хорошо подготовлен-ы"
 much_Det   = mnogoSgDet ** {n = Sg; g = (PGen Neut); c= Gen} ; -- same as previous
 must_VV  = verbDolzhen ;
 no_Phr  = ss ["Нет ."] ;
 on_Prep = { s2 = "на" ; c = Prepos };
 or_Conj  = ss "или"  ** {n = Sg} ;
 otherwise_Adv  = ss "иначе" ;
  part_Prep = { s2 = "" ; c = Nom}; -- missing in Russian
  possess_Prep  = { s2 = "" ; c = Gen}; --- ?? AR 19/2/2004
  quite_Adv = ss "довольно" ;
  she_NP   = pron2NounPhrase pronOna Animate;
  so_Adv = ss "так";
  somebody_NP = pron2NounPhrase pronKtoTo Animate;
 some_Det   = nekotorujDet ** {n = Sg; g = PNoGen; c= Nom} ;
  some_NDet = nekotorujDet ** { g = PNoGen; c= Nom} ;  
  something_NP  = pron2NounPhrase pronChtoTo Inanimate ;
  somewhere_Adv  = ss "где-нибудь" ;
---  TheseNumNP n =  { s =\\_ => [] ; n = Pl; p = P3; g= PGen Fem ;
--- anim = Animate ;  pron = True} ;    -- missing in Russian
 ---  ThoseNumNP n =  { s =\\_ => [] ; n = Pl; p = P3; g=PGen Fem ;
--- anim = Animate ;  pron = True} ;    -- missing in Russian
  that_Det   = totDet ** {n = Sg; g = PNoGen; c= Nom} ;
  that_NP  = det2NounPhrase totDet ; -- inanimate form only
  therefore_Adv  = ss "следовательно" ;
  these_NDet  = etotDet ** { g = PNoGen; c= Nom} ;  
  they8fem_NP = pron2NounPhrase pronOni Animate;
  they_NP  = pron2NounPhrase pronOni Animate;
  this_Det   = etotDet ** {n = Sg; g = PNoGen; c= Nom} ;
  this_NP  = det2NounPhrase etotDet ; -- inanimate form only
  those_NDet  = totDet ** {g = PNoGen; c= Nom} ;    
  thou_NP = pron2NounPhrase pronTu Animate;
  through_Prep  = { s2 = "через" ; c = Acc };
  to_Prep = { s2 = "к" ; c = Dat };
  too_Adv = ss "слишком" ;
  under_Prep  = { s2 = "под"  ; c = Inst };
  very_Adv  = ss "очень" ;
  want_VV  = verbKhotet ;
  we_NP  = pron2NounPhrase pronMu Animate ;
  what8many_IP = pron2NounPhraseNum pronChto Inanimate Pl;
  what8one_IP = pron2NounPhraseNum pronChto Inanimate Sg;
  when_IAdv = ss "когда" ;
  when_Subj  = ss "когда" ;
  where_IAdv  = ss "где" ;
  which8many_IDet = kotorujDet ** {n = Pl; g = PNoGen; c= Nom} ;  
  which8one_IDet = kotorujDet ** {n = Sg; g = PNoGen; c= Nom} ;
  who8many_IP = pron2NounPhraseNum pronKto Animate Pl;
  who8one_IP = pron2NounPhraseNum pronKto Animate Sg;
  why_IAdv  = ss "почему" ;
  with_Prep  = { s2 = "с" ; c = Inst};
  without_Prep  = { s2 = "без" ; c = Gen};
  ye_NP  = pron2NounPhrase pronVu Animate;
  yes_Phr  = ss ["Да ."] ;
  you_NP   = pron2NounPhrase pronVu Animate;
---  NoDet    = nikakojDet ** {n = Sg; g = PNoGen; c= Nom} ;
---  AnyDet   = lubojDet ** {n = Sg; g = PNoGen; c= Nom} ;
---  AnyNumDet  = mkDeterminerNum (lubojDet ** {n = Pl; g = PNoGen; c= Nom} );  
---  NoNumDet   = mkDeterminerNum (nikakojDet ** {n = Pl; g = PNoGen; c= Nom} );  
---NobodyNP = pron2NounPhrase pronNikto Animate;
---NothingNP = pron2NounPhrase pronNichto Inanimate;

-- In case of "neither..  no" expression double negation is not 
-- only possible, but also required in Russian.
-- There is no means of control for this however in the resource grammar.
---  NeitherNor = sd2 "ни" [", ни"]  ** {n = Sg} ;
---  NowhereNP = ss "нигде" ;
---  AgentPrep = { s2 = "" ; c = Nom}; -- missing in Russian
} ;
