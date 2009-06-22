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
      NF Sg Nom => "дочь" ;
      NF Sg Gen => "дочери" ;
      NF Sg Dat => "дочери" ;
      NF Sg Acc => "дочь" ;
      NF Sg Inst => "дочерью" ;
      NF Sg (Prepos _) => "дочери" ;
      NF Pl Nom => "дочери" ;
      NF Pl Gen => "дочерей" ;
      NF Pl Dat => "дочерям" ;
      NF Pl Acc => "дочерей" ;
      NF Pl Inst => "дочерьми" ;
      NF Pl (Prepos _) => "дочерях"
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
      { NF Sg Nom =>  syn ;
        NF Sg Gen => syn+"а" ;
        NF Sg Dat => syn+"у" ;
        NF Sg Acc => syn +"а";
        NF Sg Inst => syn+"ом" ;
        NF Sg (Prepos _) => syn+"е" ;
        NF Pl Nom => syn+"ья" ;
        NF Pl Gen => syn+"ьев" ;
        NF Pl Dat => syn+"ьям" ;
        NF Pl Acc => syn +"ьев";
        NF Pl Inst => syn+"ьями" ;
        NF Pl (Prepos _) => syn+"ьяах"
    } ;
    g = Masc   ; anim = Animate
  } ;
---  time_N = nVremja "вре" ; -- +++ MG_UR: added +++
---  vocationalschool_N = nUchilishe "училищ" ; -- +++ MG_UR: added +++
  way_N = 
  {s  =  table
      { NF Sg  Nom =>  put+"ь" ;
        NF Sg Gen => put+"и" ;
        NF Sg Dat => put+"и" ;
        NF Sg Acc => put+"ь" ;
        NF Sg Inst => put+"ём" ;
        NF Sg (Prepos _) => put+"и" ;
        NF Pl  Nom => put+"и" ;
        NF Pl Gen => put+"ей" ;
        NF Pl Dat => put+"ям" ;
        NF Pl Acc => put+"и" ;
        NF Pl Inst => put+"ями" ;
        NF Pl (Prepos _) => put+"ях"
       } ;
    g = Masc ; anim = Inanimate
  } ;

---  word_N = nSlovo "слов" ; -- +++ MG_UR: added +++
}