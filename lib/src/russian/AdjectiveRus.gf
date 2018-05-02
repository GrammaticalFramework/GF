
--# -path=.:../abstract:../common:../../prelude


concrete AdjectiveRus of Adjective = CatRus ** open ResRus, Prelude in {
flags  coding=utf8 ;

  lin

    PositA  a = { s = a.s!Posit ; p = a.p ; preferShort = a.preferShort};
       -- Comparative forms are used with an object of comparison, as
        -- adjectival phrases ("больше тебя").

    ComparA bolshoj tu =
          {s = \\af => bolshoj.s ! Compar ! af ++ tu.s ! (mkPronForm Gen Yes NonPoss) ; 
           p = True ;
           preferShort = PrefShort
           } ;

  ---- AR 17/12/2008
    UseComparA bolshoj =
          {s = \\af => bolshoj.s ! Compar ! af ;
           p = True ;
           preferShort = PrefShort
           } ;

  ---- AR 17/12/2008
    CAdvAP ad ap np = let adp = ad.s in  {  ---- should be ad.p
      s = \\af => ad.s ++ ap.s ! af ++ adp ++ np.s  ! (mkPronForm Gen Yes NonPoss) ; 
      p = True ; ----?
      preferShort = ap.preferShort
      } ;

  ---- AR 17/12/2008
    AdjOrd  a = {
      s = a.s ;
      p = True ; ---- ?
      preferShort = PrefFull
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 vlublen tu =
    {s = \\af => vlublen.s !Posit! af ++ vlublen.c2.s ++ 
          tu.s ! (mkPronForm vlublen.c2.c No NonPoss) ;
     p = True ;
     preferShort = vlublen.preferShort
    } ;

    ReflA2 vlublen = 
    {s = \\af => vlublen.s !Posit! af ++ vlublen.c2.s ++ sam.s ! vlublen.c2.c;
     p = True ;
     preferShort = vlublen.preferShort
    } ;

    SentAP vlublen sent= 
    {s = \\af => vlublen.s ! af ++ [", "] ++ sent.s;
      p = True ;
      preferShort = vlublen.preferShort
    } ;


    AdAP ada ap = {
      s = \\af => ada.s ++ ap.s ! af ;
      p = True ;
      preferShort = ap.preferShort
      } ;

    UseA2 a = {
      s = \\af => a.s ! Posit ! af ;
      p = True ;
      preferShort = a.preferShort
    } ;
}

