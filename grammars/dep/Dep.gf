abstract Dep = {
  cat
    NType ;
    VType ;
    SG NType ;
    NG NType ;
    VG VType ;
    CG VType ;


  fun
    NtS, NtQ : NType ;
    Vt1, Vt2, VtS : VType ;

    MkSG : (n : NType) -> (v : VType) -> NG n -> VG v -> CG v -> SG n ;
  
    CG1 : CG Vt1 ;    
    CG2 : NG NtS -> CG Vt2 ;

    John : NG NtS ;
    Who  : NG NtQ ;
    
    Walk : VG Vt1 ;
    Love : VG Vt2 ;
}
