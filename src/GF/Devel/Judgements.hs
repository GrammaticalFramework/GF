module GF.Devel.Judgements where

import GF.Devel.Terms
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

