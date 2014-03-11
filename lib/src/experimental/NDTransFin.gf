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

lincat
  TransUnit = {s : Str} ;

lin
  SFullstop p = {s = p.s ++ "."} ;
  SQuestmark p = {s = p.s ++ "?"} ;
  SExclmark p = {s = p.s ++ "!"} ;
  SUnmarked p = {s = p.s} ;

}

