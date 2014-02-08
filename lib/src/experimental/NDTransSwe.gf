--# -path=.:../translator

concrete NDTransSwe of NDTrans =
   NDLiftSwe
  ,ExtensionsSwe [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionarySwe - [Pol,Tense]

              ** open CommonScand, ResSwe, PredInstanceSwe, (Pr=PredSwe), Prelude in {

flags 
  literal=Symb ;

}

