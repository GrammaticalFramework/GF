--# -path=.:../abstract:../common
concrete DocumentationBul of Documentation = CatBul ** open 
  ResBul,
  HTML in {
flags coding=utf8 ;

lincat
  Inflection = {t : Str; s1,s2,s3 : Str} ;
  Document   = {s : Str} ;
  Tag        = {s : Str} ;

lin
  InflectionN n = {
    t = "същ" ;
    s1= heading1 ("Съществително"++
                  case n.g of {
                    AMasc Human    => "(м.р.л.)" ;
                    AMasc NonHuman => "(м.р.)" ;
                    AFem           => "(ж.р.)" ;
                    ANeut          => "(ср.р.)"
                  }) ;
    s2= frameTable (
          tr (intagAttr "th" "rowspan=\"3\"" "ед.ч." ++ 
              th "нечленувано" ++ td (n.s ! (NF Sg Indef))) ++
          tr (th "членувано" ++ td (n.s ! (NF Sg Def))) ++
          tr (th "пълен член" ++ td (n.s ! NFSgDefNom)) ++
          tr (intagAttr "th" "rowspan=\"2\"" "мн.ч." ++ 
              th "нечленувано" ++ td (n.s ! (NF Pl Indef))) ++
          tr (th "членувано" ++ td (n.s ! (NF Pl Def))) ++
          tr (intagAttr "th" "colspan=\"2\"" "звателна форма" ++ td (n.s ! NFVocative)) ++
          tr (intagAttr "th" "colspan=\"2\"" "бройна форма" ++ td (n.s ! NFPlCount))
        ) ;
    s3= heading1 ("Прилагателно") ++
        frameTable (
          tr (intagAttr "th" "rowspan=\"7\"" "ед.ч." ++ 
              intagAttr "th" "rowspan=\"3\"" "мн.ч." ++ 
              th "нечленувано" ++ 
              td (n.rel ! (ASg Masc Indef))) ++
          tr (th "непълен член" ++ td (n.rel ! (ASg Masc Def))) ++
          tr (th "пълен член" ++ td (n.rel ! ASgMascDefNom)) ++
          tr (intagAttr "th" "rowspan=\"2\"" "ж.р." ++
              th "нечленувано" ++ td (n.rel ! (ASg Fem Indef))) ++
          tr (th "членувано" ++ td (n.rel ! (ASg Fem Def))) ++
          tr (intagAttr "th" "rowspan=\"2\"" "ср.р." ++
              th "нечленувано" ++ td (n.rel ! (ASg Neut Indef))) ++
          tr (th "членувано" ++ td (n.rel ! (ASg Neut Def))) ++
          tr (intagAttr "th" "colspan=\"2\" rowspan=\"2\"" "мн.ч." ++
              th "нечленувано" ++ td (n.rel ! (APl Indef))) ++
          tr (th "членувано" ++ td (n.rel ! (APl Def)))
        )
  } ;

  InflectionN2,InflectionN3 = \n -> {
    t = "същ" ;
    s1= heading1 ("Съществително "++
                  case n.g of {
                    AMasc Human    => "(м.р.л.)" ;
                    AMasc NonHuman => "(м.р.)" ;
                    AFem           => "(ж.р.)" ;
                    ANeut          => "(ср.р.)"
                  }) ;
    s2= frameTable (
          tr (intagAttr "th" "rowspan=\"3\"" "ед.ч." ++ 
              th "нечленувано" ++ td (n.s ! (NF Sg Indef))) ++
          tr (th "членувано" ++ td (n.s ! (NF Sg Def))) ++
          tr (th "пълен член" ++ td (n.s ! NFSgDefNom)) ++
          tr (intagAttr "th" "rowspan=\"2\"" "мн.ч." ++ 
              th "нечленувано" ++ td (n.s ! (NF Pl Indef))) ++
          tr (th "членувано" ++ td (n.s ! (NF Pl Def))) ++
          tr (intagAttr "th" "colspan=\"2\"" "звателна форма" ++ td (n.s ! NFVocative)) ++
          tr (intagAttr "th" "colspan=\"2\"" "бройна форма" ++ td (n.s ! NFPlCount))
        ) ;
    s3 = ""
    } ;

  InflectionA, InflectionA2 = \a -> {
    t = "пр" ;
    s1= heading1 ("Прилагателно") ;
    s2= frameTable (
          tr (intagAttr "th" "rowspan=\"7\"" "ед.ч." ++ 
              intagAttr "th" "rowspan=\"3\"" "мн.ч." ++ 
              th "нечленувано" ++ 
              td (a.s ! (ASg Masc Indef))) ++
          tr (th "непълен член" ++ td (a.s ! (ASg Masc Def))) ++
          tr (th "пълен член" ++ td (a.s ! ASgMascDefNom)) ++
          tr (intagAttr "th" "rowspan=\"2\"" "ж.р." ++
              th "нечленувано" ++ td (a.s ! (ASg Fem Indef))) ++
          tr (th "членувано" ++ td (a.s ! (ASg Fem Def))) ++
          tr (intagAttr "th" "rowspan=\"2\"" "ср.р." ++
              th "нечленувано" ++ td (a.s ! (ASg Neut Indef))) ++
          tr (th "членувано" ++ td (a.s ! (ASg Neut Def))) ++
          tr (intagAttr "th" "colspan=\"2\" rowspan=\"2\"" "мн.ч." ++
              th "нечленувано" ++ td (a.s ! (APl Indef))) ++
          tr (th "членувано" ++ td (a.s ! (APl Def)))
        ) ++
        heading1 ("Наречие") ++
        paragraph (a.s ! (ASg Neut Indef)) ;
    s3= ""
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

  InflectionV v = {
    t = "гл" ;
    s1= heading1 ("Глагол") ++
        pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++ v.s ! Imperf ! VPres Sg P3 ;
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionV2 v = {
    t = "гл" ;
    s1= heading1 ("Глагол") ++
        pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        v.c2.s ++
        pp "допълнение";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionV3 v = {
    t = "гл" ;
    s1= heading1 ("Глагол") ++
        pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        v.c2.s ++
        pp "арг1"++
        v.c3.s ++
        pp "арг2";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionV2V v = {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        v.c2.s ++
        pp "допълнение"++
        v.c3.s ++
        "да" ++ pp "глагол";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionV2S v = {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        v.c2.s ++
        pp "допълнение"++
        v.c3.s ++
        "че" ++ pp "изречение";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionV2Q v = {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        v.c2.s ++
        pp "допълнение"++
        v.c3.s ++
        pp "въпрос";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionV2A v = {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        v.c2.s ++
        pp "допълнение"++
        pp "прилагателно";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionVV = \v -> {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        case v.typ of {
          VVInf => "да" ++ pp "глагол";
          VVGerund => pp "деепричастие"
        };
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionVS = \v -> {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        "че" ++ pp "изречение";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionVQ = \v -> {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        pp "въпрос";
    s2= inflVerb v ;
    s3= ""
  } ;

  InflectionVA = \v -> {
    t = "гл" ;
    s1= pp "подлог" ++
        case v.vtype of {
          VNormal => "" ;
          VMedial c => reflClitics ! c ;
          VPhrasal c => personalClitics ! c ! GSg Masc ! P3
        } ++
        v.s ! Imperf ! VPres Sg P3 ++
        pp "прилагателно";
    s2= inflVerb v ;
    s3= ""
  } ;

oper
  inflVerb : Verb -> Str = \v ->
    (heading2 ("Несвършен вид") ++
     heading3 ("Изявително наклонение") ++
     heading4 ("Сегашно време") ++
     finite Imperf VPres ++
     heading4 ("Минало свършено време (аорист)") ++
     finite Imperf VAorist ++
     heading4 ("Минало несвършено време (имперфект)") ++
     finite Imperf VImperfect ++
     heading3 ("Повелително наклонение") ++
     imperative Imperf ++
     heading3 ("Причастия (отглаголни прилагателни)") ++
     heading4 ("Минало страдателно причастие") ++
     participle Imperf VPassive ++
     heading4 ("Минало свършено деятелно причастие") ++
     participle Imperf VPerfect ++
     heading4 ("Минало несвършено деятелно причастие") ++
     participle Imperf VPluPerfect ++
     heading4 ("Сегашно деятелно причастие") ++
     participle Imperf VPresPart ++
     heading2 ("Свършен вид") ++
     heading3 ("Изявително наклонение") ++
     heading4 ("Сегашно време") ++
     finite Perf VPres ++
     heading4 ("Минало свършено време (аорист)") ++
     finite Perf VAorist ++
     heading4 ("Минало несвършено време (имперфект)") ++
     finite Perf VImperfect ++
     heading3 ("Повелително наклонение") ++
     imperative Perf ++
     heading3 ("Причастия (отглаголни прилагателни)") ++
     heading4 ("Минало страдателно причастие") ++
     participle Perf VPassive ++
     heading4 ("Минало свършено деятелно причастие") ++
     participle Perf VPerfect ++
     heading4 ("Минало несвършено деятелно причастие") ++
     participle Perf VPluPerfect ++
     heading1 ("Отглаголно съществително") ++
     frameTable (
       tr (intagAttr "th" "rowspan=\"2\"" "ед.ч." ++ 
           th "нечленувано" ++ td (v.s ! Imperf ! VNoun (NF Sg Indef))) ++
       tr (th "членувано" ++ td (v.s ! Imperf ! VNoun (NF Sg Def))) ++
       tr (intagAttr "th" "rowspan=\"2\"" "мн.ч." ++ 
           th "нечленувано" ++ td (v.s ! Imperf ! VNoun (NF Pl Indef))) ++
       tr (th "членувано" ++ td (v.s ! Imperf ! VNoun (NF Pl Def)))
     ) ++
     heading1 ("Деепричастие (отглаголно наречие)") ++
     paragraph (v.s ! Imperf ! VGerund))
  where {
    finite : Aspect -> (Number -> Person -> VForm) -> Str = \aspect,f ->
      frameTable (
        tr (th "" ++
            th "ед.ч." ++
            th "мн.ч.") ++
        tr (th "1 л." ++ 
            td (v.s ! aspect ! f Sg P1) ++ 
            td (v.s ! aspect ! f Pl P1)) ++
        tr (th "2 л." ++ 
            td (v.s ! aspect ! f Sg P2) ++
            td (v.s ! aspect ! f Pl P2)) ++
        tr (th "3 л." ++
            td (v.s ! aspect ! f Sg P3) ++
            td (v.s ! aspect ! f Pl P3))
      ) ;

    imperative : Aspect -> Str = \aspect ->
      frameTable (
        tr (th "ед.ч." ++
            th "мн.ч.") ++
        tr (td (v.s ! aspect ! VImperative Sg) ++ 
            td (v.s ! aspect ! VImperative Pl))
      ) ;

    participle : Aspect -> (AForm -> VForm) -> Str = \aspect,f ->
      frameTable (
        tr (intagAttr "th" "rowspan=\"7\"" "ед.ч." ++
            intagAttr "th" "rowspan=\"3\"" "м.р." ++
            th "нечленувано" ++
            td (v.s ! aspect ! f (ASg Masc Indef))) ++
        tr (th "непълен член" ++
            td (v.s ! aspect ! f (ASg Masc Def))) ++
        tr (th "пълен член" ++
            td (v.s ! aspect ! f ASgMascDefNom)) ++
        tr (intagAttr "th" "rowspan=\"2\"" "ж.р." ++
            th "нечленувано" ++
            td (v.s ! aspect ! f (ASg Fem Indef))) ++
        tr (th "членувано" ++
            td (v.s ! aspect ! f (ASg Fem Def))) ++
        tr (intagAttr "th" "rowspan=\"2\"" "ср.р." ++
            th "нечленувано" ++
            td (v.s ! aspect ! f (ASg Neut Indef))) ++
        tr (th "членувано" ++
            td (v.s ! aspect ! f (ASg Neut Def))) ++
        tr (intagAttr "th" "rowspan=\"2\" colspan=\"2\"" "мн.ч." ++
            th "нечленувано" ++
            td (v.s ! aspect ! f (APl Indef))) ++
        tr (th "членувано" ++
            td (v.s ! aspect ! f (APl Def)))
      ) ;
  } ;

  pp : Str -> Str = \s -> "&lt;"+s+"&gt;";

lin
  MkDocument b i e = {s = i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ i.s3 ++ e.s} ;
  MkTag i = {s = i.t} ;

}
