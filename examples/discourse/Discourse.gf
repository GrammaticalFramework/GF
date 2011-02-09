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

  NoFocClause    : NP -> VPSlash -> NP -> Adv -> Clause ;         -- Jussi juo maitoa nyt
  FocSubjClause  : NP -> VPSlash -> NP -> Adv -> Clause ;         -- Jussikin juo maitoa nyt
  FocVerbClause  : NP -> VPSlash -> NP -> Adv -> Clause ;         -- Jussi juokin maitoa nyt
  FocObjClause   : NP -> VPSlash -> NP -> Adv -> Clause ;         -- Jussi juo maitoakin nyt
  FocAdvClause   : NP -> VPSlash -> NP -> Adv -> Clause ;         -- Jussi juo maitoa nytkin

  neutralMarker, remindMarker, contrastMarker : Marker ; 

}
