abstract Dep = {
  cat
    NType ;
    VType ;
    CType ;
    SG NType ;
    NG NType ;
    VG VType ;
    CG VType ;

    Slash ;

  fun
    NtS, NtQ : NType ;
    CtN, CtV, CtS, CtQ, CtA : CType ;
    Vt, VtN : CType -> VType ;
    Vt_     : VType ;

    MkSG : (n : NType) -> (v : VType) -> NG n -> VG v -> CG v -> SG n ;
  
    CG_ : CG Vt_ ;
    CGN : NG NtS -> CG (Vt CtN) ;
    CGS : SG NtS -> CG (Vt CtS) ;
    CGQ : SG NtQ -> CG (Vt CtQ) ;

    CGN_ : (c : CType) -> NG NtS -> CG (Vt c) -> CG (VtN c) ;

    MkSlash3 :                NG NtS -> VG (VtN CtN) -> CG (Vt CtN) -> Slash ;
    MkSlash2 : (c : CType) -> NG NtS -> VG (VtN c)   -> CG (Vt c) -> Slash ;
    MkSlash1 :                NG NtS -> VG (Vt CtN)  -> Slash ;
    SlashQ : NG NtQ -> Slash -> SG NtQ ;

    John : NG NtS ;
    Who  : NG NtQ ;
    
    Walk : VG Vt_ ;
    Love : VG (Vt CtN) ;
    Know : VG (Vt CtS) ;
    Give : VG (VtN CtN) ;
    Tell : VG (VtN CtS) ;
    Ask  : VG (VtN CtQ) ;
}
