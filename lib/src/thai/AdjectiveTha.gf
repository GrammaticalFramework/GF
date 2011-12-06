concrete AdjectiveTha of Adjective = CatTha ** open ResTha, Prelude in {

  lin

    PositA  a = a ;

    ComparA a np = mkAdj (thbind a.s kwaa_s np.s) ;

    UseComparA a = mkAdj (thbind a.s kwaa_s) ;

    AdjOrd ord = ord ;

    CAdvAP ad ap np = mkAdj (thbind ap.s ad.s ad.p np.s) ;

    ComplA2 a np = mkAdj (thbind a.s a.c2 np.s) ;

    ReflA2 a = mkAdj (thbind a.s a.c2 reflPron) ;

    SentAP ap sc = thbind ap sc ;

    AdAP ada ap = thbind ap ada ;

    UseA2 a = a ;

}
