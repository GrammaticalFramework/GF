--# -path=.:../abstract:../common

incomplete concrete DocumentationFinFunctor of Documentation = CatFin ** open 
  Terminology, -- the interface
  ResFin,
  StemFin,
  ParadigmsFin,
  (G = GrammarFin),
  (S = SyntaxFin),
  (L = LexiconFin),
  Prelude,
  HTML
in {


lincat
  Inflection = {s : Str} ;
  Document = {s : Str} ;
  
oper
  tdf  : Str -> Str = \s -> td (intag "i" s) ;
  tdf2 : Str -> Str = \s -> intagAttr "td" "rowspan=2" (intag "i" s) ;
  heading : N -> Str = \n -> (nounHeading n).s ;

  inflectionN : (NForm -> Str) -> Str = \nouns -> 
    frameTable ( 
          tr (th ""          ++ th (heading singular_Parameter)            ++ th (heading plural_Parameter)   ) ++
          tr (th (heading nominative_Parameter) ++ tdf (nouns (NCase Sg Nom)) ++ tdf (nouns (NCase Pl Nom))) ++
          tr (th (heading genitive_Parameter) ++ tdf (nouns (NCase Sg Gen)) ++ tdf (nouns (NCase Pl Gen))) ++
          tr (th (heading partitive_Parameter) ++ tdf (nouns (NCase Sg Part)) ++ tdf (nouns (NCase Pl Part))) ++
          tr (th (heading translative_Parameter) ++ tdf (nouns (NCase Sg Transl)) ++ tdf (nouns (NCase Pl Transl))) ++
          tr (th (heading essive_Parameter) ++ tdf (nouns (NCase Sg Ess)) ++ tdf (nouns (NCase Pl Ess))) ++
          tr (th (heading inessive_Parameter) ++ tdf (nouns (NCase Sg Iness)) ++ tdf (nouns (NCase Pl Iness))) ++
          tr (th (heading elative_Parameter) ++ tdf (nouns (NCase Sg Elat)) ++ tdf (nouns (NCase Pl Elat))) ++
          tr (th (heading illative_Parameter) ++ tdf (nouns (NCase Sg Illat)) ++ tdf (nouns (NCase Pl Illat))) ++
          tr (th (heading adessive_Parameter) ++ tdf (nouns (NCase Sg Adess)) ++ tdf (nouns (NCase Pl Adess))) ++
          tr (th (heading ablative_Parameter) ++ tdf (nouns (NCase Sg Ablat)) ++ tdf (nouns (NCase Pl Ablat))) ++
          tr (th (heading allative_Parameter) ++ tdf (nouns (NCase Sg Allat)) ++ tdf (nouns (NCase Pl Allat))) ++
          tr (th (heading abessive_Parameter) ++ tdf (nouns (NCase Sg Abess)) ++ tdf (nouns (NCase Pl Abess))) ++
          tr (th (heading comitative_Parameter)  ++ tdf "" ++ tdf (nouns (NComit))) ++
          tr (th (heading instructive_Parameter) ++ tdf "" ++ tdf (nouns (NInstruct))) 
          ) ;

lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++ 
        inflectionN (\nf -> (snoun2nounSep noun).s ! nf)
    } ;

  InflectionA adj = {
    s = heading1 (heading adjective_Category) ++ 
        inflectionN (\nf -> (snoun2nounSep {s = \\f => adj.s ! Posit  ! sAN f ; h = adj.h}).s ! nf) ++ 
        heading2 (heading comparative_Parameter) ++ 
        inflectionN (\nf -> (snoun2nounSep {s = \\f => adj.s ! Compar ! sAN f ; h = adj.h}).s ! nf) ++ 
        heading2 (heading superlative_Parameter) ++ 
        inflectionN (\nf -> (snoun2nounSep {s = \\f => adj.s ! Superl ! sAN f ; h = adj.h}).s ! nf)
    } ;


  InflectionV v = inflectionVerb [] v ;----(verbExample (S.mkCl S.she_NP (lin V v))) v ;
  InflectionV2 v = inflectionVerb [] v ;----(verbExample (S.mkCl S.she_NP (lin V2 v) S.something_NP)) (lin V v) ;
  InflectionVV v = inflectionVerb [] v ;----(verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) (lin V v) ;
  InflectionV2V v = inflectionVerb [] v ;----(verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) (lin V v) ;

  MkDocument b i e = ss (paragraph b.s ++ i.s ++ paragraph e.s) ;  -- explanation appended in a new paragraph

oper 
  verbExample : CatFin.Cl -> Str = \cl -> (S.mkUtt cl).s ;

  inflectionVerb : Str -> CatFin.V -> {s : Str} = \ex,verb0 -> 
     let 
       verb = sverb2verbSep verb0 ;
       vfin : ResFin.VForm -> Str = \f ->
         verb.s ! f ; 
       gforms : Number -> Person -> Str = \n,p -> 
         tdf (vfin (Presn n p)) 
         ++ tdf (vfin (Impf n p))  --# notpresent
         ++ tdf (vfin (Condit n p)) --# notpresent
         ++ tdf (vfin (Potent n p))  --# notpresent
         ;
     in {
     s =
      heading1 (heading verb_Category) ++  
      paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" ex) ++
      heading2 (nounPluralHeading finite_form_ParameterType).s ++ 
       frameTable (
       tr (intagAttr "th" "rowspan=2 colspan=2" "" ++ 
                    intagAttr "th" "colspan=2" (heading indicative_Parameter) ++ 
                    th (heading conditional_Parameter) ++ th (heading potential_Parameter)  ++  
                    th (heading imperative_Parameter))  ++  
       tr (         th (heading present_Parameter) ++ th (heading past_Parameter) ++  
                    th (heading present_Parameter) ++ th (heading present_Parameter)  ++  
                    th (heading present_Parameter))  ++  
       tr (intagAttr "th" "rowspan=3" (heading singular_Parameter) ++ 
           th "1.p"  ++ gforms Sg P1 ++ tdf "") ++
       tr (th "2.p"  ++ gforms Sg P2 ++ tdf (vfin (Imper Sg))) ++
       tr (th "3.p"  ++ gforms Sg P3 ++ tdf (vfin (ImperP3 Sg))) ++
       tr (intagAttr "th" "rowspan=3" (heading plural_Parameter) ++ 
           th "1.p"  ++ gforms Pl P1 ++ tdf (vfin (ImperP1Pl))) ++
       tr (th "2.p"  ++ gforms Pl P2 ++ tdf (vfin (Imper Pl))) ++
       tr (th "3.p"  ++ gforms Pl P3 ++ tdf (vfin (ImperP3 Pl))) ++
       tr (intagAttr "th" "colspan=2" (heading passive_Parameter)  
                         ++ tdf (vfin (PassPresn True))  ++ tdf (vfin (PassImpf True))  ++ --# notpresent
                            tdf (vfin (PassCondit True)) ++ tdf (vfin (PassPotent True)) ++ tdf (vfin (PassImper True))  --# notpresent
                          ) ++ 
       tr (intagAttr "th" "rowspan=3" (heading negative_Parameter) ++ 

             th (heading singular_Parameter) 
                         ++ tdf2 (vfin (Imper Sg))   ++ tdf (vfin (PastPartAct (AN (NCase Sg Nom))))  
                         ++ tdf2 (vfin (Condit Sg P3)) ++ tdf2 (vfin (PotentNeg)) ++ tdf (vfin (Imper Sg)) --# notpresent 
                               ) ++
       tr (  th (heading plural_Parameter)  ++              tdf (vfin (PastPartAct (AN (NCase Pl Nom)))) ++ 
                                                            tdf (vfin (ImpNegPl))) ++ 
       tr (  th (heading passive_Parameter) ++ tdf (vfin (PassPresn False))  
                          ++ tdf (vfin (PassImpf False)) ++ tdf (vfin (PassCondit False)) ++ tdf (vfin (PassPotent False))--# notpresent 
                          ++ tdf (vfin (PassImper False))) 
       ) 
  ++
      heading2 (nounPluralHeading nominal_form_ParameterType).s ++ ---
        frameTable (
          tr (intagAttr "th" "rowspan=15" (heading infinitive_Parameter) ++         
              intagAttr "th" "rowspan=2" "1" ++         
              th (heading short_Parameter) ++ ---
              tdf (vfin (Inf Inf1))) ++
          tr (th (heading long_Parameter) ++ ---
              tdf (vfin (Inf Inf1Long) ++ BIND ++ "(ni)")) ++
          tr (intagAttr "th" "rowspan=2" ("2." ++ heading active_Parameter) ++         
              th (heading inessive_Parameter) ++ 
              tdf (vfin (Inf Inf2Iness))) ++
          tr (th (heading instructive_Parameter) ++ 
              tdf (vfin (Inf Inf2Instr))) ++
          tr (th ("2." ++ heading passive_Parameter) ++         
              th (heading inessive_Parameter) ++ 
              tdf (vfin (Inf Inf2InessPass))) ++

          tr (intagAttr "th" "rowspan=7" "3." ++         
              th (heading inessive_Parameter) ++ tdf (vfin (Inf Inf3Iness))) ++
          tr (th (heading elative_Parameter)  ++ tdf (vfin (Inf Inf3Elat))) ++
          tr (th (heading illative_Parameter) ++ tdf (vfin (Inf Inf3Illat))) ++
          tr (th (heading adessive_Parameter) ++ tdf (vfin (Inf Inf3Adess))) ++
          tr (th (heading abessive_Parameter) ++ tdf (vfin (Inf Inf3Abess))) ++
          tr (th (heading instructive_Parameter) ++ tdf (vfin (Inf Inf3Instr))) ++
          tr (th (heading instructive_Parameter ++ "pass.") ++ tdf (vfin (Inf Inf3InstrPass))) ++

          tr (intagAttr "th" "rowspan=2" "4." ++         
              th (heading nominative_Parameter) ++ tdf (vfin (Inf Inf4Nom))) ++
          tr (th (heading partitive_Parameter) ++ tdf (vfin (Inf Inf4Part))) ++

          tr (intagAttr "th" "colspan=2" "5." ++ tdf (vfin (Inf Inf5) ++ BIND ++ "(ni)")) ++

          tr (intagAttr "th" "rowspan=5" (heading participle_Parameter) ++         
              intagAttr "th" "rowspan=2" (heading present_Parameter) ++         
              th (heading active_Parameter) ++ 
              tdf (vfin (PresPartAct (AN (NCase Sg Nom))))) ++
          tr (th (heading passive_Parameter) ++ 
              tdf (vfin (PresPartPass (AN (NCase Sg Nom))))) ++

          tr (intagAttr "th" "rowspan=2" (heading perfect_Parameter) ++         
              th (heading active_Parameter) ++ 
              tdf (vfin (PastPartAct (AN (NCase Sg Nom))))) ++

          tr (th (heading passive_Parameter) ++ 
              tdf (vfin (PastPartPass (AN (NCase Sg Nom))))) ++

          tr (intagAttr "th" "colspan=2" (heading agent_Parameter) ++         
             tdf (vfin (AgentPart (AN (NCase Sg Nom)))))

         )

     } ;

lin
  InflectionPrep p = {
    s = heading1 (heading preposition_Category) ++
        paragraph (intag "b" (heading exampleGr_N ++ ":") ++ 
           intag "i" ((S.mkAdv (lin Prep p) S.it_NP).s ++ ";" ++ (S.mkAdv (lin Prep p) S.we_NP).s))
    } ;
}
