abstract Discourse = 
  Lexicon,
  Noun, Verb,
  Adjective, Adverb,
  Structural - [nobody_NP, nothing_NP],
  Tense
** {

flags startcat = S ;

cat
  Clause ; Part ;

fun 
  ClauseS        : Part -> Temp -> Pol -> Clause -> S ;        -- arihan juo nyt
  SubjKinS       : Part -> Temp -> Pol -> Clause -> S ;        -- arikinhan juo nyt
  VerbKinS       : Part -> Temp -> Pol -> Clause -> S ;        -- arihan juokin nyt
  AdvKinS        : Part -> Temp -> Pol -> Adv -> Clause -> S ; -- arihan juo nytkin
  PreAdvKinS     : Part -> Temp -> Pol -> Adv -> Clause -> S ; -- nytkinhän ari juo
  PreAdvS        : Part -> Temp -> Pol -> Adv -> Clause -> S ; -- nythän ari juo
  PreAdvSubjKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ; -- nythän arikin juo
  PreAdvVerbKinS : Part -> Temp -> Pol -> Adv -> Clause -> S ; -- nythän ari juokin
  PreAdvAdvKinS  : Part -> Temp -> Pol -> Adv -> Adv -> Clause -> S ; -- nythän ari juo täälläkin

--- AnterVerbS : Part -> PartKin -> Tense -> Pol -> Clause -> S ; -- arihan onkin juonut
--- doesn't put in right place

  PredClause : NP -> VP -> Clause ; 

  noPart, han_Part, pa_Part, pas_Part, ko_Part, kos_Part, kohan_Part, pahan_Part : Part ; 

}
