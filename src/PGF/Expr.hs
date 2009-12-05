module PGF.Expr(Tree, BindType(..), Expr(..), Literal(..), Patt(..), Equation(..),
                readExpr, showExpr, pExpr, pBinds, ppExpr, ppPatt,

                mkApp,    unApp,
                mkStr,    unStr,
                mkInt,    unInt,
                mkDouble, unDouble,
                mkMeta,   isMeta,

                normalForm,

                -- needed in the typechecker
                Value(..), Env, Funs, eval, apply,

                MetaId,

                -- helpers
                pMeta,pStr,pArg,pLit,freshName,ppMeta,ppLit,ppParens
               ) where

import PGF.CId
import PGF.Type

import Data.Char
import Data.Maybe
import Data.List as List
import Data.Map as Map hiding (showTree)
import Control.Monad
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP

data Literal = 
   LStr String                      -- ^ string constant
 | LInt Integer                     -- ^ integer constant
 | LFlt Double                      -- ^ floating point constant
 deriving (Eq,Ord,Show)

type MetaId = Int

data BindType = 
    Explicit
  | Implicit
  deriving (Eq,Ord,Show)

-- | Tree is the abstract syntax representation of a given sentence
-- in some concrete syntax. Technically 'Tree' is a type synonym
-- of 'Expr'.
type Tree = Expr

-- | An expression in the abstract syntax of the grammar. It could be
-- both parameter of a dependent type or an abstract syntax tree for
-- for some sentence.
data Expr =
   EAbs BindType CId Expr           -- ^ lambda abstraction
 | EApp Expr Expr                   -- ^ application
 | ELit Literal                     -- ^ literal
 | EMeta  {-# UNPACK #-} !MetaId    -- ^ meta variable
 | EFun   CId                       -- ^ function or data constructor
 | EVar   {-# UNPACK #-} !Int       -- ^ variable with de Bruijn index
 | ETyped Expr Type                 -- ^ local type signature
 | EImplArg Expr                    -- ^ implicit argument in expression
  deriving (Eq,Ord,Show)

-- | The pattern is used to define equations in the abstract syntax of the grammar.
data Patt =
   PApp CId [Patt]                  -- ^ application. The identifier should be constructor i.e. defined with 'data'
 | PLit Literal                     -- ^ literal
 | PVar CId                         -- ^ variable
 | PWild                            -- ^ wildcard
 | PImplArg Patt                    -- ^ implicit argument in pattern
  deriving (Eq,Ord)

-- | The equation is used to define lambda function as a sequence
-- of equations with pattern matching. The list of 'Expr' represents
-- the patterns and the second 'Expr' is the function body for this
-- equation.
data Equation =
   Equ [Patt] Expr
  deriving (Eq,Ord)

-- | parses 'String' as an expression
readExpr :: String -> Maybe Expr
readExpr s = case [x | (x,cs) <- RP.readP_to_S pExpr s, all isSpace cs] of
               [x] -> Just x
               _   -> Nothing

-- | renders expression as 'String'. The list
-- of identifiers is the list of all free variables
-- in the expression in order reverse to the order
-- of binding.
showExpr :: [CId] -> Expr -> String
showExpr vars = PP.render . ppExpr 0 vars

instance Read Expr where
    readsPrec _ = RP.readP_to_S pExpr

-- | Constructs an expression by applying a function to a list of expressions
mkApp :: CId -> [Expr] -> Expr
mkApp f es = foldl EApp (EFun f) es

-- | Decomposes an expression into application of function
unApp :: Expr -> Maybe (CId,[Expr])
unApp = extract []
  where
    extract es (EFun f)     = Just (f,es)
    extract es (EApp e1 e2) = extract (e2:es) e1
    extract es _            = Nothing

-- | Constructs an expression from string literal
mkStr :: String -> Expr
mkStr s = ELit (LStr s)

-- | Decomposes an expression into string literal
unStr :: Expr -> Maybe String
unStr (ELit (LStr s)) = Just s
unStr _               = Nothing

-- | Constructs an expression from integer literal
mkInt :: Integer -> Expr
mkInt i = ELit (LInt i)

-- | Decomposes an expression into integer literal
unInt :: Expr -> Maybe Integer
unInt (ELit (LInt i)) = Just i
unInt _               = Nothing

-- | Constructs an expression from real number literal
mkDouble :: Double -> Expr
mkDouble f = ELit (LFlt f)

-- | Decomposes an expression into real number literal
unDouble :: Expr -> Maybe Double
unDouble (ELit (LFlt f)) = Just f
unDouble _               = Nothing

-- | Constructs an expression which is meta variable
mkMeta :: Expr
mkMeta = EMeta 0

-- | Checks whether an expression is a meta variable
isMeta :: Expr -> Bool
isMeta (EMeta _) = True
isMeta _         = False

-----------------------------------------------------
-- Parsing
-----------------------------------------------------

pExpr :: RP.ReadP Expr
pExpr = RP.skipSpaces >> (pAbs RP.<++ pTerm)
  where
    pTerm = do f <- pFactor
               RP.skipSpaces
               as <- RP.sepBy pArg RP.skipSpaces
               return (foldl EApp f as)

    pAbs = do xs <- RP.between (RP.char '\\') (RP.skipSpaces >> RP.string "->") pBinds
              e  <- pExpr
              return (foldr (\(b,x) e -> EAbs b x e) e xs)

pBinds :: RP.ReadP [(BindType,CId)]
pBinds = do xss <- RP.sepBy1 (RP.skipSpaces >> pBind) (RP.skipSpaces >> RP.char ',')
            return (concat xss)
  where
    pCIdOrWild = pCId `mplus` (RP.char '_' >> return wildCId)

    pBind = 
      do x <- pCIdOrWild
         return [(Explicit,x)]
      `mplus`
      RP.between (RP.char '{')
                 (RP.skipSpaces >> RP.char '}')
                 (RP.sepBy1 (RP.skipSpaces >> pCIdOrWild >>= \id -> return (Implicit,id)) (RP.skipSpaces >> RP.char ','))

pArg = fmap EImplArg (RP.between (RP.char '{') (RP.char '}') pExpr)
       RP.<++
       pFactor

pFactor =       fmap EFun  pCId
        RP.<++  fmap ELit  pLit
        RP.<++  fmap EMeta pMeta
        RP.<++  RP.between (RP.char '(') (RP.char ')') pExpr
        RP.<++  RP.between (RP.char '<') (RP.char '>') pTyped

pTyped = do RP.skipSpaces
            e <- pExpr
            RP.skipSpaces
            RP.char ':'
            RP.skipSpaces
            ty <- pType
            return (ETyped e ty)

pMeta = do RP.char '?'
           return 0

pLit :: RP.ReadP Literal
pLit = pNum RP.<++ liftM LStr pStr

pNum = do x <- RP.munch1 isDigit
          ((RP.char '.' >> RP.munch1 isDigit >>= \y -> return (LFlt (read (x++"."++y))))
           RP.<++
           (return (LInt (read x))))

pStr = RP.char '"' >> (RP.manyTill (pEsc RP.<++ RP.get) (RP.char '"'))
       where
         pEsc = RP.char '\\' >> RP.get    


-----------------------------------------------------
-- Printing
-----------------------------------------------------

ppExpr :: Int -> [CId] -> Expr -> PP.Doc
ppExpr d scope (EAbs b x e) = let (bs,xs,e1) = getVars [] [] (EAbs b x e)
                              in ppParens (d > 1) (PP.char '\\' PP.<>
                                                   PP.hsep (PP.punctuate PP.comma (reverse (List.zipWith ppBind bs xs))) PP.<+>
                                                   PP.text "->" PP.<+>
                                                   ppExpr 1 (xs++scope) e1)
                              where
                                getVars bs xs (EAbs b x e) = getVars (b:bs) ((freshName x xs):xs) e
                                getVars bs xs e            = (bs,xs,e)
ppExpr d scope (EApp e1 e2) = ppParens (d > 3) ((ppExpr 3 scope e1) PP.<+> (ppExpr 4 scope e2))
ppExpr d scope (ELit l)     = ppLit l
ppExpr d scope (EMeta n)    = ppMeta n
ppExpr d scope (EFun f)     = ppCId f
ppExpr d scope (EVar i)     = ppCId (scope !! i)
ppExpr d scope (ETyped e ty)= PP.char '<' PP.<> ppExpr 0 scope e PP.<+> PP.colon PP.<+> ppType 0 scope ty PP.<> PP.char '>'
ppExpr d scope (EImplArg e) = PP.braces (ppExpr 0 scope e)

ppPatt :: Int -> [CId] -> Patt -> ([CId],PP.Doc)
ppPatt d scope (PApp f ps) = let (scope',ds) = mapAccumL (ppPatt 2) scope ps
                             in (scope',ppParens (not (List.null ps) && d > 1) (ppCId f PP.<+> PP.hsep ds))
ppPatt d scope (PLit l)    = (scope,ppLit l)
ppPatt d scope (PVar f)    = (f:scope,ppCId f)
ppPatt d scope PWild       = (scope,PP.char '_')
ppPatt d scope (PImplArg p) = let (scope',d) = ppPatt 0 scope p
                              in (scope',PP.braces d)

ppBind Explicit x = ppCId x
ppBind Implicit x = PP.braces (ppCId x)

ppLit (LStr s) = PP.text (show s)
ppLit (LInt n) = PP.integer n
ppLit (LFlt d) = PP.double d

ppMeta :: MetaId -> PP.Doc
ppMeta n
  | n == 0    = PP.char '?'
  | otherwise = PP.char '?' PP.<> PP.int n

ppParens True  = PP.parens
ppParens False = id

freshName :: CId -> [CId] -> CId
freshName x xs0 = loop 1 x
  where
    xs = wildCId : xs0

    loop i y
      | elem y xs = loop (i+1) (mkCId (show x++show i))
      | otherwise = y


-----------------------------------------------------
-- Computation
-----------------------------------------------------

-- | Compute an expression to normal form
normalForm :: Funs -> Int -> Env -> Expr -> Expr
normalForm funs k env e = value2expr k (eval funs env e)
  where
    value2expr i (VApp f vs)                 = foldl EApp (EFun f)       (List.map (value2expr i) vs)
    value2expr i (VGen j vs)                 = foldl EApp (EVar (i-j-1)) (List.map (value2expr i) vs)
    value2expr i (VMeta j env vs)            = foldl EApp (EMeta j)      (List.map (value2expr i) vs)
    value2expr i (VSusp j env vs k)          = value2expr i (k (VGen j vs))
    value2expr i (VLit l)                    = ELit l
    value2expr i (VClosure env (EAbs b x e)) = EAbs b x (value2expr (i+1) (eval funs ((VGen i []):env) e))
    value2expr i (VImplArg v)                = EImplArg (value2expr i v)

data Value
  = VApp CId [Value]
  | VLit Literal
  | VMeta {-# UNPACK #-} !MetaId Env [Value]
  | VSusp {-# UNPACK #-} !MetaId Env [Value] (Value -> Value)
  | VGen  {-# UNPACK #-} !Int [Value]
  | VClosure Env Expr
  | VImplArg Value

type Funs = Map.Map CId (Type,Int,[Equation]) -- type and def of a fun
type Env  = [Value]

eval :: Funs -> Env -> Expr -> Value
eval funs env (EVar i)     = env !! i
eval funs env (EFun f)     = case Map.lookup f funs of
                              Just (_,a,eqs) -> if a == 0
                                                  then case eqs of
                                                         Equ [] e : _ -> eval funs [] e
                                                         _            -> VApp f []
                                                  else VApp f []
                              Nothing        -> error ("unknown function "++showCId f)
eval funs env (EApp e1 e2) = apply funs env e1 [eval funs env e2]
eval funs env (EAbs b x e) = VClosure env (EAbs b x e)
eval funs env (EMeta i)    = VMeta i env []
eval funs env (ELit l)     = VLit l
eval funs env (ETyped e _) = eval funs env e
eval funs env (EImplArg e) = VImplArg (eval funs env e)

apply :: Funs -> Env -> Expr -> [Value] -> Value
apply funs env e            []     = eval funs env e
apply funs env (EVar i)     vs     = applyValue funs (env !! i) vs
apply funs env (EFun f)     vs     = case Map.lookup f funs of
                                       Just (_,a,eqs) -> if a <= length vs
                                                           then let (as,vs') = splitAt a vs
                                                                in match funs f eqs as vs'
                                                           else VApp f vs
                                       Nothing      -> error ("unknown function "++showCId f)
apply funs env (EApp e1 e2) vs     = apply funs env e1 (eval funs env e2 : vs)
apply funs env (EAbs _ x e) (v:vs) = apply funs (v:env) e vs
apply funs env (EMeta i)    vs     = VMeta i env vs
apply funs env (ELit l)     vs     = error "literal of function type"
apply funs env (ETyped e _) vs     = apply funs env e vs
apply funs env (EImplArg _) vs     = error "implicit argument in function position"

applyValue funs v                         []       = v
applyValue funs (VApp f  vs0)             vs       = apply funs [] (EFun f) (vs0++vs)
applyValue funs (VLit _)                  vs       = error "literal of function type"
applyValue funs (VMeta i env vs0)         vs       = VMeta i env (vs0++vs)
applyValue funs (VGen  i vs0)             vs       = VGen  i (vs0++vs)
applyValue funs (VSusp i env vs0 k)       vs       = VSusp i env vs0 (\v -> applyValue funs (k v) vs)
applyValue funs (VClosure env (EAbs b x e)) (v:vs) = apply funs (v:env) e vs
applyValue funs (VImplArg _)              vs       = error "implicit argument in function position"

-----------------------------------------------------
-- Pattern matching
-----------------------------------------------------

match :: Funs -> CId -> [Equation] -> [Value] -> [Value] -> Value
match funs f eqs as0 vs0 =
  case eqs of
    []               -> VApp f (as0++vs0)
    (Equ ps res):eqs -> tryMatches eqs ps as0 res []
  where
    tryMatches eqs []     []     res env = apply funs env res vs0
    tryMatches eqs (p:ps) (a:as) res env = tryMatch p a env
      where
        tryMatch (PVar x     ) (v                ) env            = tryMatches eqs  ps        as  res (v:env)
        tryMatch (PWild      ) (_                ) env            = tryMatches eqs  ps        as  res env
        tryMatch (p          ) (VMeta i envi vs  ) env            = VSusp i envi vs (\v -> tryMatch p v env)
        tryMatch (p          ) (VGen  i vs       ) env            = VApp f (as0++vs0)
        tryMatch (p          ) (VSusp i envi vs k) env            = VSusp i envi vs (\v -> tryMatch p (k v) env)
        tryMatch (PApp f1 ps1) (VApp f2 vs2      ) env | f1 == f2 = tryMatches eqs (ps1++ps) (vs2++as) res env
        tryMatch (PLit l1    ) (VLit l2          ) env | l1 == l2 = tryMatches eqs  ps        as  res env
        tryMatch (PImplArg p ) (VImplArg v       ) env            = tryMatch p v env
        tryMatch _             _                   env            = match funs f eqs as0 vs0

