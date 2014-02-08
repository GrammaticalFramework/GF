--# -path=.:../translator

concrete NDTransEng of NDTrans =
   NDLiftEng
  ,DictionaryEng - [Pol,Tense]

              ** open ResEng, PredInstanceEng, Prelude, (Pr = PredEng) in {

flags 
  literal=Symb ;

}
