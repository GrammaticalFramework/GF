module GF.Devel.MkJudgements where

import GF.Devel.Macros
import GF.Devel.Judgements
import GF.Devel.Terms
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad
import Data.Map

-- constructing judgements from parse tree

emptyJudgement :: JudgementForm -> Judgement
emptyJudgement form = Judgement form meta meta meta meta where
  meta = Meta 0

absCat :: Context -> Judgement
absCat co = (emptyJudgement JCat) {jtype = mkProd co typeType}

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

-- param m.p = c g  is encoded as p : (ci : gi -> EData) -> Type
-- we use EData instead of m.p to make circularity check easier  
resParam :: Ident -> Ident -> [(Ident,Context)] -> Judgement
resParam m p cos = (emptyJudgement JParam) {
  jtype = mkProd [(c,mkProd co EData) | (c,co) <- cos] typeType
  }

-- to enable constructor type lookup:
-- create an oper for each constructor m.p = c g, as c : g -> m.p = EData
paramConstructors :: Ident -> Ident -> [(Ident,Context)] -> [(Ident,Judgement)]
paramConstructors m p cs = 
  [(c,resOper (mkProd co (QC m p)) EData) | (c,co) <- cs]

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

