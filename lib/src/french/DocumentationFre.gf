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
  indicative_Parameter = mkN "indikatif" ;
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
             
{-

  InflectionV, InflectionV2 = \verb -> 
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

}