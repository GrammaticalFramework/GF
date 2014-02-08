--# -path=.:../finnish/stemmed:../finnish:../translator:alltenses

concrete NDTransFin of NDTrans =
   NDLiftFin
  ,ExtensionsFin [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionaryFin - [Pol,Tense]

              ** {

flags 
  literal=Symb ;

}

