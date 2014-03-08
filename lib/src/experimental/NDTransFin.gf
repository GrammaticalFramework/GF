--# -path=.:../finnish/stemmed:../finnish:../api:../translator:alltenses

concrete NDTransFin of NDTrans =
   NDLiftFin
  ,ExtensionsFin [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionaryFin - [Pol,Tense]
  ,ChunkFin
  ,DocumentationFin - [Pol,Tense]

              ** {

flags 
  literal=Symb ;

}

