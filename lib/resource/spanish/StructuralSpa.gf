--# -path=.:../romance:../abstract:../../prelude


concrete StructuralSpa of Structural = CategoriesSpa, NumeralsSpa **
  open SyntaxSpa, MorphoSpa, BeschSpa, Prelude in {
  
lin

  UseNumeral n = {s = \\g => n.s !g ; n = n.n} ;

  above_Prep = justPrep "sobre" ;
  after_Prep = {s = "después" ; c = genitive} ;
  all8mass_Det = mkDeterminer singular "todo" "toda" ;
  all_NDet = mkDeterminerNum ["todos los"] ["todas las"] ;
  almost_Adv = ss "casi" ;
  although_Subj = ss "benché" ** {m = Con} ;
  and_Conj = etConj ;
  because_Subj = ss "porque" ** {m = Ind} ;
  before_Prep = {s = "antes" ; c = genitive} ;
  behind_Prep = {s = "detrás" ; c = genitive} ;
  between_Prep = justPrep "entre" ;
  both_AndConjD = etetConj ;
  by8agent_Prep = justPrep "por" ;
  by8means_Prep = justPrep "por" ;
  can8know_VV = mkVerbVerbDir (verbPres (saber_71 "saber") AHabere) ;
  can_VV = mkVerbVerbDir (verbPres (poder_58 "poder") AHabere) ; ----
  during_Prep = justPrep "durante" ; ----
  either8or_ConjD = ououConj ;
  everybody_NP = normalNounPhrase (\\c => prepCase c ++ "todos") Masc Pl ;
  every_Det = chaqueDet ;
  everything_NP = mkNameNounPhrase ["todo"] Masc ;
  everywhere_Adv = ss ["en todas partes"] ;
  from_Prep = justCase (CPrep P_de) ;
  he_NP = pronNounPhrase pronIl ;
  how8many_IDet = mkDeterminer plural "cuántos" "cuántas" ;
  how_IAdv = commentAdv ;
  if_Subj = siSubj ;
  in8front_Prep = {s = "delante" ; c = genitive} ;
  i_NP = pronNounPhrase pronJe ;
  in_Prep = justPrep "en" ;
  it_NP = pronNounPhrase pronIl ;
  many_Det = mkDeterminer plural "muchos" "muchas" ;
  most8many_Det = plupartDet ;
  most_Det = mkDeterminer1 singular (["la mayor parte"] ++ elisDe) ; --- de
  much_Det = mkDeterminer1 singular "mucho" ;
  must_VV = mkVerbVerbDir (verbPres (deber_6 "deber") AHabere) ; ----
  no_Phr = nonPhr ;
  on_Prep = justPrep "sobre" ; ----
  or_Conj = ouConj ;
  otherwise_Adv = ss "otramente" ;
  part_Prep = justCase genitive ; ---
  possess_Prep = justCase genitive ;
  quite_Adv = ss "bastante" ;
  she_NP = pronNounPhrase pronElle ;
  so_Adv = ss "tanto" ; ----
  somebody_NP = mkNameNounPhrase ["algún"] Masc ;
  some_Det = mkDeterminer singular "alguno" "alguna" ;
  some_NDet = mkDeterminerNum "algunos" "algunas" ;
  something_NP = mkNameNounPhrase ["algo"] Masc ;
  somewhere_Adv = ss ["en ninguna parte"] ;
  that_Det = mkDeterminer singular "eso" "esa" ;
  that_NP = mkNameNounPhrase ["eso"] Masc ;
  therefore_Adv = ss ["por eso"] ;
  these_NDet = mkDeterminerNum "estos" "estas" ;
  they8fem_NP = pronNounPhrase pronElles ;
  they_NP = pronNounPhrase pronIls ;
  this_Det = mkDeterminer singular "esto" "esta" ;
  this_NP = mkNameNounPhrase ["esto"] Masc ;
  those_NDet = mkDeterminerNum "esos" "esas" ;
  thou_NP = pronNounPhrase pronTu ;
  through_Prep = justPrep "por" ;
  too_Adv = ss "demasiado" ;
  to_Prep = justCase dative ; ---
  under_Prep = justPrep "bajo" ;
  very_Adv = ss "muy" ;
  want_VV = mkVerbVerbDir (verbPres (querer_64 "querer") AHabere) ; ----
  we_NP = pronNounPhrase pronNous ;
  what8one_IP = intPronWhat singular ;
  what8many_IP = intPronWhat plural ;
  when_IAdv = quandAdv ;
  when_Subj = quandSubj ;
  where_IAdv = ouAdv ;
  which8many_IDet = mkDeterminerNum "cuales" "cuales" ** {n = Pl} ;
  which8one_IDet = quelDet ;
  who8one_IP = intPronWho singular ;
  who8many_IP = intPronWho plural ;
  why_IAdv = pourquoiAdv ;
  without_Prep = justPrep "sin" ;
  with_Prep = justPrep "con" ;
  ye_NP = pronNounPhrase pronVous ;
  yes_Phr = ouiPhr ;
  you_NP = pronNounPhrase pronVous ;

}

