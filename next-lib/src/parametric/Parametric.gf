interface Parametric = {

oper

-- primitive

  S  : Type ;
  NP : Type ;
  CN : Type ;
  AP : Type ;

  VPComp : Type ;

  ITense : Type ;
  CCase : Type ;
  Agr : Type ;

  V  : Type ;
  N  : Type ;
  A  : Type ;

  agrNP : NP -> Agr ;

  PredVP : NP -> VP -> Cl ;

  mkVPComp : (Agr => Str) -> Str -> Str -> VPComp ;

  insertVPComp : VPComp -> VP -> VP ;

  insertNP : CCase -> NP -> VP -> VP ;

  iTense : Tense -> ITense ;

-- derived

  Cl : Type = {s : ITense => Polarity => S} ;

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

  ComplSlash : VPSlash -> NP -> VP = \vp,np -> insertNP vp.c np vp ;

  UseCl : Tense -> Polarity -> Cl -> S = \t,p,cl -> cl.s ! iTense t ! p ;

}
