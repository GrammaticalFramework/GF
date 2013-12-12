--# -path=.:../abstract:../common

concrete DocumentationFin of Documentation = CatFin ** open 
  ResFin,
  StemFin,
  ParadigmsFin,
  (G = GrammarFin),
  (S = SyntaxFin),
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

  positive_Parameter = mkN "positiivi" ;
  comparative_Parameter = mkN "komparatiivi" ;
  superlative_Parameter = mkN "superlatiivi" ;
  predicative_Parameter = mkN "predikatiivi" ;

  finite_Modifier = mkA "finiittinen" ;

  nounHeading n = ss ((snoun2nounSep n).s ! NCase Sg Nom) ;

oper
  tdf : Str -> Str = \s -> td (intag "i" s) ;
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

  InflectionV, InflectionV2 = \verb0 -> 
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
       tr (th "mon.3"  ++ gforms Pl P3 ++ tdf (vfin (ImperP3 Pl))) 
       ) 
 -- ++
    --  heading2 "nominaalimuodot" ++ ---
      -- frameTable () -----

     } ;

  formGF_N = mkN "muoto" ;

}