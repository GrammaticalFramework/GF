abstract ExtraFinAbs = Extra [
  GenNP,VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VV,VP,Conj,NP,Quant,IAdv,IComp,ICompAP,IAdvAdv,Adv,AP, Pron, ProDrop] ** {

  fun
    AdvExistNP : Adv -> NP -> Cl ;        -- kuvassa olemme me
    AdvPredNP  : Adv -> V  -> NP -> Cl ;  -- kuvassa hymyilee Veikko

    RelExistNP : Prep -> RP -> NP -> RCl ; -- jossa on jazzia

    i_implicPron : Pron ;                 -- (min�), minut, ...
    whatPart_IP : IP ;

    PartCN : CN -> NP ;                   -- olutta

    vai_Conj : Conj ;                     -- minä vai sinä? ("or" in question)

    CompPartAP : AP -> Comp ;             -- kahvi on valmista
}
