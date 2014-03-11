--# -path=.:../translator

concrete NDTransEng of NDTrans =
   NDLiftEng
  ,ExtensionsEng [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionaryEng - [Pol,Tense]
  ,DocumentationEng - [Pol,Tense]
  ,ChunkEng
              ** open ResEng, PredInstanceEng, Prelude, (Pr = PredEng) in {

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
