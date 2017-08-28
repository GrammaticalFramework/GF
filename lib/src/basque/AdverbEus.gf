concrete AdverbEus of Adverb = CatEus ** open ResEus, Prelude in {

lin

  -- : A -> Adv ;
  PositAdvAdj adj = { s = adj.s ! AAdv } ; --TODO: check

  -- : CAdv -> A -> NP -> Adv ; -- more warmly than John
  ComparAdvAdj cadv a np = { s = np.s ! Abs ++ cadv.s ++ a.s ! AAdv } ;

--    ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs

  -- : Prep -> NP -> Adv ;
  PrepNP post np = { s = ResEus.applyPost post np } ;
 
-- Adverbs can be modified by 'adadjectives', just like adjectives.

    --AdAdv  : AdA -> Adv -> Adv ;             -- very quickly
  AdAdv ada adv = { s = ada.s ++ adv.s } ;
-- Like adverbs, adadjectives can be produced by adjectives.

  -- : A -> AdA ;                 -- extremely
  PositAdAAdj a = { s = a.s ! AF Posit ++ BIND ++ "an" } ; --TODO check
-- Subordinate clauses can function as adverbs.

    --: Subj -> S -> Adv ;
  SubjS subj s = 
  	let auxFull : Str = 
  		if_then_Str subj.isPre (glue subj.s s.s.aux.indep)  -- badator
  		 				       (glue s.s.aux.stem subj.s) ; -- datorrenean

    in { s = s.s.beforeAux ++ auxFull ++ s.s.afterAux } ;

-- Comparison adverbs also work as numeral adverbs.

    --AdnCAdv : CAdv -> AdN ;                  -- less (than five)
    --AdnCAdv cadv = {s = } ;
} ;

{-
gt PrepNP in_Prep (DetCN (DetQuant DefArt ?) (UseN ?) | l -bind
gt PrepNP from_Prep (DetCN (DetQuant DefArt ?) (UseN ?)) | l -bind
-}