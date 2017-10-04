concrete AdjectiveEus of Adjective = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin
-- The principal ways of forming an adjectival phrase are
-- positive, comparative, relational, reflexive-relational, and
-- elliptic-relational.

  -- : A  -> AP ;
  PositA a = a ** { 
    s    = \\agr => a.s ! AF Posit ; 
    typ  = Bare } ;

  -- : A  -> NP -> AP ;  -- euskara ingelesa baino errazagoa da.
  ComparA a np = a ** {
    s    = \\agr => np.s ! Abs ++ "baino" ++ a.s ! AF Compar ; 
    typ  = Bare } ;

  -- : A2 -> NP -> AP ;  -- married to her
  ComplA2 a2 np = a2 ** {
    s    = \\agr => applyPost a2.compl np ++ a2.s ! AF Posit ; 
    typ  = Bare } ;

  -- : A2 -> AP ;        -- married to itself
  ReflA2 a2 = a2 ** {
    s    = \\agr => 
             let neure : Str = reflPron ! agr ;
                 neureBuru : NounPhrase = empty_NP ** 
                  { s = \\cas => neure ++ "buru" 
                              ++ artDef ! getNum agr ! cas ! FinalVow ;
                    agr = agr } -- neure buruekin ezkondua naiz / 
                                -- geure buruekin ezkonduak gara
             in applyPost a2.compl neureBuru ++ a2.s ! AF Posit ; 
    typ  = Bare } ;

  -- : A2 -> AP ;        -- married
  UseA2 = PositA ;

  -- : A  -> AP ;     -- warmer
  UseComparA a = a ** {
    s    = \\agr => a.s ! AF Compar ; 
    typ  = Bare } ;


  -- : CAdv -> AP -> NP -> AP ; -- as cool as John
  CAdvAP adv ap np = ap ** {
    s = \\agr => np.s ! Abs ++ adv.s ++ ap.s ! agr } ;

-- The superlative use is covered in $Ord$.

  -- : Ord -> AP ;       -- warmest
  AdjOrd ord = ord ** {
    s = \\agr => ord.s ;
    ph = FinalCons ; --always ends in -en
    typ = Bare } ;

-- Sentence and question complements defined for all adjectival
-- phrases, although the semantics is only clear for some adjectives.
 
  -- : AP -> SC -> AP ;  -- good that she is here
  SentAP  ap sc = ap ** { 
    s = \\agr => sc.s ++ ap.s ! agr ;
    typ = Bare 
  } ; 

-- An adjectival phrase can be modified by an *adadjective*, such as "very".

  -- : AdA -> AP -> AP ; 
  AdAP ada ap = ap ** {
    s = \\agr => ada.s ++ ap.s ! agr ; 
    typ = Bare } ;


-- It can also be postmodified by an adverb, typically a prepositional phrase.

-- : AP -> Adv -> AP ; -- warm by nature
  AdvAP  ap adv = ap **
   { s = \\agr => ap.s ! agr ++ adv.s ;
     typ = Bare } ;
 


}
