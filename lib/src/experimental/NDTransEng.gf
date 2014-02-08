--# -path=.:../translator

concrete NDTransEng of NDTrans =
   NDLiftEng
  ,ExtensionsEng [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,DictionaryEng - [Pol,Tense]

              ** open ResEng, PredInstanceEng, Prelude, (Pr = PredEng) in {

flags 
  literal=Symb ;

}
