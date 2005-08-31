-- to test:
-- p -cat=SG -tr "who walks" | pt -transform=typecheck -tr | l 

concrete DepEng of Dep = {
  lincat
    NType, VType = {s : Str} ;
    SG = {s : Str} ;
    NG = {s : Str} ;
    VG = {s : Str} ;
    CG = {s : Str} ;

  lin
    NtS, NtQ = {s = []} ;
    Vt1, Vt2, VtS = {s = []} ;

    MkSG n v ng vg cg = {s = n.s ++ v.s ++ ng.s ++ vg.s ++ cg.s} ;
  
    CG1 = {s = []} ;
    CG2 ng = ng ;

    John = {s = "John"} ;
    Who  = {s = "who"} ;
    
    Walk = {s = "walks"} ;
    Love = {s = "loves"} ;
}
