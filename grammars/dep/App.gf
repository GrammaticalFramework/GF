abstract App = {
  cat
    S ; Q ; 
    NP ; QP ; 
    V ; V2 ; 

  fun
    SPredV  : NP -> V -> S ;
    SPredV2 : NP -> V -> NP -> S ;
    QPredV  : QP -> V -> Q ;
    QPredV2 : QP -> V -> NP -> Q ;

    aJohn : NP ;
    aWho  : QP ;
    
    aWalk : V ;
    aLove : V2 ;
}
