abstract ExtraFinAbs = Extra [
  GenNP,VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VV,VP,Conj,NP,Quant,IAdv,IComp,ICompAP,IAdvAdv,Adv,AP, Pron, ProDrop] ** {

  fun
    AdvExistNP : Adv -> NP -> Cl ;        -- kuvassa olemme me
    AdvPredNP  : Adv -> V  -> NP -> Cl ;  -- kuvassa hymyilee Veikko

    RelExistNP : Prep -> RP -> NP -> RCl ; -- jossa on jazzia

    i_implicPron : Pron ;                 -- (minä), minut, ...
    whatPart_IP : IP ;

    PartCN : CN -> NP ;                   -- olutta

    vai_Conj : Conj ;                     -- minä vai sinä? ("or" in question)

    CompPartAP : AP -> Comp ;             -- kahvi on valmista

    ProDropPoss : Pron -> Quant ;         -- vaimoni

  cat
    ClPlus ;      -- clause with more variation
    Part ;        -- discourse particle

  fun
    S_SVO  : Temp -> Pol -> ClPlus  -> S ;  -- mepäs juomme maitoa
    S_SOV  : Temp -> Pol -> ClPlus  -> S ;  -- mepäs maitoa juomme
    S_OSV  : Temp -> Pol -> ClPlus  -> S ;  -- maitoapas me juomme
    S_OVS  : Temp -> Pol -> ClPlus  -> S ;  -- maitoapas juomme me
    S_VSO  : Temp -> Pol -> ClPlus  -> S ;  -- juommepas me maitoa
    S_VOS  : Temp -> Pol -> ClPlus  -> S ;  -- juommepas maitoa me

    PredClPlus : NP -> VP -> ClPlus ;

----    noPart, han_Part, pa_Part, pas_Part, ko_Part, kos_Part, 
----      kohan_Part, pahan_Part : Part ; 

}
