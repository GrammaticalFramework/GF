--# -path=.:../abstract:../common

incomplete concrete DocumentationFreFunctor of Documentation = CatFre ** open 
  Terminology, -- the interface to be instantiated
  ResFre,
  CommonRomance,
  ParadigmsFre,
  (G = GrammarFre),
  (S = SyntaxFre),
  (L = LexiconFre),
  Prelude,
  HTML
in {


lincat
  Inflection = {s : Str} ;
  Document = {s : Str} ;
  
oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;
   
   nounGender : CatFre.N -> Parameter = \n -> case n.g of {
     Masc => masculine_Parameter ; 
     Fem  => feminine_Parameter
     } ;

lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++
        paragraph (intag "b" (heading (gender_ParameterType)) ++ ":" ++ heading (nounGender noun)) ++
        paragraph (frameTable ( 
          tr (th (heading singular_Parameter)  ++ th  (heading plural_Parameter)   ) ++
          tr (tdf (noun.s ! Sg)                ++ tdf (noun.s ! Pl))
          ))
     } ;

  InflectionA adj = {
    s = heading1 (nounHeading adjective_Category).s ++ 
        frameTable ( 
          tr (th ""                            ++ th (heading singular_Parameter)  ++ th  (heading plural_Parameter)) ++
          tr (th (heading masculine_Parameter) ++ tdf (adj.s ! Posit ! (AF Masc Sg)) ++ tdf (adj.s ! Posit ! (AF Masc Pl))) ++
          tr (th (heading feminine_Parameter)  ++ tdf (adj.s ! Posit ! (AF Fem Sg))  ++ tdf (adj.s ! Posit ! (AF Fem Pl)))
         )
     } ;
             
  InflectionV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V v))) v ;
  InflectionV2 v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2 v) S.something_NP)) (lin V v) ;
  InflectionVV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) (lin V v) ;
  InflectionV2V v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) (lin V v) ;

  MkDocument b i e = ss (paragraph e.s ++ i.s ++ paragraph e.s) ;  -- explanation appended in a new paragraph

oper 
  verbExample : CatFre.Cl -> Str = \cl ->
     (S.mkUtt cl).s 
     ++ ";" ++ (S.mkUtt (S.mkS S.anteriorAnt cl)).s  --# notpresent
     ;

  inflectionVerb : Str -> CatFre.V -> {s : Str} = \ex,verb -> 
     let 
       vfin : CommonRomance.VF -> Str = \f ->
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
          ++ paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" ex)
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
               (tr (intagAttr "th" "colspan=2" "" ++ th (heading simple_past_Parameter) ++  --# notpresent 
                    th (heading future_Parameter) ++ th (heading conditional_Parameter)))  --# notpresent

          ++ paragraph (frameTable (
               tr (intagAttr "th" "colspan=2" (heading infinitive_Parameter) ++                (tdf (vfin (VInfin False)))) ++
               tr (intagAttr "th" "rowspan=3" (heading imperative_Parameter) ++ th "sg.2.p" ++ (tdf (vfin (VImper SgP2)))) ++ 
               tr (                                                             th "pl.1.p" ++ (tdf (vfin (VImper PlP1)))) ++ 
               tr (                                                             th "pl.2.p" ++ (tdf (vfin (VImper PlP2)))) ++ 
               tr (intagAttr "th" "rowspan=2" (heading participle_Parameter) ++ 
                                                             th (heading past_Parameter) ++    (tdf (vfin (VPart Masc Sg)))) ++ 
               tr (                                          th (heading present_Parameter) ++ (tdf (vfin VGer)))
               )
             )
     } ; 

}
