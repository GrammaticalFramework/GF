abstract ExtraRomanceAbs = Cat, Extra[
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VV,VP,Conj,Pron,ProDrop,CompIQuant,IQuant,IComp] ** {

  fun 
    TPasseSimple : Tense ; --# notpresent
    ComplCN : V2 -> CN -> VP ;  -- j'ai soif
}
