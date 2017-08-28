concrete QuestionEus of Question = CatEus ** open ResEus, (VE=VerbEus), (NE=NounEus), (AE=AdverbEus) in {

-- A question can be formed from a clause ('yes-no question') or
-- with an interrogative.

  lin
  -- : Cl -> QCl ;
  QuestCl cl = cl ; --Cl and QCl are both ResEus.Clause :
                    -- { s : Tense => Anteriority => Polarity => Sentence } ; 

  -- : IP -> VP -> QCl ; 
  QuestVP = qclFromVP ; 
    
  -- : IP -> ClSlash -> QCl ; -- whom does John love / mutilak nor maite du
  QuestSlash = clFromSlash ;

  -- : IAdv -> Cl -> QCl ;    -- why does John walk
  -- nola (how), zerbait (how much), noiz (when), non (where), zergatik (why)
  QuestIAdv iadv cl = 
    { s = \\t,a,p,c => 
      let sent = cl.s ! t ! a ! p ! Indir ; -- no "al" with a wh-word!
      in { beforeAux = iadv.s ++ sent.beforeAux ;
           aux = sent.aux ; 
           afterAux = sent.afterAux } 
    } ;

  -- : IComp -> NP -> QCl ;   -- John non da ; TODO maybe other word order, non da John?
  QuestIComp icomp np = qclFromVP np (insertComp icomp.s (VE.copulaVP Izan)) ;

-- Interrogative pronouns can be formed with interrogative
-- determiners, with or without a noun.

  -- : IDet -> CN -> IP ;       -- which five songs
  IdetCN = NE.DetCN ;

  -- : IDet       -> IP ;       -- which five
  IdetIP = NE.DetNP ;

-- They can be modified with adverbs.
  -- : IP -> Adv -> IP ;        -- who in Paris
  AdvIP = NE.AdvNP ;

-- Interrogative quantifiers have number forms and can take number modifiers.

  -- : IQuant -> Num -> IDet ;  -- which (five)
  IdetQuant = NE.DetQuant ; 

-- Interrogative adverbs can be formed prepositionally.
  -- : Prep -> IP -> IAdv ;     -- with whom
  PrepIP = AE.PrepNP ;

-- They can be modified with other adverbs.

  -- : IAdv -> Adv -> IAdv ;    -- where in Paris
  AdvIAdv = AE.AdAdv ;

-- Interrogative complements to copulas can be both adverbs and
-- pronouns.
 
  -- : IAdv -> IComp ;
  CompIAdv iadv = iadv ;          -- where (is it)

  -- : IP -> IComp ;
  CompIP ip = { s = ip.s ! Abs } ;  -- who (is it)

{-
-- More $IP$, $IDet$, and $IAdv$ are defined in $Structural$.

-- Wh questions with two or more question words require a new, special category.

  cat 
    QVP ;          -- buy what where
  fun
    ComplSlashIP  : VPSlash -> IP -> QVP ;   -- buys what 
    AdvQVP        : VP  ->   IAdv -> QVP ;   -- lives where 
    AddAdvQVP     : QVP ->   IAdv -> QVP ;   -- buys what where 

    QuestQVP      : IP -> QVP -> QCl ;       -- who buys what where
-}

}