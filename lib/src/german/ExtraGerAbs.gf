abstract ExtraGerAbs = Extra [
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,ClSlash,RCl,
  VPS,ListVPS,BaseVPS,ConsVPS,ConjVPS,MkVPS,PredVPS,EmptyRelSlash,
  VPSlash, PassVPSlash, PassAgentVPSlash, CompIQuant, PastPartAP, PastPartAgentAP,
  Temp,Tense,Pol,S,NP,VV,VP,Conj,IAdv,IQuant,IComp,ICompAP,IAdvAdv,Adv,AP] ** {
  flags coding=utf8;
  fun
    PPzuAdv   : CN -> Adv ;  -- zum Lied, zur Flasche
    TImpfSubj : Tense ;      -- ich möchte...   --# notpresent

    moegen_VV : VV ;         -- ich mag/möchte singen

    DetNPMasc, DetNPFem : Det -> NP ;
}
