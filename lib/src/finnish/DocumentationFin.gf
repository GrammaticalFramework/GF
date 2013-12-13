--# -path=.:../abstract:../common

concrete DocumentationFin of Documentation = CatFin ** open 
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
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  Modifier = G.A ;
  
  Heading = {s : Str} ;
  Inflection = {s : Str} ; 
  

lin
  noun_Category = mkN "substantiivi" ;
  adjective_Category = mkN "adjektiivi" ;
  verb_Category = mkN "verbi" ;
  adverb_Category = mkN "adverbi" ;
  preposition_Category = mkN "prepositio" ;

  singular_Parameter = mkN "yksikkö" ;
  plural_Parameter = mkN "monikko" ;

  masculine_Parameter = mkN "maskuliini" ;
  feminine_Parameter = mkN "feminiini" ;
  neuter_Parameter = mkN "neutri" ;

  nominative_Parameter = mkN "nominatiivi" ;
  genitive_Parameter = mkN "genetiivi" ;
  dative_Parameter = mkN "datiivi" ;
  accusative_Parameter = mkN "akkusatiivi" ;

  partitive_Parameter = mkN "partitiivi" ;
  translative_Parameter = mkN "translatiivi" ;
  essive_Parameter = mkN "essiivi" ;
  inessive_Parameter = mkN "inessiivi" ;
  elative_Parameter = mkN "elatiivi" ;
  illative_Parameter = mkN "illatiivi" ;
  adessive_Parameter = mkN "adessiivi" ;
  ablative_Parameter = mkN "ablatiivi" ;
  allative_Parameter = mkN "allatiivi" ;
  abessive_Parameter = mkN "abessiivi" ;
  comitative_Parameter = mkN "komitatiivi" ;
  instructive_Parameter = mkN "instruktiivi" ;

  active_Parameter = mkN "aktiivi" ;
  passive_Parameter = mkN "passiivi" ;
  
  imperative_Parameter = mkN "imperatiivi" ;
  indicative_Parameter = mkN "indikatiivi" ;
  conjunctive_Parameter = mkN "konjunktiivi" ;
  infinitive_Parameter = mkN "infinitiivi" ;

  present_Parameter = mkN "preesens" ;
  past_Parameter = mkN "imperfekti" ;
  future_Parameter = mkN "futuuri" ;
  conditional_Parameter = mkN "konditionaali" ;
  perfect_Parameter = mkN "perfekti" ;
  potential_Parameter = mkN "potentiaali" ;

  participle_Parameter = mkN "partisiippi" ;
  aux_verb_Parameter = mkN "apu" (mkN "verbi") ;
  agent_Parameter = mkN "agentti" ;

  positive_Parameter = mkN "positiivi" ;
  comparative_Parameter = mkN "komparatiivi" ;
  superlative_Parameter = mkN "superlatiivi" ;
  predicative_Parameter = mkN "predikatiivi" ;

  finite_Modifier = mkA "finiittinen" ;

  nounHeading n = ss ((snoun2nounSep n).s ! NCase Sg Nom) ;

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


  InflectionV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V v))) v ;
  InflectionV2 v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2 v) S.something_NP)) (lin V v) ;
  InflectionVV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) (lin V v) ;
  InflectionV2V v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) (lin V v) ;

  ExplainInflection e i = ss (i.s ++ paragraph e.s) ;  -- explanation appended in a new paragraph

oper 
  verbExample : Cl -> Str = \cl -> (S.mkUtt cl).s ;

  inflectionVerb : Str -> V -> {s : Str} = \ex,verb0 -> 
     let 
       verb = sverb2verbSep verb0 ;
       vfin : VForm -> Str = \f ->
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
      heading2 "finiittimuodot" ++  --- 
       frameTable (
       tr (intagAttr "th" "rowspan=2" "" ++ 
                    intagAttr "th" "colspan=2" (heading indicative_Parameter) ++ 
                    th (heading conditional_Parameter) ++ th (heading potential_Parameter)  ++  
                    th (heading imperative_Parameter))  ++  
       tr (         th (heading present_Parameter) ++ th (heading past_Parameter) ++  
                    th (heading present_Parameter) ++ th (heading present_Parameter)  ++  
                    th (heading present_Parameter))  ++  
       tr (th "yks.1"  ++ gforms Sg P1 ++ tdf "") ++
       tr (th "yks.2"  ++ gforms Sg P2 ++ tdf (vfin (Imper Sg))) ++
       tr (th "yks.3"  ++ gforms Sg P3 ++ tdf (vfin (ImperP3 Sg))) ++
       tr (th "mon.1"  ++ gforms Pl P1 ++ tdf (vfin (ImperP1Pl))) ++
       tr (th "mon.2"  ++ gforms Pl P2 ++ tdf (vfin (Imper Pl))) ++
       tr (th "mon.3"  ++ gforms Pl P3 ++ tdf (vfin (ImperP3 Pl))) ++
       tr (th "pass."  ++ tdf (vfin (PassPresn True))  ++ tdf (vfin (PassImpf True)) ++ --# notpresent
                          tdf (vfin (PassCondit True)) ++ tdf (vfin (PassPotent True)) ++ tdf (vfin (PassImper True))) ++ --# notpresent 
       tr (th "kielt.yks."  ++ tdf2 (vfin (Imper Sg))   ++ tdf (vfin (PastPartAct (AN (NCase Sg Nom))))  
                            ++ tdf2 (vfin (Condit Sg P3)) ++ tdf2 (vfin (PotentNeg)) ++ tdf (vfin (Imper Sg)) --# notpresent 
                               ) ++
       tr (th "kielt.mon."  ++                                tdf (vfin (PastPartAct (AN (NCase Pl Nom)))) ++ 
                                                              tdf (vfin (ImpNegPl))) ++ 
       tr (th "kielt.pass." ++ tdf (vfin (PassPresn False))  
                          ++ tdf (vfin (PassImpf False)) ++ tdf (vfin (PassCondit False)) ++ tdf (vfin (PassPotent False))--# notpresent 
                          ++ tdf (vfin (PassImper False))) 
       ) 
  ++
      heading2 "nominaalimuodot" ++ ---
        frameTable (
          tr (intagAttr "th" "rowspan=15" (heading infinitive_Parameter) ++         
              intagAttr "th" "rowspan=2" "1" ++         
              th "lyhyt" ++ ---
              tdf (vfin (Inf Inf1))) ++
          tr (th "pitkä" ++ ---
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


  formGF_N = mkN "muoto" ;
  exampleGr_N = mkN "esimerkki" ;

}