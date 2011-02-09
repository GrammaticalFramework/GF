abstract Discourse = 
  Lexicon,
  Noun, Verb,
  Adjective, Adverb,
  Structural - [nobody_NP, nothing_NP],
  Tense
** {

flags startcat = S ;

cat
  Clause ;     -- subject, verb, object, adverb(s)
  Marker ;     -- discourse marker

fun 
  PreSubjS  : Marker -> Temp -> Pol -> Clause -> S ;              -- Jussihan juo maitoa nyt
  PreVerbS  : Marker -> Temp -> Pol -> Clause -> S ;              -- juohan Jussi maitoa nyt
  PreObjS   : Marker -> Temp -> Pol -> Clause -> S ;              -- maitoahan Jussi juo nyt
  PreAdvS   : Marker -> Temp -> Pol -> Clause -> S ;              -- nythän Jussi juo maitoa

  NoFocClause    : NP -> VP -> Clause ;                           -- Jussi juo maitoa nyt
  FocSubjClause  : NP -> VP -> Clause ;                           -- Jussikin juo maitoa nyt
  FocVerbClause  : NP -> VP -> Clause ;                           -- Jussi juokin maitoa nyt
  FocObjClause   : NP -> VPSlash -> NP -> Clause ;                -- Jussi juo maitoakin nyt
  FocAdvClause   : NP -> VP -> Adv -> Clause ;                    -- Jussi juo maitoa nytkin


{-
  ClauseS        : Marker -> Temp -> Pol -> NP -> VP -> S ;              -- Jussihan juo maitoa nyt

  FocSubjS       : Marker -> Temp -> Pol -> NP -> VP -> S ;              -- Jussikinhan juo maitoa nyt
  FocVerbS       : Marker -> Temp -> Pol -> NP -> VP -> S ;              -- Jussihan juokin maitoa nyt
  FocObjS        : Marker -> Temp -> Pol -> NP -> VPSlash -> NP -> S ;   -- Jussihan juo maitoakin nyt
  FocAdvS        : Marker -> Temp -> Pol -> NP -> VP -> Adv -> S ;       -- Jussihan juo maitoa nytkin
-}
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
