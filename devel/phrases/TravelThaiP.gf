--# -path=.:prelude:resource-1.0/thai

concrete TravelThaiP of Travel = NumeralThaiP ** open Prelude, StringsTha in {

flags startcat = Order; language = en_US ;

lincat
  Order = { s : Str } ;

printname cat
  Order = "What would you like to say?" ;

lin
  order is = { s = is.s } ;



lincat 
  Output = { s : Str } ;

lin
  confirm o t = { s = o.s } ;




flags unlexer=unwords ; 

lincat 
  Phrase = SS ;
  Number = SS ;

lin
  Hello           = ss ["sah wut dee"] ;
  Goodbye         = ss ["lah gorn"] ;
  Please          = ss "kor" ;
  ThankYou        = ss ["kop koon"] ;
  YoureWelcome    = ss ["yin dee"] ;
  Yes             = ss "chai" ;
  No              = ss "mai" ;
  ExcuseAttention = ss ["koh tort"] ;
  ExcuseGetPast   = ss ["koh ahpai"] ;
  Sorry           = ss ["koh tort"] ;
  IUnderstand     = ss ["pom kow jai"] ;
  IDontUnderstand = ss ["pom mai kow jai"] ;
  Help            = ss ["chew wai dewai"] ;
  WhereAreToilets = ss ["hong narm yoo tee nai"] ;

  
  SayNumber n = n ;

  One = ss "neung" ; 
  Two = ss "song" ;
  Three = ss "sahm" ;
  Four = ss "see" ; 
  Five = ss "hah" ; 
  Six = ss "hok" ; 
  Seven = ss "jet" ; 
  Eight = ss "baat" ; 
  Nine = ss "gow" ; 
  Ten = ss "sip" ;

lincat
  Product = {s : Str} ;
  Kind = {s : Str} ;

printname cat
  Product = "what product do you mean?" ;
  Kind = "what kind of product do you mean?" ;

lin
  HowMuchCost p = ss (p.s ++ "tao" ++ "rai") ;
  IWantToHave p = ss ("kor" ++ p.s ++ "noy") ;

  This k = ss (k.s ++ "nee") ;

  Beer = ss "beea" ;
  Shirt = ss ("seua" ++ "cheut") ;

}