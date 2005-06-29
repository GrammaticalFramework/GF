--# -path=.:../abstract:../../prelude

--1 The Top-Level Finnish Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2005
--
concrete StructuralFin of Structural = 
                      CategoriesFin, NumeralsFin ** open Prelude, SyntaxFin in {
  flags optimize=all ;

  lin

  UseNumeral i = {s = \\np => i.s ! NCase Sg (npForm2Case Sg np) ; n = i.n ; isNum = True} ;

  above_Prep = prepPostpGen "yläpuolella" ;
  after_Prep = prepPostpGen "jälkeen" ;
  all8mass_Det = mkDeterminer singular (kaikkiPron Sg) ;
  all_NDet =  mkDeterminerNum (kaikkiPron Pl) ;
  almost_Adv = ss "melkein" ;
  although_Subj = ss "vaikka" ;
  although_Subj = ss "vaikka" ;
  and_Conj = ss "ja" ** {n = Pl} ;
  because_Subj = ss "koska" ;
  before_Prep = prepPrep "ennen" Part ;
  behind_Prep = prepPostpGen "takana" ;
  between_Prep = prepPostpGen "välissä" ;
  both_AndConjD = sd2 "sekä" "että" ** {n = Pl} ;
  by8agent_Prep = prepPostpGen "toimesta" ;
  by8means_Prep = prepPostpGen "avulla" ;
  can8know_VV = nomVerbVerb (vOsata "osata") ;
  can_VV = nomVerbVerb (vJuoda "voida" "voi") ;
  during_Prep = prepPostpGen "aikana" ;
  either8or_ConjD = sd2 "joko" "tai" ** {n = Sg} ;
  everybody_NP = {
    s = \\f => kaikkiPron Pl ! (npForm2Case Pl f) ; -- näin kaikki
    n = Pl ;
    p = NP3
    } ;
  every_Det = jokainenDet ;
  everything_NP = {
    s = \\f => kaikkiPron Sg ! (npForm2Case Sg f) ; -- näin kaiken
    n = Sg ;
    p = NP3
    } ;
  everywhere_Adv = ss "kaikkialla" ;
  from_Prep = prepCase Elat ; --- ablat
  he_NP = pronNounPhrase pronHan ;
  how_IAdv = ss "kuinka" ;
  if_Subj = ss "jos" ;
  in8front_Prep = prepPostpGen "edessä" ;
  i_NP = pronNounPhrase pronMina ;
  in_Prep = prepCase Iness ;
  it_NP = nameNounPhrase pronSe ;
  many_Det = mkDeterminer singular moniPron ;
  most8many_Det = useimmatDet ;
  most_Det = mkDeterminer singular (caseTable singular (sSuurin "enintä")) ;
  much_Det = mkDeterminer singular (caseTable singular (sNauris "runsasta")) ;
  must_VV = vHukkua "täytyä" "täydy" ** {c = CCase Gen} ;
  no_Phr = ss ("Ei" ++ stopPunct) ;
  on_Prep = prepCase Adess ;
  or_Conj = ss "tai" ** {n = Sg} ;
  otherwise_Adv = ss "muuten" ;
  part_Prep = prepCase Part ;
  possess_Prep = prepCase Gen ;
  quite_Adv = ss "aika" ;
  she_NP = pronNounPhrase pronHan ;
  so_Adv = ss "niin" ;
  somebody_NP = {
    s = \\f => jokuPron ! Sg ! (npForm2Case Sg f) ;
    n = Sg ;
    p = NP3
    } ;
  some_Det = mkDeterminerGen Sg (jokinPron ! Sg) (jokuPron ! Sg) ;
  some_NDet = mkDeterminerGenNum (jokinPron ! Pl) (jokuPron ! Pl) ;
  something_NP = {
    s = \\f => jokinPron ! Sg ! (npForm2Case Sg f) ; -- näin kaiken
    n = Sg ;
    p = NP3
    } ;
  somewhere_Adv = ss "jossain" ;
  that_Det = mkDeterminer Sg (\\c => pronTuo.s ! PCase c) ;
  that_NP = pronNounPhraseNP pronTuo ;
  therefore_Adv = ss "siksi" ;
  these_NDet = mkDeterminerNum (\\c => pronNama.s ! PCase c) ;
  they_NP = pronNounPhrase pronHe ; --- ne
  this_Det = mkDeterminer Sg (\\c => pronTama.s ! PCase c) ;
  this_NP = pronNounPhraseNP pronTama ;
  those_NDet = mkDeterminerNum (\\c => pronNuo.s ! PCase c) ;
  thou_NP = pronNounPhrase pronSina ;
  through_Prep = prepPostpGen "kautta" ;
  too_Adv = ss "liian" ;
  to_Prep = prepCase Illat ; --- allat
  under_Prep = prepPostpGen "alla" ;
  very_Adv = ss "hyvin" ;
  want_VV = nomVerbVerb (vOsata "haluta") ;
  we_NP = pronNounPhrase pronMe ;
  what8many_IP = intPronWhat Pl ;
  what8one_IP = intPronWhat Sg ;
  when_IAdv = ss "koska" ;
  when_Subj = ss "kun" ;
  where_IAdv = ss "missä" ;
  which8one_IDet = mikaDet ;
----  which8many_IDet n = mkDeterminerGenNum n (mikaInt ! Pl) (kukaInt ! Pl) ;
  who8many_IP = intPronWho Pl ;
  who8one_IP = intPronWho Sg ;

  why_IAdv = ss "miksi" ;
  without_Prep = prepPrep "ilman" Part ;
  with_Prep = prepPostpGen "kanssa" ;
  ye_NP = pronNounPhrase pronTe ;
  yes_Phr = ss ("Kyllä" ++ stopPunct) ;
  you_NP = pronNounPhrase pronTe ;

}
