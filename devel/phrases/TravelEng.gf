--# -path=.:prelude:resource-1.0/thai

concrete TravelEng of Travel = NumeralEng ** open Prelude in {

flags startcat = Order; language = en_US;

lincat
  Order = { s : Str } ;

printname cat
  Order = "What would you like to say?" ;

lin
  order is = { s = is.s } ;



lincat 
  Output = { s : Str } ;

lin
  confirm o t = { s = o.s} ;

flags unlexer=unwords ;

lincat 
  Phrase = SS ;
  Number = SS ;

lin
  Hello           = ss "hello" ;
  Goodbye         = ss "bye" ;
  Please          = ss "please" ;
  ThankYou        = ss "thanks" ;
  YoureWelcome    = ss ["you are welcome"] ;
  Yes             = ss "yes" ;
  No              = ss "no" ;
  ExcuseAttention = ss ["excuse me"] ;
  ExcuseGetPast   = ss ["excuse me"] ;
  Sorry           = ss "sorry" ;
  IUnderstand     = ss ["I understand"] ;
  IDontUnderstand = ss ["I do not understand"] ;
  Help            = ss "help" ;
  WhereAreToilets = ss ["where are the toilets"] ;

  
  SayNumber n = n ;

  One = ss "one" ; 
  Two = ss "two" ; 
  Three = ss "three" ; 
  Four = ss "four" ; 
  Five = ss "five" ; 
  Six = ss "six" ; 
  Seven = ss "seven" ; 
  Eight = ss "eight" ; 
  Nine = ss "nine" ; 
  Ten = ss "ten" ;

lincat
  Product = {s : Str} ;
  Kind = {s : Str} ;

printname cat
  Product = "what product do you mean?" ;
  Kind = "what kind of product do you mean?" ;

lin
  HowMuchCost p = {s = ["how much does"] ++ 
    variants {
    p.s ;
    -- no kind given
    "this" ;
    -- no product given at all
    "it"
    } ++ 
    "cost"} ;

  This k = {s = "this" ++ k.s} ;

  Beer = {s = "beer"} ;
  Shirt = {s = "shirt"} ;



}
