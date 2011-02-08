abstract Discourse = 
  Lexicon,
  Noun, Verb,
  Adjective, Adverb,
  Structural - [nobody_NP, nothing_NP],
  Tense
** {

flags startcat = S ;

cat
  Clause ;   -- clause with subject, verb, object
  Part ;     -- discource particle

fun 
  ClauseS        : Part -> Temp -> Pol        -> Clause -> S ;   -- Jussihan juo nyt maitoa
  SubjKinS       : Part -> Temp -> Pol        -> Clause -> S ;   -- Jussikinhan juo nyt maitoa
  VerbKinS       : Part -> Temp -> Pol        -> Clause -> S ;   -- Jussihan juokin nyt maitoa
  AdvKinS        : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- Jussihan juo nytkin maitoa
  ObjKinS        : Part -> Temp -> Pol        -> Clause -> S ;   -- Jussihan juo nyt maitoakin

  PreAdvS        : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nythän Jussi juo maitoa
  PreAdvKinS     : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nytkinhän Jussi juo maitoa
  PreAdvSubjKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nythän Jussikin juo maitoa
  PreAdvVerbKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nythän Jussi juokin maitoa

  PreObjS        : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoahan Jussi juo nyt
  PreObjKinS     : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoakinhan Jussi juo nyt
  PreObjSubjKinS : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoahan Jussikin juo nyt
  PreObjVerbKinS : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoahan Jussi juokin nyt

  PreVerbS       : Part -> Temp -> Pol        -> Clause -> S ;   -- juohan Jussi nyt maitoa
  PreVerbSubKinS : Part -> Temp -> Pol        -> Clause -> S ;   -- juohan Jussikin nyt maitoa
  PreVerbAdvKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- juohan Jussi nytkin maitoa
  PreVerbObjKinS : Part -> Temp -> Pol -> NP  -> Clause -> S ;   -- juohan Jussi nyt maitoakin


  PredClause  : NP -> VP -> Clause ; 

  noPart, han_Part, pas_Part : Part ; 

}
