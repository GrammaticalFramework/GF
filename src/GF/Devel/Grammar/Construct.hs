module GF.Devel.Grammar.Construct where

import GF.Devel.Grammar.Grammar
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad
import Data.Map
import Debug.Trace (trace)

------------------
-- abstractions on Grammar, constructing objects
------------------

-- abstractions on GF

emptyGF :: GF
emptyGF = GF Nothing [] empty empty

type SourceModule = (Ident,Module)

listModules :: GF -> [SourceModule]
listModules = assocs.gfmodules

addModule :: Ident -> Module -> GF -> GF
addModule c m gf = gf {gfmodules = insert c m (gfmodules gf)}

gfModules :: [(Ident,Module)] -> GF
gfModules ms = emptyGF {gfmodules = fromList ms}

-- abstractions on Module

emptyModule :: Module
emptyModule = Module MTGrammar True [] [] [] [] empty empty

isCompleteModule :: Module -> Bool
isCompleteModule = miscomplete

isInterface :: Module -> Bool
isInterface m = case mtype m of
  MTInterface -> True
  MTAbstract -> True
  _ -> False

interfaceName :: Module -> Maybe Ident
interfaceName mo = case mtype mo of
  MTInstance i -> return i
  MTConcrete i -> return i
  _ -> Nothing

listJudgements :: Module -> [(Ident,Judgement)]
listJudgements = assocs . mjments

isInherited :: MInclude -> Ident -> Bool
isInherited mi i = case mi of
  MIExcept is -> notElem i is
  MIOnly is -> elem i is
  _ -> True

-- abstractions on Judgement

isConstructor :: Judgement -> Bool
isConstructor j = jdef j == EData

isLink :: Judgement -> Bool
isLink j = jform j == JLink

-- constructing judgements from parse tree

emptyJudgement :: JudgementForm -> Judgement
emptyJudgement form = Judgement form meta meta meta (identC "#NOLINK") 0 where
  meta = Meta 0

addJType :: Type -> Judgement -> Judgement
addJType tr ju = ju {jtype = tr}

addJDef :: Term -> Judgement -> Judgement
addJDef tr ju = ju {jdef = tr}

addJPrintname :: Term -> Judgement -> Judgement
addJPrintname tr ju = ju {jprintname = tr}

linkInherited :: Bool -> Ident -> Judgement
linkInherited can mo = (emptyJudgement JLink){
  jlink = mo,
  jdef = if can then EData else Meta 0
  }

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

-- param p = ci gi  is encoded as p : ((ci : gi) -> p) -> Type
-- we use EData instead of p to make circularity check easier  
resParam :: Ident -> [(Ident,Context)] -> Judgement
resParam p cos = addJDef (EParam cos) (emptyJudgement JParam)

-- to enable constructor type lookup:
-- create an oper for each constructor p = c g, as c : g -> p = EData
paramConstructors :: Ident -> [(Ident,Context)] -> [(Ident,Judgement)]
paramConstructors p cs = [(c,resOper (mkProd co (Con p)) EData) | (c,co) <- cs]

-- unifying contents of judgements

---- used in SourceToGF; make error-free and informative
unifyJudgements j k = case unifyJudgement j k of
  Ok l -> l
  Bad s -> error s

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
     _ -> do
       if (nterm /= oterm) 
          then (trace (unwords ["illegal update of",show oterm,"to",show nterm]) 
                (return ()))
          else return () ---- to recover from spurious qualification conflicts
----       testErr (nterm == oterm) 
----               (unwords ["illegal update of",prt oterm,"to",prt nterm])
       return nterm

updateJudgement :: Ident -> Ident -> Judgement -> GF -> Err GF
updateJudgement m c ju gf = do
  mo  <- maybe (Bad (show m)) return $ Data.Map.lookup m $ gfmodules gf
  let mo' = mo {mjments = insert c ju (mjments mo)}
  return $ gf {gfmodules = insert m mo' (gfmodules gf)}

-- abstractions on Term

type Cat  = QIdent
type Fun  = QIdent
type QIdent = (Ident,Ident)

-- | branches à la Alfa
newtype Branch = Branch (Con,([Ident],Term)) deriving (Eq, Ord,Show,Read)
type Con = Ident ---

varLabel :: Int -> Label
varLabel = LVar

wildPatt :: Patt
wildPatt = PW

type Trm = Term

mkProd :: Context -> Type -> Type
mkProd = flip (foldr (uncurry Prod))

-- type constants

typeType :: Type
typeType = Sort "Type"

typePType :: Type
typePType = Sort "PType"

typeStr :: Type
typeStr = Sort "Str"

typeTok :: Type      ---- deprecated
typeTok = Sort "Tok"  

cPredef :: Ident
cPredef = identC "Predef"

cPredefAbs :: Ident
cPredefAbs = identC "PredefAbs"

typeString, typeFloat, typeInt :: Term
typeInts :: Integer -> Term

typeString = constPredefRes "String"
typeInt = constPredefRes "Int"
typeFloat = constPredefRes "Float"
typeInts i = App (constPredefRes "Ints") (EInt i)

isTypeInts :: Term -> Bool
isTypeInts ty = case ty of
  App c _ -> c == constPredefRes "Ints"
  _ -> False

cnPredef = constPredefRes

constPredefRes :: String -> Term
constPredefRes s = Q (IC "Predef") (identC s)

isPredefConstant :: Term -> Bool
isPredefConstant t = case t of
  Q (IC "Predef") _ -> True
  Q (IC "PredefAbs") _ -> True
  _ -> False


