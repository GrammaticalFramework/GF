concrete AppEng of App = open DepEng in {
  lincat
    S  = SG ;
    Q  = SG ;
    NP = NG ;
    QP = NG ;
    V  = VG ;
    V2 = VG ;

  lin
    SPredV  np v   = MkSG NtS Vt1 np v CG1 ; 
    SPredV2 np v y = MkSG NtS Vt2 np v (CG2 y) ; 
    QPredV  np v   = MkSG NtQ Vt1 np v CG1 ; 
    QPredV2 np v y = MkSG NtQ Vt2 np v (CG2 y) ; 

    aJohn = John ;
    aWho  = Who ;
    
    aWalk = Walk ;
    aLove = Love ;
}
