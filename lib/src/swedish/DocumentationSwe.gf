--# -path=.:../abstract:../common

concrete DocumentationSwe of Documentation = CatSwe ** open 
  ResSwe,
  CommonScand,
  ParadigmsSwe,
  (G = GrammarSwe),
  (S = SyntaxSwe),
  (L = LexiconSwe),
  Prelude,
  HTML
in {


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  Inflection = {s : Str} ; 
  

lin
  noun_Category = mkN "substantiv" ;
  adjective_Category = mkN "adjektiv" ;
  verb_Category = mkN "verb" ;
  preposition_Category = mkN "preposition" ;

  gender_ParameterType = mkN "genus" ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  definite_Parameter = mkN "bestämd" ;
  indefinite_Parameter = mkN "obestämd" ;

  masculine_Parameter = mkN "maskulin" ;
  feminine_Parameter = mkN "feminin" ;
  neuter_Parameter = mkN "neutrum" ;
  uter_Parameter = mkN "utrum" ;

  nominative_Parameter = mkN "nominativ" ;
  genitive_Parameter = mkN "genitiv" ;
  dative_Parameter = mkN "dativ" ;
  accusative_Parameter = mkN "akkusativ" ;
  
  imperative_Parameter = mkN "imperativ" ;
  indicative_Parameter = mkN "indikativ" ;
  conjunctive_Parameter = mkN "konjunktiv" ;
  infinitive_Parameter = mkN "infinitiv" ;

  present_Parameter = mkN "presens" ;
  past_Parameter = mkN "preteritum" ;
  future_Parameter = mkN "futur" ;
  conditional_Parameter = mkN "konditionalis" ;
  perfect_Parameter = mkN "perfekt" ;

  participle_Parameter = mkN "partisip" ;
  aux_verb_Parameter = mkN "hjälpverb" ;

  positive_Parameter = mkN "positiv" ;
  comparative_Parameter = mkN "komparativ" ;
  superlative_Parameter = mkN "superlativ" ;
  predicative_Parameter = mkN "predikativ" ;

  nounHeading n = ss (n.s ! Sg ! Indef ! Nom) ;

oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;

   nounGender : N -> Parameter = \n -> case n.g of {
     Utr   => uter_Parameter ; 
     Neutr => neuter_Parameter
     } ;

lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++ 
        paragraph (intag "b" (heading (gender_ParameterType)) ++ ":" ++ heading (nounGender noun) ++ ";" ++
                   intag "i" (S.mkUtt (S.mkNP S.a_Det noun)).s) ++
        frameTable ( 
          tr (intagAttr "th" "colspan=2" ""       ++ th (heading singular_Parameter) ++ th (heading plural_Parameter)   ) ++
          tr (intagAttr "th" "rowspan=2" (heading nominative_Parameter) ++ 
              th (heading indefinite_Parameter) ++   tdf (noun.s ! Sg ! Indef ! Nom) ++ tdf (noun.s ! Pl ! Indef ! Nom)) ++
          tr (th (heading   definite_Parameter) ++   tdf (noun.s ! Sg ! Def   ! Nom) ++ tdf (noun.s ! Pl ! Def   ! Nom)) ++
          tr (intagAttr "th" "rowspan=2" (heading genitive_Parameter) ++ 
              th (heading indefinite_Parameter) ++   tdf (noun.s ! Sg ! Indef ! Gen) ++ tdf (noun.s ! Pl ! Indef ! Gen)) ++
          tr (th (heading   definite_Parameter) ++   tdf (noun.s ! Sg ! Def   ! Gen) ++ tdf (noun.s ! Pl ! Def   ! Gen))
          )
     } ;

  InflectionA adj = 
    let
      gforms : Case -> Str = \c ->
        tdf (adj.s ! (AF (APosit (Strong (GSg Utr))) c)) ++
        tdf (adj.s ! (AF (APosit (Strong (GSg Neutr))) c)) ++
        tdf (adj.s ! (AF (APosit (Strong GPl)) c)) ++
        tdf (adj.s ! (AF (APosit (Weak Sg)) c)) ;
    in
       {
         s = heading1 (nounHeading adjective_Category).s ++ 
          frameTable ( 
            tr (intagAttr "th" "colspan=2" [] ++ 
                          th (heading uter_Parameter)   ++ th (heading neuter_Parameter) ++ 
                          th (heading plural_Parameter) ++ th (heading definite_Parameter)) ++
            tr (intagAttr "th" "rowspan=2" (heading positive_Parameter) ++ 
                   th (heading nominative_Parameter) ++ gforms Nom) ++
            tr (   th (heading genitive_Parameter)   ++ gforms Gen) ++
            tr (intagAttr "th" "rowspan=2" (heading comparative_Parameter) ++ 
                   th (heading nominative_Parameter) ++ intagAttr "td" "colspan=4" (intag "i" (adj.s ! AF ACompar Nom))) ++
            tr (   th (heading genitive_Parameter)   ++ intagAttr "td" "colspan=4" (intag "i" (adj.s ! AF ACompar Gen))) ++
            tr (intagAttr "th" "rowspan=2" (heading superlative_Parameter) ++ 
                   th (heading nominative_Parameter) ++ 
                      intagAttr "td" "colspan=3" (intag "i" (adj.s ! AF (ASuperl SupStrong) Nom)) ++
                      tdf (adj.s ! AF (ASuperl SupWeak) Nom)) ++
            tr (   th (heading genitive_Parameter) ++ 
                      intagAttr "td" "colspan=3" (intag "i" (adj.s ! AF (ASuperl SupStrong) Gen)) ++
                      tdf (adj.s ! AF (ASuperl SupWeak) Gen))
            )

        } ;

{-
  InflectionV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V v))) v ;
  InflectionV2 v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2 v) S.something_NP)) (lin V v) ;
  InflectionVV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) (lin V v) ;
  InflectionV2V v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) (lin V v) ;

  InflectionPrep p = {
    s = heading1 (heading preposition_Category) ++
        paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" (S.mkAdv (lin Prep p) (S.mkNP S.a_Det L.computer_N)).s)
    } ;

  ExplainInflection e i = ss (i.s ++ paragraph e.s) ;  -- explanation appended in a new paragraph

oper 
  verbExample : Cl -> Str = \cl ->
     (S.mkUtt cl).s 
     ++ ";" ++ (S.mkUtt (S.mkS S.anteriorAnt cl)).s  --# notpresent
     ;

  inflectionVerb : Str -> V -> {s : Str} = \ex,verb -> 
     let 
       vfin : VForm -> Str = \f ->
         verb.s ! f ++ verb.prefix ; 
       gforms : Number -> Person -> Str = \n,p -> 
         tdf (vfin (VFin False (VPresInd  n p))) ++
         tdf (vfin (VFin False (VPresSubj n p)))
         ++ tdf (vfin (VFin False (VImpfInd  n p))) --# notpresent
         ++ tdf (vfin (VFin False (VImpfSubj n p)))  --# notpresent
         ;
     in {
     s =
      heading1 (heading verb_Category) ++  
       paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" ex) ++
       paragraph (frameTable (
       tr (th "" ++ intagAttr "th" "colspan=2" (heading present_Parameter) ++  intagAttr "th" "colspan=2" (heading past_Parameter)) ++  
       tr (th "" ++ th (heading indicative_Parameter) ++ th (heading conjunctive_Parameter ++ "I")  ++  
                    th (heading indicative_Parameter) ++ th (heading conjunctive_Parameter ++ "II"))  ++  
       tr (th "Sg.1"  ++ gforms Sg P1) ++
       tr (th "Sg.2"  ++ gforms Sg P2) ++
       tr (th "Sg.3"  ++ gforms Sg P3) ++
       tr (th "Pl.1"  ++ gforms Pl P1) ++
       tr (th "Pl.2"  ++ gforms Pl P2) ++
       tr (th "Pl.3"  ++ gforms Pl P3)
       )) ++
       paragraph (
       frameTable (
       tr (th (heading imperative_Parameter ++ "Sg.2")  ++ tdf (vfin (VImper Sg))) ++
       tr (th (heading imperative_Parameter ++ "Pl.2")  ++ tdf (vfin (VImper Pl))) ++
       tr (th (heading infinitive_Parameter)            ++ tdf (verb.s ! (VInf False))) ++
       tr (th (heading present_Parameter ++ heading participle_Parameter) ++ tdf (verb.s ! (VPresPart APred))) ++
       tr (th (heading perfect_Parameter ++ heading participle_Parameter) ++ tdf (verb.s ! (VPastPart APred))) ++
       tr (th (heading aux_verb_Parameter)       ++ td (intag "i" (case verb.aux of {VHaben => "haben" ; VSein => "sein"})))
       ))
     } ;

-}

  lin
    exampleGr_N = mkN "exempel" "exempel" ;

}