--# -path=.:abstract:common
concrete ExtraLexRus of ExtraLexRusAbs = CatRus ** 
  open ParadigmsRus in {
flags 
  coding=utf8 ;
lin
---  bridge_N = mkN "мост" ;
---  candle_N = nSvecha "свеч" ; -- +++ MG_UR: added +++
---  citizen_N = nGrazhdanin "господ" ; -- +++ MG_UR: added +++
  daughter_N = 
  {s = table {
      SF Sg Nom => "дочь" ;
      SF Sg Gen => "дочери" ;
      SF Sg Dat => "дочери" ;
      SF Sg Acc => "дочь" ;
      SF Sg Inst => "дочерью" ;
      SF Sg (Prepos _) => "дочери" ;
      SF Pl Nom => "дочери" ;
      SF Pl Gen => "дочерей" ;
      SF Pl Dat => "дочерям" ;
      SF Pl Acc => "дочерей" ;
      SF Pl Inst => "дочерьми" ;
      SF Pl (Prepos _) => "дочерях"
    } ;
     g = Fem    ; anim = Animate
  } ;

---  desk_N = nStol "стол" ;
---  dictionary_N = nSlovar "словар" ;
---  fellow_N = nTovarish "товарищ" ; -- +++ MG_UR: added +++
---  flag_N = nVremja "зна" ;
---  heaven_N = nNebo "неб" ; -- +++ MG_UR: added +++
---  museum_N = nMusej "музе" ; -- +++ MG_UR: added +++
--  name_N = mkN "имя" "имени" "имени" "имя" "именем" "имени" "имени" "имена" "имён" "именам" "имена" "именами" "именах" neuter inanimate ;
---  ocean_N = nMorje "мор" ; -- +++ MG_UR: added +++
 son_N = 
  {s  =  table
      { SF Sg Nom =>  syn ;
        SF Sg Gen => syn+"а" ;
        SF Sg Dat => syn+"у" ;
        SF Sg Acc => syn +"а";
        SF Sg Inst => syn+"ом" ;
        SF Sg (Prepos _) => syn+"е" ;
        SF Pl Nom => syn+"ья" ;
        SF Pl Gen => syn+"ьев" ;
        SF Pl Dat => syn+"ьям" ;
        SF Pl Acc => syn +"ьев";
        SF Pl Inst => syn+"ьями" ;
        SF Pl (Prepos _) => syn+"ьяах"
    } ;
    g = Masc   ; anim = Animate
  } ;
---  time_N = nVremja "вре" ; -- +++ MG_UR: added +++
---  vocationalschool_N = nUchilishe "училищ" ; -- +++ MG_UR: added +++
  way_N = 
  {s  =  table
      { SF Sg  Nom =>  put+"ь" ;
        SF Sg Gen => put+"и" ;
        SF Sg Dat => put+"и" ;
        SF Sg Acc => put+"ь" ;
        SF Sg Inst => put+"ём" ;
        SF Sg (Prepos _) => put+"и" ;
        SF Pl  Nom => put+"и" ;
        SF Pl Gen => put+"ей" ;
        SF Pl Dat => put+"ям" ;
        SF Pl Acc => put+"и" ;
        SF Pl Inst => put+"ями" ;
        SF Pl (Prepos _) => put+"ях"
       } ;
    g = Masc ; anim = Inanimate
  } ;

---  word_N = nSlovo "слов" ; -- +++ MG_UR: added +++
}