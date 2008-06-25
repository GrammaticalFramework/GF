resource StoneageResIta = open RulesIta, SyntaxIta, ParadigmsIta in {

oper
  PresV : V -> NP -> Phr = \v,s -> PresCl (mkSats s v) ;
  PresV2 : V2 -> NP -> NP -> Phr = \v,s,o -> 
    PresCl (mkSatsObject s v o) ;
  PresV3 : V3 -> NP -> NP -> NP -> Phr = \v,s,o,r -> 
    PresCl (insertObject (mkSatsObject s v o) v.c3 v.s3 r) ;
  PresVasV2 : V -> NP -> NP -> Phr = \ v -> PresV2 (dirV2 v) ;

  PresReflV : V -> NP -> Phr = \v,s -> 
    PresCl (insertObject (mkSats s v) accusative.p1 [] 
      (reflPronNounPhrase (pgen2gen s.g) s.n s.p)) ;

  PresCl : Sats -> Phr = \c -> 
    {s = (UseCl (PosTP TPresent ASimul) 
            (sats2clause c ** {lock_Cl = <>})
         ).s ! Ind ; 
     lock_Phr = <>
    } ;
 
  ModPosA : ADeg -> CN -> CN = \a -> ModAP (PositADeg a) ;
  ModA : A -> CN -> CN = \a -> ModAP (UseA a) ;

}