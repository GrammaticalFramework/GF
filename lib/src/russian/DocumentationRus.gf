concrete DocumentationRus of Documentation = CatRus ** open 
  ResRus,
  HTML in {
flags coding=utf8 ;

lincat
  Inflection = {t : Str; s1,s2,s3 : Str} ;
  Definition = {s : Str} ;
  Document   = {s : Str} ;
  Tag        = {s : Str} ;

lin
  InflectionN,
  InflectionN2,
  InflectionN3 = \n ->  {
    t = "сущ" ;
    s1= heading1 ("Существительное"++
                  case n.g of {
                    Masc    => "(м.р.)" ;
                    Fem     => "(ж.р.)" ;
                    Neut    => "(ср.р.)"
                    } ++
                    
                  case n.anim of {
                      Animate => "Одушевлённое" ;
                      Inanimate => "Неодушевлённое" 
                    }
                    
      ) ;
    s2= frameTable (
          tr (th "Падеж" ++ th "ед. ч." ++ th "мн. ч.") ++
          tr (th "Им."   ++ td (n.s ! (NF Sg Nom) nom)        ++ td (n.s ! (NF Pl Nom nom))) ++ 
          tr (th "Р."    ++ td (n.s ! (NF Sg Gen) nom)        ++ td (n.s ! (NF Pl Gen nom))) ++
          tr (th "Д."    ++ td (n.s ! (NF Sg Dat) nom)        ++ td (n.s ! (NF Pl Dat nom))) ++
          tr (th "В."    ++ td (n.s ! (NF Sg Acc) nom)        ++ td (n.s ! (NF Pl Acc nom))) ++
          tr (th "Тв."   ++ td (n.s ! (NF Sg Inst) nom)       ++ td (n.s ! (NF Pl Inst nom))) ++
          tr (th "Пр."   ++ td (n.s ! (NF Sg (Prepos PrepOther) nom)) ++ td (n.s ! (NF Pl (Prepos PrepOther) nom))) 
        ) ;
    s3= ""
  } ;


  InflectionA,
  InflectionA2 = \a ->  {
    t = "прил" ;
    s1= heading1 ("Прилагательное"
                       
      ) ;
    s2= frameTable (
      tr (intagAttr "th" "rowspan=\"2\"" "Степень сравнения"  ++
          intagAttr "th" "rowspan=\"2\" colspan=\"2\"" "Падеж"  ++
          intagAttr "th" "colspan=\"3\"" "ед. ч." ++
          intagAttr "th" "rowspan=\"2\"" "мн. ч." ) ++
      tr(th "муж. р." ++ th "ср. р." ++ th "жен. р.") ++

        tr (intagAttr "th" "rowspan=\"7\"" "Положительная" ++
              intagAttr "th" "colspan=\"2\"" "Им."   ++ td (a.s ! Posit ! (AF Nom Animate (GSg Masc)))
                         ++ td (a.s ! Posit ! (AF Nom Animate (GSg Neut)))  
                         ++ td (a.s ! Posit ! (AF Nom Animate (GSg Fem)))
                         ++ td (a.s ! Posit ! (AF Nom Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Р."      ++ td (a.s ! Posit ! (AF Gen Animate (GSg Masc)))
                         ++ td (a.s ! Posit ! (AF Gen Animate (GSg Neut)))  
                         ++ td (a.s ! Posit ! (AF Gen Animate (GSg Fem)))
                         ++ td (a.s ! Posit ! (AF Gen Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Д."      ++ td (a.s ! Posit ! (AF Dat Animate (GSg Masc)))
                         ++ td (a.s ! Posit ! (AF Dat Animate (GSg Neut))) 
                         ++ td (a.s ! Posit ! (AF Dat Animate (GSg Fem)))
                         ++ td (a.s ! Posit ! (AF Dat Animate GPl))) ++

        tr (intagAttr "th" "rowspan=\"2\"" "В."
                         ++ th "одушевленное"
                         ++ td (a.s ! Posit ! (AF Acc Animate (GSg Masc)))
                         ++ intagAttr "td" "rowspan=\"2\"" (a.s ! Posit ! (AF Acc Animate (GSg Neut)))  
                         ++ intagAttr "td" "rowspan=\"2\"" (a.s ! Posit ! (AF Acc Animate (GSg Fem)))
                         ++ td (a.s ! Posit ! (AF Acc Animate GPl))) ++
        tr (                th "неодушевленное"

                         ++ td (a.s ! Posit ! (AF Acc Inanimate (GSg Masc)))
                         ++ td (a.s ! Posit ! (AF Acc Inanimate GPl))) ++


        tr (intagAttr "th" "colspan=\"2\"" "Тв."     ++ td (a.s ! Posit ! (AF Inst Animate (GSg Masc)))
                         ++ td (a.s ! Posit ! (AF Inst Animate (GSg Neut)))  
                         ++ td (a.s ! Posit ! (AF Inst Animate (GSg Fem)))
                         ++ td (a.s ! Posit ! (AF Inst Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Пр."     ++ td (a.s ! Posit ! (AF (Prepos PrepOther) Animate (GSg Masc)))
                         ++ td (a.s ! Posit ! (AF (Prepos PrepOther) Animate (GSg Neut)))  
                         ++ td (a.s ! Posit ! (AF (Prepos PrepOther) Animate (GSg Fem)))
                         ++ td (a.s ! Posit ! (AF Inst Animate GPl))) ++
         tr (intagAttr "th" "rowspan=\"6\"" "Сравнительная" ++
               intagAttr "th" "colspan=\"2\"" "Им."
                         ++ td (a.s ! Compar ! (AF Nom Animate (GSg Masc)))
                         ++ td (a.s ! Compar ! (AF Nom Animate (GSg Neut)))  
                         ++ td (a.s ! Compar ! (AF Nom Animate (GSg Fem)))
                         ++ td (a.s ! Compar ! (AF Nom Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Р."
                         ++ td (a.s ! Compar ! (AF Gen Animate (GSg Masc)))
                         ++ td (a.s ! Compar ! (AF Gen Animate (GSg Neut)))  
                         ++ td (a.s ! Compar ! (AF Gen Animate (GSg Fem)))
                         ++ td (a.s ! Compar ! (AF Gen Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Д."
                         ++ td (a.s ! Compar ! (AF Dat Animate (GSg Masc)))
                         ++ td (a.s ! Compar ! (AF Dat Animate (GSg Neut)))  
                         ++ td (a.s ! Compar ! (AF Dat Animate (GSg Fem)))
                         ++ td (a.s ! Compar ! (AF Dat Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "В."
                         ++ td (a.s ! Compar ! (AF Acc Animate (GSg Masc)))
                         ++ td (a.s ! Compar ! (AF Acc Animate (GSg Neut)))  
                         ++ td (a.s ! Compar ! (AF Acc Animate (GSg Fem)))
                         ++ td (a.s ! Compar ! (AF Acc Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Тв."
                         ++ td (a.s ! Compar ! (AF Inst Animate (GSg Masc)))
                         ++ td (a.s ! Compar ! (AF Inst Animate (GSg Neut)))  
                         ++ td (a.s ! Compar ! (AF Inst Animate (GSg Fem)))
                         ++ td (a.s ! Compar ! (AF Inst Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Пр."
                         ++ td (a.s ! Compar ! (AF (Prepos PrepOther) Animate (GSg Masc)))
                         ++ td (a.s ! Compar ! (AF (Prepos PrepOther) Animate (GSg Neut))) 
                         ++ td (a.s ! Compar ! (AF (Prepos PrepOther) Animate (GSg Fem)))
                         ++ td (a.s ! Compar ! (AF (Prepos PrepOther) Animate GPl))) ++
 tr (intagAttr "th" "rowspan=\"7\"" "Превосходная" ++
       intagAttr "th" "colspan=\"2\"" "Им."
                         ++ td (a.s ! Superl ! (AF Nom Animate (GSg Masc)))
                         ++ td (a.s ! Superl ! (AF Nom Animate (GSg Neut))) 
                         ++ td (a.s ! Superl ! (AF Nom Animate (GSg Fem)))
                         ++ td (a.s ! Superl ! (AF Nom Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Р."
                         ++ td (a.s ! Superl ! (AF Gen Animate (GSg Masc)))
                         ++ td (a.s ! Superl ! (AF Gen Animate (GSg Neut)))  
                         ++ td (a.s ! Superl ! (AF Gen Animate (GSg Fem)))
                         ++ td (a.s ! Superl ! (AF Gen Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Д."
                         ++ td (a.s ! Superl ! (AF Dat Animate (GSg Masc)))
                         ++ td (a.s ! Superl ! (AF Dat Animate (GSg Neut)))  
                         ++ td (a.s ! Superl ! (AF Dat Animate (GSg Fem)))
                         ++ td (a.s ! Superl ! (AF Dat Animate GPl))) ++
        tr (intagAttr "th" "rowspan=\"2\"" "В."
                         ++ th "одушевленное"
                         ++ td (a.s ! Superl ! (AF Acc Animate (GSg Masc)))
                         ++ intagAttr "td" "rowspan=\"2\"" (a.s ! Posit ! (AF Acc Animate (GSg Neut)))  
                         ++ intagAttr "td" "rowspan=\"2\"" (a.s ! Posit ! (AF Acc Animate (GSg Fem)))
                         ++ td (a.s ! Superl ! (AF Acc Animate GPl))) ++
        tr (                th "неодушевленное"

                         ++ td (a.s ! Superl ! (AF Acc Inanimate (GSg Masc)))
                         ++ td (a.s ! Superl ! (AF Acc Inanimate GPl))) ++


        tr (intagAttr "th" "colspan=\"2\"" "Тв."     ++ td (a.s ! Superl ! (AF Inst Animate (GSg Masc)))
                         ++ td (a.s ! Superl ! (AF Inst Animate (GSg Neut)))  
                         ++ td (a.s ! Superl ! (AF Inst Animate (GSg Fem)))
                         ++ td (a.s ! Superl ! (AF Inst Animate GPl))) ++
        tr (intagAttr "th" "colspan=\"2\"" "Пр."     ++ td (a.s ! Superl ! (AF (Prepos PrepOther) Animate (GSg Masc)))
                         ++ td (a.s ! Superl ! (AF (Prepos PrepOther) Animate (GSg Neut)))  
                         ++ td (a.s ! Superl ! (AF (Prepos PrepOther) Animate (GSg Fem)))
                         ++ td (a.s ! Superl ! (AF (Prepos PrepOther) Animate GPl))) ++
        
     tr (intagAttr "th" "rowspan=\"6\"" "Краткая" ++
              intagAttr "th" "colspan=\"2\"" ""   ++ td (a.s ! Posit ! (AFShort (GSg Masc)))
                         ++ td (a.s ! Posit ! (AFShort (GSg Neut))) 
                         ++ td (a.s ! Posit ! (AFShort (GSg Fem)))
           ++ td (a.s ! Posit ! (AFShort GPl)))
      );
    s3= ""
  } ;


  
  InflectionV,   
  InflectionV2, 
  InflectionVV,
  InflectionVS,
  InflectionVQ,
  InflectionVA,
  InflectionV3,
  InflectionV2V,
  InflectionV2S,
  InflectionV2Q,
  InflectionV2A = \v -> {
    t = "гл" ;
    s1 = heading1 ("Глагол" ++
                     case v.asp of {
                      Imperfective => "совершенный" ;
                      Perfective => "несовершенный" 
                     }) ;
    s2 = frameTable (
      tr(intagAttr "th" "rowspan=\"2\"" "Залог" ++
         intagAttr "th" "rowspan=\"2\"" "Время" ++
         intagAttr "th" "rowspan=\"2\"" "Лицо"  ++
         intagAttr "th" "colspan=\"3\"" "ед. ч." ++
         intagAttr "th" "rowspan=\"2\"" "мн. ч." ) ++
      tr(th "муж. р." ++ th "ср. р." ++ th "жен. р.") ++
      tr(intagAttr "th" "rowspan=\"7\"" "Действительный" ++
         intagAttr "th" "rowspan=\"3\"" "Настоящее" ++
         th "Первое" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) (VPresent P1))) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) (VPresent P1))) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  (VPresent P1))) ++
         td (v.s ! VFORM Act (VIND GPl        (VPresent P1)))) ++
      tr(th "Второе" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) (VPresent P2))) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) (VPresent P2))) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  (VPresent P2))) ++
         td (v.s ! VFORM Act (VIND GPl        (VPresent P2)))) ++
      tr(th "Третье" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) (VPresent P3))) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) (VPresent P3))) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  (VPresent P3))) ++
         td (v.s ! VFORM Act (VIND GPl        (VPresent P3)))) ++
      tr(intagAttr "th" "rowspan=\"1\"" "Прошедшее" ++
         th "" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) VPast)) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) VPast)) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  VPast)) ++ 
         td (v.s ! VFORM Act (VIND GPl        VPast))) ++
      tr(intagAttr "th" "rowspan=\"3\"" "Будущее" ++
         th "Первое" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) (VFuture P1))) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) (VFuture P1))) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  (VFuture P1))) ++
         td (v.s ! VFORM Act (VIND GPl        (VFuture P1)))) ++
      tr(th "Второе" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) (VFuture P2))) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) (VFuture P2))) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  (VFuture P2))) ++
         td (v.s ! VFORM Act (VIND GPl        (VFuture P2)))) ++
      tr(th "Третье" ++
         td (v.s ! VFORM Act (VIND (GSg Masc) (VFuture P3))) ++
         td (v.s ! VFORM Act (VIND (GSg Neut) (VFuture P3))) ++
         td (v.s ! VFORM Act (VIND (GSg Fem)  (VFuture P3))) ++
         td (v.s ! VFORM Act (VIND GPl        (VFuture P3)))) ++
      tr(intagAttr "th" "rowspan=\"7\"" "Страдательны" ++
         intagAttr "th" "rowspan=\"3\"" "Настоящее" ++
         th "Первое" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) (VPresent P1))) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) (VPresent P1))) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  (VPresent P1))) ++
         td (v.s ! VFORM Pass (VIND GPl        (VPresent P1)))) ++
      tr(th "Второе" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) (VPresent P2))) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) (VPresent P2))) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  (VPresent P2))) ++
         td (v.s ! VFORM Pass (VIND GPl        (VPresent P2)))) ++
      tr(th "Третье" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) (VPresent P3))) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) (VPresent P3))) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  (VPresent P3))) ++
         td (v.s ! VFORM Pass (VIND GPl        (VPresent P3)))) ++
      tr(intagAttr "th" "rowspan=\"1\"" "Прошедшее" ++
         th "" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) VPast)) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) VPast)) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  VPast)) ++
         td (v.s ! VFORM Pass (VIND GPl        VPast))) ++
      tr(intagAttr "th" "rowspan=\"3\"" "Будущее" ++
         th "Первое" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) (VFuture P1))) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) (VFuture P1))) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  (VFuture P1))) ++
         td (v.s ! VFORM Pass (VIND GPl        (VFuture P1)))) ++
      tr(th "Второе" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) (VFuture P2))) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) (VFuture P2))) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  (VFuture P2))) ++
         td (v.s ! VFORM Pass (VIND GPl        (VFuture P2)))) ++
      tr(th "Третье" ++
         td (v.s ! VFORM Pass (VIND (GSg Masc) (VFuture P3))) ++
         td (v.s ! VFORM Pass (VIND (GSg Neut) (VFuture P3))) ++
         td (v.s ! VFORM Pass (VIND (GSg Fem)  (VFuture P3))) ++
         td (v.s ! VFORM Pass (VIND GPl        (VFuture P3))))

      ) ;
    s3 = "" ;

  } ;    


  InflectionAdv = \adv -> {
    t = "нар" ;
    s1= heading1 ("Наречие") ;
    s2= paragraph (adv.s) ;
    s3= ""
    } ;

  InflectionPrep = \prep -> {
    t = "пр" ;
    s1= heading1 ("Предлог") ;
    s2= paragraph (prep.s) ;
    s3= ""
    } ;


lin
  MkDocument d i e = {s = i.s1 ++ d.s ++ i.s2 ++ i.s3 ++ e.s} ;
  MkTag i = {s = i.t} ;

  NoDefinition   t     = {s=t.s};
  MkDefinition   t d   = {s="<p><b>Определение:</b>"++t.s++d.s++"</p>"};
  MkDefinitionEx t d e = {s="<p><b>Определение:</b>"++t.s++d.s++"</p><p><b>Пример:</b>"++e.s++"</p>"};

} 
