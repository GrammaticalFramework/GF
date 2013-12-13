--# -path=.:../abstract:../common

concrete DocumentationGer of Documentation = CatGer ** open 
  ResGer,
  ParadigmsGer,
  (G = GrammarGer),
  (S = SyntaxGer),
  (L = LexiconGer),
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
  noun_Category = mkN "Substantiv" ;
  adjective_Category = mkN "Adjektiv" ;
  verb_Category = mkN "Verb" ;
  preposition_Category = mkN "Präposition" ;

  gender_ParameterType = mkN "Geschlecht" ;

  singular_Parameter = mkN "Singular" ;
  plural_Parameter = mkN "Plural" ;

  masculine_Parameter = mkN "Maskulinum" ;
  feminine_Parameter = mkN "Femininum" ;
  neuter_Parameter = mkN "Neutrum" ;

  nominative_Parameter = mkN "Nominativ" ;
  genitive_Parameter = mkN "Genitiv" ;
  dative_Parameter = mkN "Dativ" ;
  accusative_Parameter = mkN "Akkusativ" ;
  
  imperative_Parameter = mkN "Imperativ" ;
  indicative_Parameter = mkN "Indikativ" ;
  conjunctive_Parameter = mkN "Konjunktiv" ;
  infinitive_Parameter = mkN "Infinitiv" ;

  present_Parameter = mkN "Präsens" ;
  past_Parameter = mkN "Präteritum" ;
  future_Parameter = mkN "Futur" ;
  conditional_Parameter = mkN "Konditional" ;
  perfect_Parameter = mkN "Perfekt" ;

  participle_Parameter = mkN "Partizip" ;
  aux_verb_Parameter = mkN "Hilfsverb" ;

  positive_Parameter = mkN "Positiv" ;
  comparative_Parameter = mkN "Komparativ" ;
  superlative_Parameter = mkN "Superlativ" ;
  predicative_Parameter = mkN "Prädikativ" ;

  nounHeading n = ss (n.s ! Sg ! Nom) ;

oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;

   nounGender : N -> Parameter = \n -> case n.g of {
     Masc   => masculine_Parameter ; 
     Fem    => feminine_Parameter ;
     Neutr  => neuter_Parameter
     } ;

lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++ 
        paragraph (intag "b" (heading (gender_ParameterType)) ++ ":" ++ heading (nounGender noun)) ++
        frameTable ( 
          tr (th ""          ++ th (heading singular_Parameter)            ++ th (heading plural_Parameter)   ) ++
          tr (th (heading nominative_Parameter) ++ tdf (noun.s ! Sg ! Nom) ++ tdf (noun.s ! Pl ! Nom)) ++
          tr (th (heading genitive_Parameter)   ++ tdf (noun.s ! Sg ! Gen) ++ tdf (noun.s ! Pl ! Gen)) ++
          tr (th (heading dative_Parameter)     ++ tdf (noun.s ! Sg ! Dat) ++ tdf (noun.s ! Pl ! Dat)) ++
          tr (th (heading accusative_Parameter) ++ tdf (noun.s ! Sg ! Acc) ++ tdf (noun.s ! Pl ! Acc))
          )
     } ;

  InflectionA adj = 
    let
      gforms : Degree -> ResGer.Case -> Str = \d,c ->
        tdf (adj.s ! d ! (AMod (GSg Masc)  c)) ++
        tdf (adj.s ! d ! (AMod (GSg Fem)   c)) ++
        tdf (adj.s ! d ! (AMod (GSg Neutr) c)) ++
        tdf (adj.s ! d ! (AMod GPl         c)) ;
      dtable : Parameter -> Degree -> Str = \s,d ->
        paragraph (heading2 (heading s) ++ frameTable ( 
          tr (th []  ++ th (heading masculine_Parameter) ++ th (heading feminine_Parameter) ++ th (heading neuter_Parameter) ++ 
                        th (heading plural_Parameter)) ++
          tr (th (heading nominative_Parameter) ++ gforms d Nom) ++
          tr (th (heading genitive_Parameter)   ++ gforms d Gen) ++
          tr (th (heading dative_Parameter)     ++ gforms d Dat) ++
          tr (th (heading accusative_Parameter) ++ gforms d Acc) ++
          tr (th (heading predicative_Parameter) ++ intagAttr "td" "colspan=4" (intag "i" (adj.s ! d ! APred)))
          ))
    in {
         s = heading1 (nounHeading adjective_Category).s ++ 
             dtable positive_Parameter Posit ++ dtable comparative_Parameter Compar ++ dtable superlative_Parameter Superl ;
        } ;

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

  lin
    exampleGr_N = mkN "Beispiel" "Beispiele" neuter ;

}