abstract Travel = Numeral ** {

cat 
  Order ;
cat
  Output ;

fun
  confirm : Order -> Number -> Output ;


-- the essential phrases from Lone Planet Thai Phrasebook

  order : Phrase -> Order ;

cat 
  Phrase ;
  Number ;

fun
  Hello           : Phrase ;
  Goodbye         : Phrase ;
  Please          : Phrase ;
  ThankYou        : Phrase ;
  YoureWelcome    : Phrase ;
  Yes             : Phrase ;
  No              : Phrase ;
  ExcuseAttention : Phrase ;
  ExcuseGetPast   : Phrase ;
  Sorry           : Phrase ;
  IUnderstand     : Phrase ;
  IDontUnderstand : Phrase ;
  Help            : Phrase ;
  WhereAreToilets : Phrase ;

  
  SayNumber : Numeral -> Phrase ;

  One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten : Number ;


cat 
  Product ;
  Kind ;

fun
  HowMuchCost : Product -> Order ;
  IWantToHave : Product -> Order ;

  This : Kind -> Product ;

  Beer  : Kind ;
  Shirt : Kind ;

}
