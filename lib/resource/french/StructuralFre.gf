--# -path=.:../romance:../abstract:../../prelude

concrete StructuralFre of Structural =
  CategoriesFre, NumeralsFre ** 
    open SyntaxFre, MorphoFre, Prelude in {

lin

  UseNumeral n = {s = \\g => n.s !g ; n = n.n} ;

  above_Prep = {s = ["au dessus"] ; c = genitive} ;
  after_Prep = justPrep "après" ;
  all8mass_Det = toutDet ;
  all_NDet = mkDeterminerNum ["tous les"] ["toutes les"] ;
  almost_Adv = ss "presque" ;
  although_Subj = ss ("bien" ++ elisQue) ** {m = Con} ;
  and_Conj = etConj ;
  because_Subj = ss ("parce" ++ elisQue) ** {m = Ind} ;
  before_Prep = justPrep "avant" ;
  behind_Prep = justPrep "derrière" ;
  between_Prep = justPrep "entre" ;
  both_AndConjD = etetConj ;
  by8agent_Prep = justPrep "par" ;
  by8means_Prep = justPrep "par" ;
  can8know_VV = mkVerbVerbDir (verbPres (conj3savoir "savoir") AHabere) ;
  can_VV = mkVerbVerbDir (verbPres (conj3pouvoir "pouvoir") AHabere) ;
  during_Prep = justPrep "pendant" ;
  either8or_ConjD = ououConj ;
  everybody_NP = mkNameNounPhrase ["tout le monde"] Masc ;
  every_Det = chaqueDet ;
  everything_NP = mkNameNounPhrase ["tout"] Masc ;
  everywhere_Adv = ss "partout" ;
  from_Prep = justCase genitive ; ---
  he_NP = pronNounPhrase pronIl ;
  how_IAdv = commentAdv ;
  how8many_IDet = {s = \\_ => "combien" ++ elisDe ; n = Pl} ;
  if_Subj = siSubj ;
  in8front_Prep = justPrep "devant" ;
  i_NP = pronNounPhrase pronJe ;
  in_Prep = justPrep "dans" ;
  it_NP = pronNounPhrase pronIl ;
  many_Det = mkDeterminer1 plural "plusieurs" ;
  most8many_Det = plupartDet ;
  most_Det = mkDeterminer1 singular (["la plupart"] ++ elisDe) ; --- de
  much_Det = mkDeterminer1 singular ("beaucoup" ++ elisDe) ; --- de
  must_VV = mkVerbVerbDir (verbPres (conj3devoir "devoir") AHabere) ;
  no_Phr = nonPhr ; --- and also Si!
  on_Prep = justPrep "sur" ;
  or_Conj = ouConj ;
  otherwise_Adv = ss "autrement" ;
  part_Prep = justCase genitive ; ---
  possess_Prep = justCase genitive ;
  quite_Adv = ss "assez" ;
  she_NP = pronNounPhrase pronElle ;
  so_Adv = ss "si" ;
  somebody_NP = mkNameNounPhrase ["quelqu'un"] Masc ;
  some_Det = mkDeterminer1 singular "quelque" ;
  some_NDet = mkDeterminerNum "quelques" "quelques" ;
  something_NP = mkNameNounPhrase ["quelque chose"] Masc ;
  somewhere_Adv = ss ["quelque part"] ; --- ne - pas
  that_Det = mkDeterminer singular (pre {"ce" ; "cet" / voyelle}) "cette" ; --- là
  that_NP = mkNameNounPhrase ["ça"] Masc ;
  therefore_Adv = ss "donc" ;
  these_NDet = mkDeterminerNum "ces" "ces" ; --- ci
  they_NP = pronNounPhrase pronIls ;
  they8fem_NP = pronNounPhrase pronElles ;
  this_Det = mkDeterminer singular (pre {"ce" ; "cet" / voyelle}) "cette" ; --- ci
  this_NP = mkNameNounPhrase ["ceci"] Masc ;
  those_NDet = mkDeterminerNum "ces" "ces" ; --- là
  thou_NP = pronNounPhrase pronTu ;
  through_Prep = justPrep "par" ;
  too_Adv = ss "trop" ;
  to_Prep = justCase dative ; ---
  under_Prep = justPrep "sous" ;
  very_Adv = ss "très" ;
  want_VV = mkVerbVerbDir (verbPres (conj3vouloir "vouloir") AHabere) ;
  we_NP = pronNounPhrase pronNous ;
  what8one_IP = intPronWhat singular ;
  what8many_IP = intPronWhat plural ;
  when_IAdv = quandAdv ;
  when_Subj = quandSubj ;
  where_IAdv = ouAdv ;
  which8many_IDet = mkDeterminerNum "quels" "quelles" ** {n = Pl} ;
  which8one_IDet = quelDet ;
  who8one_IP = intPronWho singular ;
  who8many_IP = intPronWho plural ;
  why_IAdv = pourquoiAdv ;
  without_Prep = justPrep "sans" ;
  with_Prep = justPrep "avec" ;
  ye_NP = pronNounPhrase pronVous ;
  yes_Phr = ouiPhr ;
  you_NP = pronNounPhrase pronVous ;


}
