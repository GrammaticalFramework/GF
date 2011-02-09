abstract Discourse = 
  Lexicon,
  Noun, Verb,
  Adjective, Adverb,
  Structural - [nobody_NP, nothing_NP],
  Tense
** {

flags startcat = S ;

cat
  Marker ;     -- discourse marker

fun 
  ClauseS        : Marker -> Temp -> Pol -> NP -> VP -> S ;              -- Jussihan juo maitoa nyt

  FocSubjS       : Marker -> Temp -> Pol -> NP -> VP -> S ;              -- Jussikinhan juo maitoa nyt
  FocVerbS       : Marker -> Temp -> Pol -> NP -> VP -> S ;              -- Jussihan juokin maitoa nyt
  FocObjS        : Marker -> Temp -> Pol -> NP -> VPSlash -> NP -> S ;   -- Jussihan juo maitoakin nyt
  FocAdvS        : Marker -> Temp -> Pol -> NP -> VP -> Adv -> S ;       -- Jussihan juo maitoa nytkin

{-
  PreAdvS        : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nythän Jussi juo maitoa
  PreAdvKinS     : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nytkinhän Jussi juo maitoa
  PreAdvSubjKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nythän Jussikin juo maitoa
  PreAdvVerbKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- nythän Jussi juokin maitoa

  PreObjS        : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoahan Jussi juo nyt
  PreObjKinS     : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoakinhan Jussi juo nyt
  PreObjSubjKinS : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoahan Jussikin juo nyt
  PreObjVerbKinS : Part -> Temp -> Pol        -> Clause -> S ;   -- maitoahan Jussi juokin nyt

  PreVerbS       : Part -> Temp -> Pol        -> Clause -> S ;   -- juohan Jussi maitoa nyt
  PreVerbSubKinS : Part -> Temp -> Pol        -> Clause -> S ;   -- juohan Jussikin maitoa nyt
  PreVerbAdvKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ;   -- juohan Jussi nytkin maitoa
  PreVerbObjKinS : Part -> Temp -> Pol -> NP  -> Clause -> S ;   -- juohan Jussi maitoa nytkin
-}

  neutralMarker, remindMarker, contrastMarker : Marker ; 

}
