abstract Discont = {
  cat 
    S ; Cl ; NP ; VP ; AP ; 
  fun 
    DeclCl  : Cl -> S ;
    QuestCl : Cl -> S ;
    PredVP  : NP -> VP -> Cl ; 
    CompAP  : AP -> VP ;
    John : NP ;
    Old : AP ;
}
