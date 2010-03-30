abstract ExtraRomanceAbs = Cat, Extra[
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VV,VP,Conj] ** {

  fun 
    TPasseSimple : Tense ; --# notpresent
    ComplCN : V2 -> CN -> VP ;  -- j'ai soif
}
