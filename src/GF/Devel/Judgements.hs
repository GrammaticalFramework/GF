module GF.Devel.Judgements where

import GF.Devel.Terms
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad
import Data.Map

data Judgement = Judgement {
  jform :: JudgementForm,  -- cat         fun        oper    param
  jtype :: Type,           -- context     type       type    type
  jdef  :: Term,           -- lindef      def        -       values
  jlin  :: Term,           -- lincat      lin        def     constructors
  jprintname :: Term       -- printname   printname  -       -
  }

data JudgementForm =
    JCat
  | JFun
  | JOper
  | JParam
  deriving Eq

-- constructing judgements from parse tree

emptyJudgement :: JudgementForm -> Judgement
emptyJudgement form = Judgement form meta meta meta meta where
  meta = Meta 0

absCat :: Context -> Judgement
absCat co = (emptyJudgement JCat) {jtype = Sort "Type"} ---- works for empty co

absFun :: Type -> Judgement
absFun ty = (emptyJudgement JFun) {jtype = ty}

cncCat :: Type -> Judgement
cncCat ty = (emptyJudgement JCat) {jlin = ty}

cncFun :: Term -> Judgement
cncFun tr = (emptyJudgement JFun) {jlin = tr}

resOperType :: Type -> Judgement
resOperType ty = (emptyJudgement JOper) {jtype = ty}

resOperDef :: Term -> Judgement
resOperDef tr = (emptyJudgement JOper) {jlin = tr}

resOper :: Type -> Term -> Judgement
resOper ty tr = (emptyJudgement JOper) {jtype = ty, jlin = tr}

-- unifying contents of judgements

unifyJudgement :: Judgement -> Judgement -> Err Judgement
unifyJudgement old new = do
  testErr (jform old == jform new) "different judment forms"
  [jty,jde,jli,jpri] <- mapM unifyField [jtype,jdef,jlin,jprintname]
  return $ old{jtype = jty, jdef = jde, jlin = jli, jprintname = jpri}
 where
   unifyField field = unifyTerm (field old) (field new)
   unifyTerm oterm nterm = case (oterm,nterm) of
     (Meta _,t) -> return t
     (t,Meta _) -> return t
     _ -> testErr (nterm == oterm) "incompatible fields" >> return nterm

