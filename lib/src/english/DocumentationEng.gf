--# -path=.:../abstract:../common

concrete DocumentationEng of Documentation = CatEng ** open 
  ResEng,
  ParadigmsEng,
  (G = GrammarEng),
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
  noun_Category = mkN "noun" ;
  adjective_Category = mkN "adjective" ;
  verb_Category = mkN "verb" ;
  adverb_Category = mkN "adverb" ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  masculine_Parameter = mkN "masculine" ;
  feminine_Parameter = mkN "feminine" ;
  neuter_Parameter = mkN "neuter" ;

  nominative_Parameter = mkN "nominative" ;
  genitive_Parameter = mkN "genitive" ;
  dative_Parameter = mkN "dative" ;
  accusative_Parameter = mkN "accusative" ;
  
  imperative_Parameter = mkN "imperative" ;
  indicative_Parameter = mkN "indicative" ;
  conjunctive_Parameter = mkN "konjunctive" ;
  infinitive_Parameter = mkN "infinitive" ;

  present_Parameter = mkN "present" ;
  past_Parameter = mkN "past" ;
  future_Parameter = mkN "future" ;
  conditional_Parameter = mkN "conditional" ;
  perfect_Parameter = mkN "perfect" ;

  participle_Parameter = mkN "participle" ;
  aux_verb_Parameter = mkN "auxiliary" ;

  positive_Parameter = mkN "positive" ;
  comparative_Parameter = mkN "comparative" ;
  superlative_Parameter = mkN "superlative" ;
  predicative_Parameter = mkN "predicative" ;

  nounHeading n = ss (n.s ! Sg ! Nom) ;

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



  InflectionV, InflectionV2 = \verb -> {
    s = heading1 (heading verb_Category) ++ 
        frameTable (
          tr (th (heading infinitive_Parameter)    ++ tdf (verb.s ! VInf)) ++
          tr (th (heading present_Parameter)       ++ tdf (verb.s ! VPres)) ++
          tr (th (heading past_Parameter)          ++ tdf (verb.s ! VPast)) ++ --# notpresent
          tr (th (heading past_Parameter ++ heading participle_Parameter)    ++ tdf (verb.s ! VPPart)) ++
          tr (th (heading present_Parameter ++ heading participle_Parameter) ++ tdf (verb.s ! VPresPart)) 
        )
    } ;


}