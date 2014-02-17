--# -path=.:../abstract:../common

-- generic documentation: varying the Terminology interface gives documentation of Swe in different languages

incomplete concrete DocumentationSweFunctor of Documentation = CatSwe ** open 
  Terminology,  -- as interface
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
  Inflection = {s : Str} ;
  Document = {s : Str} ;
  
oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;

   nounGender : CatSwe.N -> Parameter = \n -> case n.g of {
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

  InflectionV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V v))) v ;
  InflectionV2 v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2 v) S.something_NP)) (lin V v) ;
  InflectionVV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) (lin V v) ;
  InflectionV2V v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) (lin V v) ;

  InflectionPrep p = {
    s = heading1 (heading preposition_Category) ++
        paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" (S.mkAdv (lin Prep p) (S.mkNP S.a_Det L.computer_N)).s)
    } ;

  MkDocument b i e = ss (paragraph e.s ++ i.s ++ paragraph e.s) ;  -- explanation appended in a new paragraph

oper 
  verbExample : Cl -> Str = \cl ->
     (S.mkUtt cl).s 
     ++ ";" ++ (S.mkUtt (S.mkS S.anteriorAnt cl)).s  --# notpresent
     ;

  inflectionVerb : Str -> CatSwe.V -> {s : Str} = \ex,verb -> 
     let 
       vfin : VForm -> Str = \f ->
         verb.s ! f ; 
       gforms : Voice -> Str = \v -> 
            tdf (vfin (VI (VInfin v))) 
         ++ tdf (vfin (VF (VPres v))) 
         ++ tdf (vfin (VF (VPret v)))  --# notpresent
         ++ tdf (vfin (VI (VSupin v)))  --# notpresent
         ++ tdf (vfin (VF (VImper v))) 
         ;
     in {
     s =
      heading1 (heading verb_Category) ++  
       paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" ex) ++
       paragraph (frameTable (
       tr (th "" ++ th (heading infinitive_Parameter) ++ th (heading present_Parameter)  ++  
                    th (heading past_Parameter) ++ th (heading supine_Parameter) ++ th (heading imperative_Parameter)) ++  
       tr (th (heading active_Parameter)  ++ gforms Act) ++
       tr (th (heading passive_Parameter) ++ gforms Pass)
       )) ++
       paragraph (
       frameTable (
       tr (th (heading present_Parameter ++ heading participle_Parameter) ++ tdf (verb.s ! (VI (VPtPres Sg Indef Nom)))) ++
       tr (th (heading perfect_Parameter ++ heading participle_Parameter) ++ tdf (verb.s ! (VI (VPtPret (Strong (GSg Utr)) Nom))))
       ))
     } ;

}
