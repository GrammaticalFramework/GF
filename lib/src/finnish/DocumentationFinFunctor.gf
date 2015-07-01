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
  Inflection = {t : Str; s1,s2 : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

{-
-} --# notpresent

oper
  heading : N -> Str = \n -> (nounHeading n).s ;

lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "s" ;
    s1 = heading1 (heading noun_Category) ;
    s2 = inflNoun (\nf -> (snoun2nounSep noun).s ! nf)
    } ;

  InflectionA, InflectionA2 = \adj -> {
    t  = "a" ;
    s1 = heading1 (heading adjective_Category) ;
    s2 = inflNoun (\nf -> (snoun2nounSep {s = \\f => adj.s ! Posit  ! sAN f ; h = adj.h}).s ! nf) ++ 
         heading2 (heading comparative_Parameter) ++ 
         inflNoun (\nf -> (snoun2nounSep {s = \\f => adj.s ! Compar ! sAN f ; h = adj.h}).s ! nf) ++ 
         heading2 (heading superlative_Parameter) ++ 
         inflNoun (\nf -> (snoun2nounSep {s = \\f => adj.s ! Superl ! sAN f ; h = adj.h}).s ! nf)
    } ;

  InflectionAdv adv = {
    t  = "adv" ;
    s1 = heading1 (heading adverb_Category) ;
    s2 = paragraph adv.s
    } ;

  InflectionPrep p = {
    t  = "prep" ;
    s1 = heading1 (heading preposition_Category) ;
    s2 = paragraph ((S.mkAdv (lin Prep p) S.it_NP).s ++ ";" ++ (S.mkAdv (lin Prep p) S.we_NP).s)
    } ;

  InflectionV v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v)) ;
    s2 = inflVerb v
    } ;

  InflectionV2 v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.something_NP)) ;
    s2 = inflVerb v
    } ;

  InflectionV3 v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.something_NP S.something_NP)) ;
    s2 = inflVerb v
    } ;

  InflectionV2V v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.we_NP (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionV2S v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.we_NP (lin S (ss "...")))) ;
    s2 = inflVerb v
    } ;

  InflectionV2Q v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.we_NP (lin QS (ss "...")))) ;
    s2 = inflVerb v
    } ;

  InflectionV2A v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.we_NP L.beautiful_A)) ;
    s2 = inflVerb v
    } ;

  InflectionVV v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionVS v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v (lin S (ss "...")))) ;
    s2 = inflVerb v
    } ;

  InflectionVQ v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v (lin QS (ss "...")))) ;
    s2 = inflVerb v
    } ;

  InflectionVA v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v L.beautiful_A)) ;
    s2 = inflVerb v
    } ;

oper 
  verbExample : CatFin.Cl -> Str = \cl -> (S.mkUtt cl).s ;
{-
-} --# notpresent
  inflVerb : CatFin.V -> Str = \verb0 ->
     let 
       verb = sverb2verbSep verb0 ;
       vfin : ResFin.VForm -> Str = \f ->
         verb.s ! f ;
         
       nounNounHeading : Parameter -> Parameter -> Str = \n1,n2 ->
         (S.mkUtt (G.PossNP (S.mkCN n1) (S.mkNP (snoun2nounSep n2)))).s ;
     in
       heading3 (nounNounHeading present_Parameter indicative_Parameter) ++
       frameTable (
         tr (th "" ++
             th (heading singular_Parameter) ++
             th (heading plural_Parameter)
             ++ th (heading passive_Parameter) --# notpresent
            ) ++ 
         tr (th "1.p"  ++ td (vfin (Presn Sg P1)) ++ td (vfin (Presn Pl P1))
             ++ intagAttr "td" "rowspan=3" (vfin (PassPresn True)) --# notpresent
            ) ++
         tr (th "2.p"  ++ td (vfin (Presn Sg P2)) ++ td (vfin (Presn Pl P2))) ++
         tr (th "3.p"  ++ td (vfin (Presn Sg P3)) ++ td (vfin (Presn Pl P3))) ++
         tr (th (heading negative_Parameter) ++
             intagAttr "td" "colspan=2 align=center" (vfin (Imper Sg)) ++ td (vfin (PassPresn False)))
         ) ++
       heading3 (nounNounHeading past_Parameter indicative_Parameter) ++
       frameTable (
         tr (th "" ++
             th (heading singular_Parameter) ++
             th (heading plural_Parameter)
             ++ th (heading passive_Parameter) --# notpresent
            ) ++ 
         tr (th "1.p"  ++ td (vfin (Impf Sg P1)) ++ td (vfin (Impf Pl P1))
             ++ intagAttr "td" "rowspan=3" (vfin (PassImpf True))) ++
         tr (th "2.p"  ++ td (vfin (Impf Sg P2)) ++ td (vfin (Impf Pl P2))) ++
         tr (th "3.p"  ++ td (vfin (Impf Sg P3)) ++ td (vfin (Impf Pl P3))) ++
         tr (th (heading negative_Parameter) ++
             td (vfin (PastPartAct (AN (NCase Sg Nom)))) ++ 
             td (vfin (PastPartAct (AN (NCase Pl Nom)))) ++
             td (vfin (PassImpf False)))
         ) ++
       heading3 (nounNounHeading present_Parameter conditional_Parameter) ++
       frameTable (
         tr (th "" ++
             th (heading singular_Parameter) ++
             th (heading plural_Parameter)
             ++ th (heading passive_Parameter) --# notpresent
            ) ++ 
         tr (th "1.p"  ++ td (vfin (Condit Sg P1)) ++ td (vfin (Condit Pl P1))
             ++ intagAttr "td" "rowspan=3" (vfin (PassCondit True)) --# notpresent
            ) ++
         tr (th "2.p"  ++ td (vfin (Condit Sg P2)) ++ td (vfin (Condit Pl P2))) ++
         tr (th "3.p"  ++ td (vfin (Condit Sg P3)) ++ td (vfin (Condit Pl P3))) ++
         tr (th (heading negative_Parameter) ++
             intagAttr "td" "colspan=2 align=center" (vfin (Condit Sg P3)) ++ td (vfin (PassCondit False)))
         ) ++
       heading3 (nounNounHeading present_Parameter potential_Parameter) ++
       frameTable (
         tr (th "" ++
             th (heading singular_Parameter) ++
             th (heading plural_Parameter)
             ++ th (heading passive_Parameter) --# notpresent
            ) ++ 
         tr (th "1.p"  ++ td (vfin (Potent Sg P1)) ++ td (vfin (Potent Pl P1))
             ++ intagAttr "td" "rowspan=3" (vfin (PassPotent True)) --# notpresent
            ) ++
         tr (th "2.p"  ++ td (vfin (Potent Sg P2)) ++ td (vfin (Potent Pl P2))) ++
         tr (th "3.p"  ++ td (vfin (Potent Sg P3)) ++ td (vfin (Potent Pl P3))) ++
         tr (th (heading negative_Parameter) ++
             intagAttr "td" "colspan=2 align=center" (vfin PotentNeg) ++ td (vfin (PassPotent False)))
         ) ++
       heading3 (nounNounHeading present_Parameter imperative_Parameter) ++
       frameTable (
         tr (th "" ++
             th (heading singular_Parameter) ++
             th (heading plural_Parameter)
             ++ th (heading passive_Parameter) --# notpresent
            ) ++ 
         tr (th "1.p"  ++ td "" ++ td (vfin ImperP1Pl)
             ++ intagAttr "td" "rowspan=3" (vfin (PassImper True))) ++
         tr (th "2.p"  ++ td (vfin (Imper Sg)) ++ td (vfin (Imper Pl))) ++
         tr (th "3.p"  ++ td (vfin (ImperP3 Sg)) ++ td (vfin (ImperP3 Pl))) ++
         tr (th (heading negative_Parameter) ++
             td (vfin (Imper Sg)) ++ 
             td (vfin ImpNegPl) ++
             td (vfin (PassImper False)))
         ) ++
       heading2 (nounPluralHeading nominal_form_ParameterType).s ++
       heading3 (heading infinitive_Parameter) ++
       frameTable (
         tr (intagAttr "th" "rowspan=2" "1" ++         
             th (heading short_Parameter) ++ ---
             td (vfin (Inf Inf1))) ++
         tr (th (heading long_Parameter) ++ ---
             td (vfin (Inf Inf1Long) ++ BIND ++ "(ni)")) ++
         tr (intagAttr "th" "rowspan=2" ("2." ++ heading active_Parameter) ++         
             th (heading inessive_Parameter) ++ 
             td (vfin (Inf Inf2Iness))) ++
         tr (th (heading instructive_Parameter) ++ 
             td (vfin (Inf Inf2Instr))) ++
         tr (th ("2." ++ heading passive_Parameter) ++         
             th (heading inessive_Parameter) ++ 
             td (vfin (Inf Inf2InessPass))) ++

         tr (intagAttr "th" "rowspan=7" "3." ++         
             th (heading inessive_Parameter) ++ td (vfin (Inf Inf3Iness))) ++
         tr (th (heading elative_Parameter)  ++ td (vfin (Inf Inf3Elat))) ++
         tr (th (heading illative_Parameter) ++ td (vfin (Inf Inf3Illat))) ++
         tr (th (heading adessive_Parameter) ++ td (vfin (Inf Inf3Adess))) ++
         tr (th (heading abessive_Parameter) ++ td (vfin (Inf Inf3Abess))) ++
         tr (th (heading instructive_Parameter) ++ td (vfin (Inf Inf3Instr))) ++
         tr (th (heading instructive_Parameter ++ "pass.") ++ td (vfin (Inf Inf3InstrPass))) ++

         tr (intagAttr "th" "rowspan=2" "4." ++         
             th (heading nominative_Parameter) ++ td (vfin (Inf Inf4Nom))) ++
         tr (th (heading partitive_Parameter) ++ td (vfin (Inf Inf4Part))) ++

         tr (intagAttr "th" "colspan=2" "5." ++ td (vfin (Inf Inf5) ++ BIND ++ "(ni)"))
       ) ++
       heading3 (heading participle_Parameter) ++
       frameTable (
         tr (intagAttr "th" "rowspan=2" (heading present_Parameter) ++         
             th (heading active_Parameter) ++ 
             td (vfin (PresPartAct (AN (NCase Sg Nom))))) ++
         tr (th (heading passive_Parameter) ++ 
             td (vfin (PresPartPass (AN (NCase Sg Nom))))) ++

         tr (intagAttr "th" "rowspan=2" (heading perfect_Parameter) ++         
             th (heading active_Parameter) ++ 
             td (vfin (PastPartAct (AN (NCase Sg Nom))))) ++

         tr (th (heading passive_Parameter) ++ 
             td (vfin (PastPartPass (AN (NCase Sg Nom))))) ++

         tr (intagAttr "th" "colspan=2" (heading agent_Parameter) ++         
             td (vfin (AgentPart (AN (NCase Sg Nom)))))
         ) ;

  inflNoun : (NForm -> Str) -> Str = \nouns -> 
    frameTable ( 
          tr (th ""          ++ th (heading singular_Parameter)            ++ th (heading plural_Parameter)   ) ++
          tr (th (heading nominative_Parameter) ++ td (nouns (NCase Sg Nom)) ++ td (nouns (NCase Pl Nom))) ++
          tr (th (heading genitive_Parameter) ++ td (nouns (NCase Sg Gen)) ++ td (nouns (NCase Pl Gen))) ++
          tr (th (heading partitive_Parameter) ++ td (nouns (NCase Sg Part)) ++ td (nouns (NCase Pl Part))) ++
          tr (th (heading translative_Parameter) ++ td (nouns (NCase Sg Transl)) ++ td (nouns (NCase Pl Transl))) ++
          tr (th (heading essive_Parameter) ++ td (nouns (NCase Sg Ess)) ++ td (nouns (NCase Pl Ess))) ++
          tr (th (heading inessive_Parameter) ++ td (nouns (NCase Sg Iness)) ++ td (nouns (NCase Pl Iness))) ++
          tr (th (heading elative_Parameter) ++ td (nouns (NCase Sg Elat)) ++ td (nouns (NCase Pl Elat))) ++
          tr (th (heading illative_Parameter) ++ td (nouns (NCase Sg Illat)) ++ td (nouns (NCase Pl Illat))) ++
          tr (th (heading adessive_Parameter) ++ td (nouns (NCase Sg Adess)) ++ td (nouns (NCase Pl Adess))) ++
          tr (th (heading ablative_Parameter) ++ td (nouns (NCase Sg Ablat)) ++ td (nouns (NCase Pl Ablat))) ++
          tr (th (heading allative_Parameter) ++ td (nouns (NCase Sg Allat)) ++ td (nouns (NCase Pl Allat))) ++
          tr (th (heading abessive_Parameter) ++ td (nouns (NCase Sg Abess)) ++ td (nouns (NCase Pl Abess))) ++
          tr (th (heading comitative_Parameter)  ++ td "" ++ td (nouns (NComit))) ++
          tr (th (heading instructive_Parameter) ++ td "" ++ td (nouns (NInstruct))) 
          ) ;

lin
  MkDocument b i e = ss (i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ paragraph e.s) ;  -- explanation appended in a new paragraph
  MkTag i = ss (i.t) ;

{- --# notpresent
-} 

}
