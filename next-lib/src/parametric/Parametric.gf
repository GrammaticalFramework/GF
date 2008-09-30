interface Parametric = {

oper

-- primitive

  PS : Type ;
  S  : Type ;
  Cl : Type ;
  NP : Type ;
  CN : Type ;
  AP : Type ;

  VPComp : Type ;

  CCase : Type ;
  Agr : Type ;

  V  : Type ;
  N  : Type ;
  A  : Type ;

  agrNP : NP -> Agr ;

  PredVP : NP -> VP -> Cl ;

  mkVPComp : (Agr => Str) -> Str -> Str -> VPComp ;

  insertVPComp : VPComp -> VP -> VP ;

-- derived

  VP : Type = {
    verb : V ; 
    comp : VPComp
    } ;

  VPSlash : Type = VP ** {c : CComp} ;

  UseV : V -> VP = \v -> {
    verb = v ;
    comp = mkVPComp (\\_ => []) [] [] 
    } ;

  SlashV : V -> (Agr => Str) -> Str -> Str -> CCase -> VPSlash = 
    \v,comp,adv,ext,c -> 
      insertVPComp (mkVPComp comp adv ext) (UseV v) ** {c = c} ;

}
