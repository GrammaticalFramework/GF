abstract ExtraGerAbs = Extra [
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VPS,ListVPS,BaseVPS,ConsVPS,ConjVPS,MkVPS,PredVPS,
  Temp,Tense,Pol,S,NP,VV,VP,Conj,IAdv,IComp,ICompAP,IAdvAdv,Adv,AP] ** {

  fun
    PPzuAdv   : CN -> Adv ;  -- zum Lied, zur Flasche
    TImpfSubj : Tense ;      -- ich möchte...   --# notpresent

    moegen_VV : VV ;         -- ich mag/möchte singen

    DetNPMasc, DetNPFem : Det -> NP ;
}
