--# -path=.:../abstract:../common

concrete DocumentationGer of Documentation = CatGer ** open 
  ResGer,
  ParadigmsGer,
  (G = GrammarGer),
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

  singular_Parameter = mkN "Singular" ;
  plural_Parameter = mkN "Plural" ;

  nominative_Parameter = mkN "Nominativ" ;
  genitive_Parameter = mkN "Genitiv" ;
  dative_Parameter = mkN "Dativ" ;
  accusative_Parameter = mkN "Akkusativ" ;
  


  nounHeading n = ss (n.s ! Sg ! Nom) ;

oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;
lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++ frameTable ( 
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
      dtable : Str -> Degree -> Str = \s,d ->
        paragraph (heading2 s ++ frameTable ( 
          tr (th []  ++ th "Maskulinum" ++ th "Femininum" ++ th "Neutrum" ++ th "Plural") ++
          tr (th "Nominativ" ++ gforms d Nom) ++
          tr (th "Genitiv"   ++ gforms d Gen) ++
          tr (th "Dativ"     ++ gforms d Dat) ++
          tr (th "Akkusativ" ++ gforms d Acc) ++
          tr (th "Prädikativ" ++ intagAttr "td" "colspan=4" (adj.s ! d ! APred))
          ))
    in {
         s = heading1 (nounHeading adjective_Category).s ++ 
             dtable "Positiv" Posit ++ dtable "Komparativ" Compar ++ dtable "Superlativ" Superl ;
        } ;

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
      heading1 (nounHeading verb_Category).s ++  
       paragraph (frameTable (
       tr (th "" ++ intagAttr "th" "colspan=2" "Präsens" ++  intagAttr "th" "colspan=2" "Präteritum") ++  
       tr (th "" ++ th "Indikativ" ++ th "Konjunktiv I"  ++  th "Indikativ" ++ th "Konjunktiv II") ++
       tr (th "Sg.1"  ++ gforms Sg P1) ++
       tr (th "Sg.2"  ++ gforms Sg P2) ++
       tr (th "Sg.3"  ++ gforms Sg P3) ++
       tr (th "Pl.1"  ++ gforms Pl P1) ++
       tr (th "Pl.2"  ++ gforms Pl P2) ++
       tr (th "Pl.3"  ++ gforms Pl P3)
       )) ++
       paragraph (
       frameTable (
       tr (th "Imperativ Sg.2"  ++ tdf (vfin (VImper Sg))) ++
       tr (th "Imperativ Pl.2"  ++ tdf (vfin (VImper Pl))) ++
       tr (th "Infinitiv"       ++ tdf (verb.s ! (VInf False))) ++
       tr (th "Präsespartizip"  ++ tdf (verb.s ! (VPresPart APred))) ++
       tr (th "Perfektpartizip" ++ tdf (verb.s ! (VPastPart APred))) ++
       tr (th "Hilfsverb"       ++ td (case verb.aux of {VHaben => "haben" ; VSein => "sein"}))
       ))
     } ;


}