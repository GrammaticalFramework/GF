--# -path=.:../translator

concrete NDTransSwe of NDTrans =
   NDLiftSwe
  ,ExtensionsSwe [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionarySwe - [Pol,Tense]
  ,DocumentationSwe - [Pol,Tense]
  ,ChunkSwe
              ** open CommonScand, ResSwe, PredInstanceSwe, (Pr=PredSwe), Prelude in {

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

