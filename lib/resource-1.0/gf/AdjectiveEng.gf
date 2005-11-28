concrete AdjectiveEng of Adjective = CatEng ** open ResEng, Prelude in {

  lin

    PositA  a = {
      s = a.s ! AAdj Posit ;
      isPre = True
      } ;
    ComparA a np = {
      s = a.s ! AAdj Compar ++ "than" ++ np.s ! Nom ; 
      isPre = False
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = a.s ! AAdj Posit ++ a.c2 ++ np.s ! Acc ; 
      isPre = False
      } ;

    SentAP ap s = {
      s = ap.s ++ conjThat ++ s.s ; 
      isPre = False
      } ;
    QuestAP ap qs = {
      s = ap.s ++ qs.s ! QIndir ; 
      isPre = False
      } ;

    AdAP ada ap = {
      s = ada.s ++ ap.s ;
      isPre = ap.isPre
      } ;

    UseA2 a = a ;

}
