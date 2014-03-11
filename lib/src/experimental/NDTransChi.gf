--# -path=.:../translator

concrete NDTransChi of NDTrans =
   NDLiftChi
  ,ExtensionsChi [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionaryChi - [Pol,Tense,Ant]
  ,DocumentationChi - [Pol,Tense,Ant]
  ,ChunkChi
              ** open ResChi, PredInstanceChi, (Pr=PredChi), Prelude in {

flags 
  literal=Symb ;

lincat
  TransUnit = {s : Str} ;

lin
  SFullstop p = {s = p.s ++ fullstop_s} ;
  SQuestmark p = {s = p.s ++ questmark_s} ;
  SExclmark p = {s = p.s ++ exclmark_s} ;
  SUnmarked p = {s = p.s} ;
}

