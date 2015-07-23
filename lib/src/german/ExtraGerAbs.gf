abstract ExtraGerAbs = Extra [
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,ClSlash,RCl,
  VPS,ListVPS,BaseVPS,ConsVPS,ConjVPS,MkVPS,PredVPS,EmptyRelSlash,
  VPSlash, PassVPSlash, PassAgentVPSlash, CompIQuant, PastPartAP, PastPartAgentAP,
  Temp,Tense,Pol,S,NP,VV,VP,Conj,IAdv,IQuant,IComp,ICompAP,IAdvAdv,Adv,AP,
  Foc,FocObj,FocAdv,FocAP,UseFoc] ** {
  flags coding=utf8;
  
  cat
	FClause ; -- formal clause 
	
  fun
    PPzuAdv   : CN -> Adv ;  -- zum Lied, zur Flasche
    TImpfSubj : Tense ;      -- ich möchte...   --# notpresent

    moegen_VV : VV ;         -- ich mag/möchte singen

    DetNPMasc, DetNPFem : Det -> NP ;

	EsVV : VV -> VP -> VP ; -- ich genieße es zu schlafen
 	EsV2A : V2A -> AP -> S -> VP ; -- ich finde es schön, dass ...

  	VPass : V -> FClause ;   -- (es) wird getanzt
  	AdvFor : Adv -> FClause -> FClause ; -- es wird heute gelacht - addition of adverbs
  	FtoCl : FClause -> Cl ;  -- embedding FClause within the RGL, to allow generation of S, Utt, etc.
}
