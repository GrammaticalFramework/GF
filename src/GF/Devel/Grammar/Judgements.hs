module GF.Devel.Grammar.Judgements where

import GF.Devel.Grammar.Terms
import GF.Infra.Ident

data Judgement = Judgement {
  jform :: JudgementForm,  -- cat      fun   lincat  lin     oper    param
  jtype :: Type,           -- context  type  lincat  -       type    constrs
  jdef  :: Term,           -- lindef   def   lindef  lin     def     values
  jprintname :: Term       -- -        -     prname  prname  -       -
  }

data JudgementForm =
    JCat
  | JFun
  | JLincat
  | JLin
  | JOper
  | JParam
  deriving Eq

