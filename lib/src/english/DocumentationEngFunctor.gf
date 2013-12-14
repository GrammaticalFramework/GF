--# -path=.:../abstract:../common

-- documentation of English in any language instantiating Terminology

incomplete concrete DocumentationEngFunctor of Documentation = CatEng ** open 
  Terminology,
  ResEng,
  ParadigmsEng,
  (G = GrammarEng),
  (S = SyntaxEng),
  (L = LexiconEng),
  Prelude,
  HTML
in {


lincat
  Inflection = {s : Str} ; 
  
oper
   tdf : Str -> Str = \s -> td (intag "i" s) ;
   heading : N -> Str = \n -> (nounHeading n).s ;
lin
  InflectionN noun = {
    s = heading1 (heading noun_Category) ++ frameTable ( 
          tr (th ""          ++ th (heading singular_Parameter)            ++ th (heading plural_Parameter)   ) ++
          tr (th (heading nominative_Parameter) ++ tdf (noun.s ! Sg ! Nom) ++ tdf (noun.s ! Pl ! Nom)) ++
          tr (th (heading genitive_Parameter)   ++ tdf (noun.s ! Sg ! Gen) ++ tdf (noun.s ! Pl ! Gen)) 
          )
     } ;

  InflectionA adj = {
    s = heading1 (heading adjective_Category) ++ 
        frameTable (
          tr (th (heading positive_Parameter)    ++ tdf (adj.s ! AAdj Posit Nom)) ++
          tr (th (heading comparative_Parameter) ++ tdf (adj.s ! AAdj Compar Nom)) ++
          tr (th (heading superlative_Parameter) ++ tdf (adj.s ! AAdj Superl Nom)) ++
          tr (th (heading adverb_Category)       ++ tdf (adj.s ! AAdv)) 
        )
    } ;

  InflectionV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V v))) v ;
  InflectionV2 v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2 v) S.something_NP)) (lin V v) ;
---  InflectionVV v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) (lin V v) ;
  InflectionV2V v = inflectionVerb (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) (lin V v) ;

  ExplainInflection e i = ss (i.s ++ paragraph e.s) ;  -- explanation appended in a new paragraph

oper 
  verbExample : CatEng.Cl -> Str = \cl -> (S.mkUtt cl).s ;

  inflectionVerb : Str -> CatEng.V -> {s : Str} = \ex,verb -> {
    s = heading1 (heading verb_Category) ++ 
      paragraph (intag "b" (heading exampleGr_N ++ ":") ++ intag "i" ex) ++
        frameTable (
          tr (th (heading infinitive_Parameter)    ++ tdf (verb.s ! VInf)) ++
          tr (th (heading present_Parameter)       ++ tdf (verb.s ! VPres)) ++
          tr (th (heading past_Parameter)          ++ tdf (verb.s ! VPast)) ++ --# notpresent
          tr (th (heading past_Parameter ++ heading participle_Parameter)    ++ tdf (verb.s ! VPPart)) ++
          tr (th (heading present_Parameter ++ heading participle_Parameter) ++ tdf (verb.s ! VPresPart)) 
        )
    } ;

}