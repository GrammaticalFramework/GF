--# -path=.:prelude:resource-1.0/thai

-- the essential phrases from Lone Planet Thai Phrasebook

concrete EssentialThai of Essential = open Prelude, StringsTha in {

flags unlexer=concat ; 
startcat=Phrase ;

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

}