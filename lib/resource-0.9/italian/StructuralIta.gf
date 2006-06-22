--# -path=.:../romance:../abstract:../../prelude

concrete StructuralIta of Structural = CategoriesIta, NumeralsIta ** 
  open SyntaxIta, MorphoIta, BeschIta, Prelude in {

lin

  UseNumeral n = {s = \\g => n.s !g ; n = n.n ; isNo = False} ;

  above_Prep = justPrep "sopra" ;
  after_Prep = justPrep "dopo" ;
  all8mass_Det = mkDeterminer singular "tutto" "tutta" ;
  all_NDet = mkDeterminerNum ["tutti i"] ["tutte le"] ; --- gli
  almost_Adv = ss "quasi" ;
  although_Subj = ss "benché" ** {m = Con} ;
  and_Conj = etConj ;
  because_Subj = ss "perché" ** {m = Ind} ;
  before_Prep = justPrep "prima" ;
  behind_Prep = justPrep "dietro" ;
  between_Prep = justPrep "tra" ;
  both_AndConjD = etetConj ;
  by8agent_Prep = justCase (CPrep P_da) ;
  by8means_Prep = justPrep "per" ;
  can8know_VV = mkVerbVerbDir (verbPres (sapere_78 "sapere") AHabere) ;
  can_VV = mkVerbVerbDir (verbPres (potere_69 "potere") AHabere) ;
  during_Prep = justPrep "durante" ;
  either8or_ConjD = ououConj ;
  everybody_NP = normalNounPhrase (\\c => prepCase c ++ "tutti") Masc Pl ;
  every_Det = chaqueDet ;
  everything_NP = mkNameNounPhrase ["tutto"] Masc ;
  everywhere_Adv = ss "dappertutto" ;
  from_Prep = justCase (CPrep P_da) ;
  he_NP = pronNounPhrase pronIl ;
  how_IAdv = commentAdv ;
  how8many_IDet = {s = genForms "quanti" "quante" ; n = Pl} ;
  if_Subj = siSubj ;
  in8front_Prep = justPrep "davanti" ;
  i_NP = pronNounPhrase pronJe ;
  in_Prep = justCase (CPrep P_in) ;
  it_NP = pronNounPhrase pronIl ;
  many_Det = mkDeterminer plural "molti" "molte" ;
  most8many_Det = plupartDet ;
  most_Det = mkDeterminer1 singular (["la maggior parte"] ++ elisDe) ; --- de
  much_Det = mkDeterminer1 singular "molto" ;
  must_VV = mkVerbVerbDir (verbPres (dovere_47 "dovere") AHabere) ;
  no_Phr = nonPhr ; --- and also Si!
  on_Prep = justCase (CPrep P_su) ;
  or_Conj = ouConj ;
  otherwise_Adv = ss "altramente" ;
  part_Prep = justCase genitive ; ---
  possess_Prep = justCase genitive ;
  quite_Adv = ss "assai" ;
  she_NP = pronNounPhrase pronElle ;
  so_Adv = ss "così" ;
  somebody_NP = mkNameNounPhrase ["qualcuno"] Masc ;
  some_Det = mkDeterminer1 singular "qualche" ;
  some_NDet = mkDeterminerNum "alcuni" "alcune" ;
  something_NP = mkNameNounPhrase ["qualche cosa"] Masc ;
  somewhere_Adv = ss ["qualche parte"] ; --- ne - pas
  that_Det = mkDeterminer singular "quello" "quella" ;
  that_NP = mkNameNounPhrase ["quello"] Masc ;
  therefore_Adv = ss "quindi" ;
  these_NDet = mkDeterminerNum "questi" "queste" ; --- ci
  they_NP = pronNounPhrase pronIls ;
  they8fem_NP = pronNounPhrase pronIls ;
  this_Det = mkDeterminer singular "questo" "questa" ;
  this_NP = mkNameNounPhrase ["questo"] Masc ;
  those_NDet = mkDeterminerNum "quelli" "quelle" ; --- quegli
  thou_NP = pronNounPhrase pronTu ;
  through_Prep = justPrep "per" ;
  too_Adv = ss "troppo" ;
  to_Prep = justCase dative ; ---
  under_Prep = justPrep "sotto" ;
  very_Adv = ss "molto" ;
  want_VV = mkVerbVerbDir (verbPres (volere_96 "volere") AHabere) ;
  we_NP = pronNounPhrase pronNous ;
  what8one_IP = intPronWhat singular ;
  what8many_IP = intPronWhat plural ;
  when_IAdv = quandAdv ;
  when_Subj = quandSubj ;
  where_IAdv = ouAdv ;
  which8many_IDet = mkDeterminerNum "quali" "quali" ** {n = Pl} ;
  which8one_IDet = quelDet ;
  who8one_IP = intPronWho singular ;
  who8many_IP = intPronWho plural ;
  why_IAdv = pourquoiAdv ;
  without_Prep = justPrep "senza" ;
  with_Prep = justCase (CPrep P_con) ;
  ye_NP = pronNounPhrase pronVous ;
  yes_Phr = ouiPhr ;
  you_NP = pronNounPhrase pronVous ;
}
