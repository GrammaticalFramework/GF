abstract Predic = Categories ** {

  cat
    VType ;
    CType ;
    Verb  VType ;
    Compl VType ;

  fun
    Vt_ : VType ;
    Vt  : CType -> VType ;
    VtN : CType -> VType ;

    CtN, 
    CtS, 
    CtV, 
    CtQ, 
    CtA : CType ;

    SPredVerb : (v : VType) -> NP -> Verb v -> Compl v -> Cl ;

    QPredVerb : (v : VType) -> IP -> Verb v -> Compl v -> QCl ;
    RPredVerb : (v : VType) -> RP -> Verb v -> Compl v -> RCl ;
    IPredVerb : (v : VType) ->       Verb v -> Compl v -> VCl ;

    ComplNil :       Compl Vt_ ;
    ComplNP  : NP -> Compl (Vt CtN) ;
    ComplS   : S  -> Compl (Vt CtS) ;
    ComplQ   : QS -> Compl (Vt CtQ) ;
    ComplA   : AP -> Compl (Vt CtQ) ;

    ComplAdd : (c : CType) -> NP -> Compl (Vt c) -> Compl (VtN c) ;

{-
    MkSlash3 :                NG NtS -> VG (VtN CtN) -> CG (Vt CtN) -> Slash ;
    MkSlash2 : (c : CType) -> NG NtS -> VG (VtN c)   -> CG (Vt c) -> Slash ;
    MkSlash1 :                NG NtS -> VG (Vt CtN)  -> Slash ;
    SlashQ : NG NtQ -> Slash -> SG NtQ ;
-}


    VeV1  : V   -> Verb Vt_ ;
    VeV2  : V2  -> Verb (Vt CtN) ;
    VeVS  : VS  -> Verb (Vt CtS) ;
    VeV3  : V3  -> Verb (VtN CtN) ;
    VeV2S : V2S -> Verb (VtN CtS) ;
    VeV2Q : V2Q -> Verb (VtN CtQ) ;
    ---- etc
}
