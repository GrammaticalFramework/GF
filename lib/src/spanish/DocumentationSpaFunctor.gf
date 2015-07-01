--# -path=.:../abstract:../common

incomplete concrete DocumentationSpaFunctor of Documentation = CatSpa ** open 
  Terminology, -- the interface to be instantiated
  ResSpa,
  CommonRomance,
  ParadigmsSpa,
  (G = GrammarSpa),
  (S = SyntaxSpa),
  (L = LexiconSpa),
  Prelude,
  HTML
in {
flags coding=utf8 ;


lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;
  
{-
-} --# notpresent

oper
   heading : N -> Str = \n -> (nounHeading n).s ;
   
lin
  InflectionN, InflectionN3, InflectionN3 = \noun -> {
    t = "n" ;
    s1 = heading1 (heading noun_Category ++ 
                   case noun.g of {
                     Masc => "("+heading masculine_Parameter+")" ; 
                     Fem  => "("+heading feminine_Parameter+")"
                   }) ;
    s2 = frameTable ( 
           tr (th (heading singular_Parameter) ++ th  (heading plural_Parameter)) ++
           tr (td (noun.s ! Sg)                ++ td (noun.s ! Pl))
           )
    } ;

  InflectionA, InflectionA2 = \adj -> {
    t  = "a" ;
    s1 = heading1 (nounHeading adjective_Category).s ;
    s2 = frameTable (
           tr (th ""                            ++ th (heading singular_Parameter)  ++ th  (heading plural_Parameter)) ++
           tr (th (heading masculine_Parameter) ++ td (adj.s ! Posit ! (AF Masc Sg)) ++ td (adj.s ! Posit ! (AF Masc Pl))) ++
           tr (th (heading feminine_Parameter)  ++ td (adj.s ! Posit ! (AF Fem Sg))  ++ td (adj.s ! Posit ! (AF Fem Pl)))
         )
    } ;

  InflectionAdv adv = {
    t  = "adv" ;
    s1 = heading1 "Adverbe" ;
    s2 = paragraph adv.s
    } ;

  InflectionPrep p = {
    t  = "prep" ;
    s1 = heading1 "Préposition" ;
    s2 = paragraph p.s
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
         paragraph (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionV2S v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionV2Q v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionV2A v = {
    t  = "v" ;
    s1 = heading1 "Verb" ;
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
    s1 = heading1 "Verb" ;
    s2 = inflVerb v
    } ;

  InflectionVQ v = {
    t  = "v" ;
    s1 = heading1 "Verb" ;
    s2 = inflVerb v
    } ;

  InflectionVA v = {
    t  = "v" ;
    s1 = heading1 "Verb" ;
    s2 = inflVerb v
    } ;

  MkDocument b i e = ss (i.s1 ++ "<p style=\"font-size:20px\">"++b.s++"</p>" ++ i.s2 ++ paragraph e.s) ;  -- explanation appended in a new paragraph
  MkTag i = ss i.t ;

oper 
  verbExample : CatSpa.Cl -> Str = \cl ->
     (S.mkUtt cl).s 
     ++ ";" ++ (S.mkUtt (S.mkS S.anteriorAnt cl)).s  --# notpresent
     ;

  inflVerb : Verb -> Str = \verb -> 
     let 
       vfin : CommonRomance.VF -> Str = \f ->
         verb.s ! f ; 

       ttable : TMood -> Str = \tense ->
         frameTable (
           tr (th "" ++ 
               th (heading singular_Parameter) ++ 
               th (heading plural_Parameter)) ++ 
           tr (th "1.p" ++ 
               td (vfin (VFin tense Sg P1)) ++
               td (vfin (VFin tense Pl P1))) ++
           tr (th "2.p" ++
               td (vfin (VFin tense Sg P2)) ++
               td (vfin (VFin tense Pl P2))) ++
           tr (th "3.p" ++
               td (vfin (VFin tense Sg P3)) ++
               td (vfin (VFin tense Pl P3)))
           ) ;

       ttable2 : (Mood -> TMood) -> Str = \f ->
         frameTable (
           tr (intagAttr "th" "colspan=2" "" ++ 
               th (heading indicative_Parameter) ++ 
               th (heading conjunctive_Parameter)) ++ 
           tr (intagAttr "th" "rowspan=3" (heading singular_Parameter) ++
               th "1.p" ++ 
               td (vfin (VFin (f Indic) Sg P1)) ++
               td (vfin (VFin (f Conjunct) Sg P1))) ++
           tr (th "2.p" ++
               td (vfin (VFin (f Indic) Sg P2)) ++
               td (vfin (VFin (f Conjunct) Sg P2))) ++
           tr (th "3.p" ++
               td (vfin (VFin (f Indic) Sg P3)) ++
               td (vfin (VFin (f Conjunct) Sg P3))) ++  
           tr (intagAttr "th" "rowspan=3" (heading plural_Parameter) ++
               th "1.p" ++
               td (vfin (VFin (f Indic) Pl P1)) ++
               td (vfin (VFin (f Conjunct) Pl P1))) ++
           tr (th "2.p" ++
               td (vfin (VFin (f Indic) Pl P2)) ++
               td (vfin (VFin (f Conjunct) Pl P2))) ++
           tr (th "3.p" ++ 
               td (vfin (VFin (f Indic) Pl P3)) ++
               td (vfin (VFin (f Conjunct) Pl P3)))
           ) ;

     in heading2 (heading present_Parameter) ++
        ttable2 VPres ++
        heading2 (heading imperfect_Parameter) ++
        ttable2 VImperf
        ++ heading2 (heading simple_past_Parameter) ++  --# notpresent
        ttable VPasse  --# notpresent
        ++ heading2 (heading future_Parameter) ++  --# notpresent
        ttable VFut  --# notpresent
        ++ heading2 (heading conditional_Parameter) ++  --# notpresent
        ttable VCondit  --# notpresent
        ++ heading2 (heading infinitive_Parameter) ++
        paragraph (vfin (VInfin False)) ++
        heading2 (heading imperative_Parameter) ++
        frameTable (
          tr (th "sg.2.p" ++ td (vfin (VImper SgP2))) ++ 
          tr (th "pl.1.p" ++ td (vfin (VImper PlP1))) ++ 
          tr (th "pl.2.p" ++ td (vfin (VImper PlP2)))
          ) ++
        heading2 (heading participle_Parameter) ++
        frameTable (
          tr (th (heading past_Parameter)    ++ td (vfin (VPart Masc Sg))) ++
          tr (th (heading present_Parameter) ++ td (vfin VGer))
          ) ; 

{- --# notpresent
-} 

}
