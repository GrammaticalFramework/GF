
--# -path=.:../abstract:../common:../../prelude


concrete AdjectiveRus of Adjective = CatRus ** open ResRus, Prelude in {
flags  coding=utf8 ;

  lin

    PositA  a = { s = a.s!Posit; p = False};
       -- Comparative forms are used with an object of comparison, as
        -- adjectival phrases ("больше тебя").

    ComparA bolshoj tu =
          {s = \\af => bolshoj.s ! Compar ! af ++ tu.s ! (mkPronForm Gen Yes NonPoss) ; 
            p = True
           } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 vlublen tu =
    {s = \\af => vlublen.s !Posit! af ++ vlublen.s2 ++ 
          tu.s ! (mkPronForm vlublen.c No NonPoss) ;
     p = True
    } ;

    ReflA2 vlublen = 
    {s = \\af => vlublen.s !Posit! af ++ vlublen.s2 ++ "себя";
     p = True
    } ;

    SentAP vlublen sent= 
    {s = \\af => vlublen.s ! af ++ sent.s;
      p = True
    } ;


    AdAP ada ap = {
      s = \\af => ada.s ++ ap.s ! af ;
      p = True
      } ;

    UseA2 a = a ;

}

