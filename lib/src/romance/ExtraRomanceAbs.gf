abstract ExtraRomanceAbs = Cat, Extra[
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VV,VP,Conj,Pron,ProDrop,CompIQuant,IQuant,IComp,PrepCN,CN,Prep,Adv] ** {

  fun 
    TPasseSimple : Tense ; --# notpresent
    ComplCN : V2 -> CN -> VP ;  -- j'ai soif
}
