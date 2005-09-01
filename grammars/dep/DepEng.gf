-- to test:
-- p -cat=SG -tr "who walks" | pt -transform=typecheck -tr | l 

concrete DepEng of Dep = open ResDep in {
  lincat
    NType, VType, CType = {s : Str} ;
    SG = {s : Str} ;
    NG = {s : Str} ;
    VG = {s : Str ; c : VComp} ;
    CG = {s1,s2 : Str} ;
    Slash = {s,s2 : Str} ;

  lin
    NtS, NtQ = {s = []} ;
    CtN, CtV, CtS, CtQ, CtA = {s = []} ;
    Vt, VtN = \x -> x ;
    Vt_ = {s = []} ;

    MkSG n v ng vg cg = {
      s = n.s ++ v.s ++ ng.s ++ vg.s ++ 
          case1 vg.c ++ cg.s1 ++ case2 vg.c ++ cg.s2
     } ;
  
    CG_ = {s1,s2 = []} ;
    CGN, CGQ = \ng -> {s1 = ng.s ; s2 = []} ;
    CGS sg = {s1 = "that" ++ sg.s ; s2 = []} ;
    CGN_ c np co = {s1 = c.s ++ np.s ; s2 = co.s1} ;

    MkSlash3   np v co = {
      s  = np.s ++ v.s ++ case1 v.c ++ co.s1 ; 
      s2 = case2 v.c
      } ;
    MkSlash2 c np v co = {
      s = c.s ++ np.s ++ v.s ++ case2 v.c ++ co.s2 ;
      s2 = case1 v.c
      } ;
    MkSlash1 np v = {
      s  = np.s ++ v.s ;
      s2 = case1 v.c
      } ;

    SlashQ qp sl = {s = sl.s2 ++ qp.s ++ sl.s} ;

    John = {s = "John"} ;
    Who  = {s = "who"} ;
    
    Walk = {s = "walks" ; c = VC_} ;
    Love = {s = "loves" ; c = VC1 C_} ;
    Know = {s = "knows" ; c = VC_} ;
    Give = {s = "gives" ; c = VC2 C_ C_to} ;
    Tell = {s = "tells" ; c = VC_} ;
    Ask  = {s = "asks"  ; c = VC_} ;

}
