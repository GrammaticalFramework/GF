module GF.Devel.Grammar.MkJudgements where

import GF.Devel.Grammar.Macros
import GF.Devel.Grammar.Judgements
import GF.Devel.Grammar.Terms
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad
import Data.Map

-- constructing judgements from parse tree

emptyJudgement :: JudgementForm -> Judgement
emptyJudgement form = Judgement form meta meta meta where
  meta = Meta 0

addJType :: Type -> Judgement -> Judgement
addJType tr ju = ju {jtype = tr}

addJDef :: Term -> Judgement -> Judgement
addJDef tr ju = ju {jdef = tr}

addJPrintname :: Term -> Judgement -> Judgement
addJPrintname tr ju = ju {jprintname = tr}


absCat :: Context -> Judgement
absCat co = addJType (mkProd co typeType) (emptyJudgement JCat)

absFun :: Type -> Judgement
absFun ty = addJType ty (emptyJudgement JFun)

cncCat :: Type -> Judgement
cncCat ty = addJType ty (emptyJudgement JLincat)

cncFun :: Term -> Judgement
cncFun tr = addJDef tr (emptyJudgement JLin)

resOperType :: Type -> Judgement
resOperType ty = addJType ty (emptyJudgement JOper)

resOperDef :: Term -> Judgement
resOperDef tr = addJDef tr (emptyJudgement JOper)

resOper :: Type -> Term -> Judgement
resOper ty tr = addJDef tr (resOperType ty)

resOverload :: [(Type,Term)] -> Judgement
resOverload tts = resOperDef (Overload tts)

-- param p = ci gi  is encoded as p : ((ci : gi) -> EData) -> Type
-- we use EData instead of p to make circularity check easier  
resParam :: [(Ident,Context)] -> Judgement
resParam cos = addJType constrs (emptyJudgement JParam) where
  constrs = mkProd [(c,mkProd co EData) | (c,co) <- cos] typeType

-- to enable constructor type lookup:
-- create an oper for each constructor p = c g, as c : g -> p = EData
paramConstructors :: Ident -> [(Ident,Context)] -> [(Ident,Judgement)]
paramConstructors p cs = 
  [(c,resOper (mkProd co (Con p)) EData) | (c,co) <- cs]

-- unifying contents of judgements

unifyJudgement :: Judgement -> Judgement -> Err Judgement
unifyJudgement old new = do
  testErr (jform old == jform new) "different judment forms"
  [jty,jde,jpri] <- mapM unifyField [jtype,jdef,jprintname]
  return $ old{jtype = jty, jdef = jde, jprintname = jpri}
 where
   unifyField field = unifyTerm (field old) (field new)
   unifyTerm oterm nterm = case (oterm,nterm) of
     (Meta _,t) -> return t
     (t,Meta _) -> return t
     _ -> testErr (nterm == oterm) "incompatible fields" >> return nterm

