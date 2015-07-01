concrete DocumentationSwe of Documentation = CatSwe ** open
  ResSwe,
  CommonScand,
  HTML
in {
flags coding=utf8 ;
lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

{-
-} --# notpresent


lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "s" ;
    s1 = heading1 ("Substantiv" ++ case noun.g of {
                                     Utr   => "(utr)" ;
                                     Neutr => "(neutr)"
                                   }) ;
    s2 = frameTable (
           tr (intagAttr "th" "colspan=2" "" ++ th "obest" ++ th "best") ++
           tr (intagAttr "th" "rowspan=2" "nom" ++ 
               th "sg" ++ td (noun.s ! Sg ! Indef ! Nom) ++ td (noun.s ! Sg ! Def ! Nom)) ++
           tr (th "pl" ++ td (noun.s ! Pl ! Indef ! Nom) ++ td (noun.s ! Pl ! Def ! Nom)) ++
           tr (intagAttr "th" "rowspan=2" "gen" ++ 
               th "sg" ++ td (noun.s ! Sg ! Indef ! Gen) ++ td (noun.s ! Sg ! Def ! Gen)) ++
           tr (th "pl" ++ td (noun.s ! Pl ! Indef ! Gen) ++ td (noun.s ! Pl ! Def ! Gen))
           )
     } ;

  InflectionA, InflectionA2 = \adj -> { 
    t  = "a" ;
    s1 = heading1 "Adjektiv" ;
    s2 = frameTable ( 
           tr (intagAttr "th" "colspan=5" "nominativ") ++
           tr (intagAttr "th" "colspan=2" "posit" ++
               th "posit" ++
               th "kompar" ++
               th "superl") ++
           caseInfl Nom ++
           tr (intagAttr "th" "colspan=5" "genitiv") ++
           caseInfl Nom
         )
    } where {
        caseInfl : Case -> Str = \c ->
          tr (intagAttr "th" "rowspan=3" "obest" ++
              th "utr" ++
              td (adj.s ! (AF (APosit (Strong (GSg Utr))) c)) ++
              intagAttr "td" "rowspan=5" (adj.s ! (AF ACompar c)) ++
              intagAttr "td" "rowspan=3" (adj.s ! (AF (ASuperl SupStrong) c))) ++
          tr (th "neut" ++
              td (adj.s ! (AF (APosit (Strong (GSg Neutr))) c))) ++
          tr (th "pl" ++
              td (adj.s ! (AF (APosit (Strong GPl)) c))) ++
          tr (intagAttr "th" "rowspan=2" "best" ++
              th "sg" ++
              td (adj.s ! (AF (APosit (Weak Sg)) c)) ++
              intagAttr "td" "rowspan=2" (adj.s ! (AF (ASuperl SupWeak) c))) ++
          tr (th "pl" ++
              td (adj.s ! (AF (APosit (Weak Pl)) c))) ;
    } ;

  InflectionAdv adv = {
    t  = "adv" ;
    s1 = heading1 "Adverb" ;
    s2 = paragraph adv.s
    } ;

  InflectionPrep p = {
    t  = "prep" ;
    s1 = heading1 "Preposition" ;
    s2 = paragraph p.s
    } ;

  InflectionV v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part);
    s2 = inflVerb v
    } ;

  InflectionV2 v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++ v.c2.s ++
                    pp "objekt") ;
    s2 = inflVerb v
    } ;

  InflectionV3 v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    v.c2.s ++ pp "arg1" ++
                    v.c3.s ++ pp "arg2") ;
    s2 = inflVerb v
    } ;

  InflectionV2V v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    v.c2.s ++ pp "objekt" ++
                    v.c3.s ++ pp "verb") ;
    s2 = inflVerb v
    } ;

  InflectionV2S v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    v.c2.s ++ pp "objekt" ++
                    conjThat ++ pp "mening") ;
    s2 = inflVerb v
    } ;

  InflectionV2Q v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    v.c2.s ++ pp "objekt" ++
                    pp "fråga") ;
    s2 = inflVerb v
    } ;

  InflectionV2A v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    v.c2.s ++ pp "objekt" ++
                    pp "adjektiv") ;
    s2 = inflVerb v
    } ;

  InflectionVV v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    pp "verb") ;
    s2 = inflVerb v
    } ;

  InflectionVS v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    conjThat ++ pp "mening") ;
    s2 = inflVerb v
    } ;

  InflectionVQ v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    pp "fråga") ;
    s2 = inflVerb v
    } ;

  InflectionVA v = {
    t  = "v" ;
    s1 = heading1 "Verb" ++
         paragraph (pp "subjekt" ++
                    v.s ! VI (VInfin Act) ++ v.part ++
                    pp "adjektiv") ;
    s2 = inflVerb v
    } ;

  MkDocument b i e = {s = i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ paragraph e.s} ;  -- explanation appended in a new paragraph
  MkTag i = {s = i.t} ;

oper
  inflVerb : Verb -> Str = \verb ->
    frameTable (
      tr (th "" ++ th "active" ++ th "passive") ++
      tr (th "infitiv" ++ td (verb.s ! VI (VInfin Act)) ++ td (verb.s ! VI (VInfin Pass))) ++
      tr (th "presens" ++ td (verb.s ! VF (VPres Act))  ++ td (verb.s ! VF (VPres Pass))) ++
      tr (th "preteritum" ++ td (verb.s ! VF (VPret Act))  ++ td (verb.s ! VF (VPret Pass))) ++
      tr (th "supinum" ++ td (verb.s ! VI (VSupin Act))  ++ td (verb.s ! VI (VSupin Pass))) ++
      tr (th "imperativ" ++ td (verb.s ! VF (VImper Act))  ++ td (verb.s ! VF (VImper Pass)))
    ) ++
    heading2 "Particip Presens" ++
    frameTable (
      tr (intagAttr "th" "colspan=2" "" ++ th "obest" ++ th "best") ++
      tr (intagAttr "th" "rowspan=2" "nom" ++ 
          th "sg" ++
          td (verb.s ! VI (VPtPres Sg Indef Nom)) ++ 
          td (verb.s ! VI (VPtPres Sg Def Nom))) ++
      tr (th "pl" ++ 
          td (verb.s ! VI (VPtPres Pl Indef Nom)) ++ 
          td (verb.s ! VI (VPtPres Pl Def Nom))) ++
      tr (intagAttr "th" "rowspan=2" "gen" ++ 
          th "sg" ++
          td (verb.s ! VI (VPtPres Sg Indef Gen)) ++ 
          td (verb.s ! VI (VPtPres Sg Def Gen))) ++
      tr (th "pl" ++ 
          td (verb.s ! VI (VPtPres Pl Indef Gen)) ++ 
          td (verb.s ! VI (VPtPres Pl Def Gen)))
    ) ++
    heading2 "Particip Perfekt" ++
    frameTable (
      tr (intagAttr "th" "colspan=2" "" ++ 
          th "nom" ++ 
          th "gen") ++
      tr (intagAttr "th" "rowspan=3" "obest" ++ 
          th "utr" ++ 
          td (verb.s ! VI (VPtPret (Strong (GSg Utr)) Nom)) ++
          td (verb.s ! VI (VPtPret (Strong (GSg Utr)) Gen))) ++
      tr (th "neut" ++ 
          td (verb.s ! VI (VPtPret (Strong (GSg Neutr)) Nom)) ++
          td (verb.s ! VI (VPtPret (Strong (GSg Neutr)) Gen))) ++
      tr (th "pl" ++ 
          td (verb.s ! VI (VPtPret (Strong GPl) Nom)) ++
          td (verb.s ! VI (VPtPret (Strong GPl) Gen))) ++
      tr (intagAttr "th" "rowspan=2" "best" ++
          th "sg" ++ 
          td (verb.s ! VI (VPtPret (Weak Sg) Nom)) ++
          td (verb.s ! VI (VPtPret (Weak Sg) Gen))) ++
      tr (th "pl" ++ 
          td (verb.s ! VI (VPtPret (Weak Pl) Nom)) ++
          td (verb.s ! VI (VPtPret (Weak Pl) Gen)))
    ) ;
    
  pp : Str -> Str = \s -> "&lt;"+s+"&gt;";

{- --# notpresent
-}

}
