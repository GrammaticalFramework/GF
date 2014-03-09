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

}

