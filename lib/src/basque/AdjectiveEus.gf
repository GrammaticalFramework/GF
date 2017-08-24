concrete AdjectiveEus of Adjective = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin
-- The principal ways of forming an adjectival phrase are
-- positive, comparative, relational, reflexive-relational, and
-- elliptic-relational.

  -- : A  -> AP ;
  PositA a = a ** { 
    s    = a.s ! AF Posit ; 
    typ  = Bare } ;

  -- : A  -> NP -> AP ;  -- euskara ingelesa baino errazagoa da.
  ComparA a np = a ** {
    s    = np.s ! Abs ++ "baino" ++ a.s ! AF Compar ; 
    typ  = Bare } ;

  -- : A2 -> NP -> AP ;  -- married to her
  ComplA2 a2 np = a2 ** {
    s    = applyPost a2.compl np ++ a2.s ! AF Posit ; 
    typ  = Bare } ;

  -- : A2 -> AP ;        -- married to itself
  ReflA2 a2 = a2 ** {
    s    = applyPost a2.compl buru_NP ++ a2.s ! AF Posit ; 
    typ  = Bare } ;

  -- : A2 -> AP ;        -- married
  UseA2 = PositA ;

  -- : A  -> AP ;     -- warmer
  UseComparA a = a ** {
    s    = a.s ! AF Compar ; 
    typ  = Bare } ;


  -- : CAdv -> AP -> NP -> AP ; -- as cool as John
  CAdvAP adv ap np = ap ** {
    s = np.s ! Abs ++ adv.s ++ ap.s } ;

-- The superlative use is covered in $Ord$.

  -- : Ord -> AP ;       -- warmest
  AdjOrd ord = ord ** {
    ph = FinalCons ; --always ends in -en
    typ = Bare } ;

-- Sentence and question complements defined for all adjectival
-- phrases, although the semantics is only clear for some adjectives.
 
  -- : AP -> SC -> AP ;  -- good that she is here
  SentAP  ap sc = ap ; --TODO

-- An adjectival phrase can be modified by an *adadjective*, such as "very".

  -- : AdA -> AP -> AP ; 
  AdAP ada ap = ap ** {
    s = ada.s ++ ap.s ; 
    typ = Bare  } ;


-- It can also be postmodified by an adverb, typically a prepositional phrase.

-- : AP -> Adv -> AP ; -- warm by nature
  AdvAP  ap adv = ap ; --TODO
 


}
