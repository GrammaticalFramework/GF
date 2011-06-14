concrete AdjectiveNep of Adjective = CatNep ** open ResNep, Prelude in {

  flags coding = utf8;
  lin
    
    -- ALL THE RULES FROM BOOK ARE NOT COVERED

    --PositA  : A  -> AP ;        -- warm
    PositA a = a ;
	
    
    --ComparA : A  -> NP -> AP ;  -- warmer than I
    ComparA a np = {
      s = \\n, g => np.s ! NPC Nom ++ "भन्दा" ++ a.s ! n ! g ;
      } ;
    
     
    --ComplA2 : A2 -> NP -> AP ;  -- married to her
    ComplA2 a np = {
      s = \\n,g  => np.s ! NPC Nom ++ a.c2 ++ a.s ! n ! g  ; 
      } ;

    
    --ReflA2  : A2 -> AP ;        -- married to itself
    ReflA2 a = { 
      s = \\n, g => "आफै" ++ a.c2 ++ a.s ! n ! g ; -- आफै सँग
      } ;
      
    
    --UseA2   : A2 -> AP ;        -- married
    UseA2 a = a ;
    
    
   --UseComparA : A  -> AP ;     -- warmer
    UseComparA a = {
      s = \\n, g => "अली" ++ a.s ! n ! g ; -- अली
      } ;     
    
    
    --CAdvAP  : CAdv -> AP -> NP -> AP ; -- as cool as John
    CAdvAP cadv ap np = {
	  s = \\n,g => np.s ! NPC Nom ++ cadv.p ++ cadv.s ++ ap.s ! n ! g   ;
	  };    
    
    
    --AdjOrd  : Ord -> AP ;       -- warmest
    AdjOrd ord =  { s = \\_,_ => ord.s ; };        
    
    
    --SentAP  : AP -> SC -> AP ;  -- good that she is here
    SentAP ap sc = {
      s = \\n,g => sc.s ++ ap.s ! n ! g ; 
      --s = \\n,g => ap.s ! n ! g ++ sc.s ; 
      } ;

    
    --AdAP    : AdA -> AP -> AP ; -- very warm
    AdAP ada ap = {
      s = \\n,g => ada.s ++ ap.s ! n ! g ;
      } ;
      
    
    --AdvAP   : AP -> Adv -> AP ; -- warm by nature
    AdvAP ap adv = {
      s = \\n,g => adv.s ++ ap.s ! n ! g ;
      } ;
      
}
