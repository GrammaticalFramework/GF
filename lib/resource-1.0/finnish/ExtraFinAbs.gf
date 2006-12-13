abstract ExtraFinAbs = Extra [
  GenNP,VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI] ** {

  fun
    AdvExistNP : Adv -> NP -> Cl ;        -- kuvassa olemme me
    AdvPredNP  : Adv -> V  -> NP -> Cl ;  -- kuvassa hymyilee Veikko

    i_implicPron : Pron ;                 -- (minä), minut, ...
    whatPart_IP : IP ;

    vai_Conj : Conj ;                     -- minä vai sinä? ("or" in question)

    vai_Conj : Conj ;
}
