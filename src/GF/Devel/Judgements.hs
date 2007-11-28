module GF.Devel.Judgements where

import GF.Devel.Terms
import GF.Infra.Ident

data Judgement = Judgement {
  jform :: JudgementForm,  -- cat         fun        oper    param
  jtype :: Type,           -- context     type       type    constructors
  jdef  :: Term,           -- lindef      def        -       values
  jlin  :: Term,           -- lincat      lin        def     -
  jprintname :: Term       -- printname   printname  -       -
  }

data JudgementForm =
    JCat
  | JFun
  | JOper
  | JParam
  deriving Eq

