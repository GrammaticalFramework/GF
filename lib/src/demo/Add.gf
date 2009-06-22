
  PredVS : NP -> VS -> S -> Cl ;
  PredVVV2A : NP -> VV -> V2A -> NP -> AP -> Cl ;
  RelCNAdvPrep : CN -> NP -> V -> Adv -> Prep -> CN ;

  PredVS np vs s = PredVP np (ComplVS vs s) ;

  PredVVV2A np vv v2 np2 ap = PredVP np (ComplVV vv (ComplSlash (SlashV2A v2 ap) np2)) ;

  RelCNAdvPrep cn np v adv prep = RelCN cn (UseRCl TPast ASimul PPos 
            (RelSlash IdRP (SlashPrep (PredVP np (AdvVP (UseV v) adv)) prep))) ;

