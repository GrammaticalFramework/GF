--# -path=.:prelude:resource-1.0/thai

concrete TravelTha of Travel = NumeralTha ** open Prelude, StringsTha in {

flags startcat = Order; language = en_US; coding=utf8 ;

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




flags unlexer=concat ; 

lincat 
  Phrase = SS ;
  Number = SS ;

lin
  Hello           = ss (sawat_s ++ dii_s) ;
  Goodbye         = ss (laa_s ++ koon_s) ;
  Please          = ss (khoo_s) ;
  ThankYou        = ss (khoop_s ++ khun_s) ;
  YoureWelcome    = ss (yin_s ++ dii_s) ;
  Yes             = ss (chay_s) ;
  No              = ss (may_s) ;
  ExcuseAttention = ss (khoo_s ++ thoot_s) ;
  ExcuseGetPast   = ss (khoo_s ++ aphai_s) ;
  Sorry           = ss (khoo_s ++ thoot_s) ;
  IUnderstand     = ss (phom_s ++ khow_s ++ jai_s) ;
  IDontUnderstand = ss (phom_s ++ may_s ++ khow_s ++ jai_s) ;
  Help            = ss (chuay_s ++ duay_s) ;
  WhereAreToilets = ss (hoog_s ++ nam_s ++ yuu_s ++ thii_s ++ nai_s) ;

  
  SayNumber n = n ;

  One = ss (nvg_s) ; 
  Two = ss (soog_s) ; 
  Three = ss (saam_s) ; 
  Four = ss (sii_s) ; 
  Five = ss (haa_s) ; 
  Six = ss (hok_s) ; 
  Seven = ss (cet_s) ; 
  Eight = ss (peet_s) ; 
  Nine = ss (kaaw_s) ; 
  Ten = ss (sip_s) ;

lincat
  Product = {s : Str} ;
  Kind = {s : Str} ;

printname cat
  Product = "what product do you mean?" ;
  Kind = "what kind of product do you mean?" ;

lin
  HowMuchCost p = ss (p.s ++ thao_s ++ rai_s) ;

  This k = ss (k.s ++ nii_s) ;

  Beer = ss biar_s ;
  Shirt = ss (seua_s ++ cheut_s) ;


}