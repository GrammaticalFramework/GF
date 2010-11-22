concrete DiscontEng of Discont = {
  param
    SForm = SDecl | SQuest ;
  lincat 
    S, NP, AP = Str ;
    Cl = SForm => Str ;
    VP = {verb,comp : Str} ; 
  lin 
    DeclCl  cl = cl ! SDecl ;
    QuestCl cl = cl ! SQuest ;
    PredVP np vp = table {
      SDecl  => np ++ vp.verb ++ vp.comp ;
      SQuest => vp.verb ++ np ++ vp.comp
      } ;
    CompAP ap = {
      verb = "is" ;
      comp = ap
      } ;
    John = "John" ;
    Old = "old" ;
}
