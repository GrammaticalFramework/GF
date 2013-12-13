--# -path=.:../abstract:../common

concrete DocumentationFre of Documentation = CatFre ** open 
  ResFre,
  CommonRomance,
  ParadigmsFre,
  (G = GrammarFre),
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
  noun_Category = mkN "nom" ;
  adjective_Category = mkN "adjectif" ;
  verb_Category = mkN "verbe" masculine ;

  singular_Parameter = mkN "singulier" ;
  plural_Parameter = mkN "pluriel" ;

  masculine_Parameter = mkN "masculin" ;
  feminine_Parameter = mkN "féminin" ;
  neuter_Parameter = mkN "neutre" ;

  nominative_Parameter = mkN "nominatif" ;
  genitive_Parameter = mkN "génitif" ;
  dative_Parameter = mkN "datif" ;
  accusative_Parameter = mkN "accusativ" ;
  
  imperative_Parameter = mkN "impératif" ;
  indicative_Parameter = mkN "indicatif" ;
  conjunctive_Parameter = mkN "subjonctif" ;
  infinitive_Parameter = mkN "infinitif" ;

  present_Parameter = mkN "présent" ;
  past_Parameter = mkN "passé simple" ; ----
  future_Parameter = mkN "futur" ;
  conditional_Parameter = mkN "conditionnel" ;
  perfect_Parameter = mkN "passé composé" ; ----
  imperfect_Parameter = mkN "imparfait" ;

  participle_Parameter = mkN "participe" ;
  aux_verb_Parameter = mkN "auxiliaire" ;

  positive_Parameter = mkN "positif" ;
  comparative_Parameter = mkN "comparatif" ;
  superlative_Parameter = mkN "superlatif" ;
  predicative_Parameter = mkN "prédicatif" ;

  nounHeading n = ss (n.s ! Sg) ;

oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;
lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++ frameTable ( 
          tr (th (heading singular_Parameter)  ++ th  (heading plural_Parameter)   ) ++
          tr (tdf (noun.s ! Sg)                ++ tdf (noun.s ! Pl))
          )
     } ;

  InflectionA adj = {
    s = heading1 (nounHeading adjective_Category).s ++ 
        frameTable ( 
          tr (th ""                            ++ th (heading singular_Parameter)  ++ th  (heading plural_Parameter)) ++
          tr (th (heading masculine_Parameter) ++ tdf (adj.s ! Posit ! (AF Masc Sg)) ++ tdf (adj.s ! Posit ! (AF Masc Pl))) ++
          tr (th (heading feminine_Parameter)  ++ tdf (adj.s ! Posit ! (AF Fem Sg))  ++ tdf (adj.s ! Posit ! (AF Fem Pl)))
         )
     } ;
             
  InflectionV, InflectionV2 = \verb -> 
     let 
       vfin : VF -> Str = \f ->
         verb.s ! f ; 

       gforms : Number -> Person -> Str = \n,p -> 
         tdf (vfin (VFin (VPres Indic) n p)) ++
         tdf (vfin (VFin (VPres Conjunct) n p)) 
         ++ tdf (vfin (VFin (VImperf Indic) n p))     --# notpresent
         ++ tdf (vfin (VFin (VImperf Conjunct) n p))  --# notpresent
         ;

       gforms2 : Number -> Person -> Str = \n,p -> --# notpresent
         tdf (vfin (VFin VPasse n p)) ++  --# notpresent
         tdf (vfin (VFin VFut n p)) ++  --# notpresent
         tdf (vfin (VFin VCondit n p))   --# notpresent
         ;  --# notpresent

       ttable : (Number -> Person -> Str) -> Str -> Str = \forms, theadings ->
         paragraph (frameTable (
           theadings ++ 
           tr (intagAttr "th" "rowspan=3" (heading singular_Parameter) ++
               th "1.p" ++ forms Sg P1) ++  
           tr (th "2.p" ++ forms Sg P2) ++  
           tr (th "3.p" ++ forms Sg P3) ++  
           tr (intagAttr "th" "rowspan=3" (heading plural_Parameter) ++
               th "1.p" ++ forms Pl P1) ++  
           tr (th "2.p" ++ forms Pl P2) ++  
           tr (th "3.p" ++ forms Pl P3)
           )) ;

     in {
     s =
        heading1 (heading verb_Category)
          ++ ttable gforms
               (tr (intagAttr "th" "colspan=2 rowspan=2" "" 
                    ++ intagAttr "th" "colspan=2" (heading present_Parameter)
                    ++ intagAttr "th" "colspan=2" (heading imperfect_Parameter)
                   ) ++
                tr (   th (heading indicative_Parameter) ++ th (heading conjunctive_Parameter)
                    ++ th (heading indicative_Parameter) ++ th (heading conjunctive_Parameter)
                   )
               ) 
          ++ ttable gforms2  --# notpresent
               (tr (intagAttr "th" "colspan=2" "" ++ th "passé simple" ++  --# notpresent 
                    th (heading future_Parameter) ++ th (heading conditional_Parameter)))  --# notpresent
        ;
     } ; 


{-
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

}