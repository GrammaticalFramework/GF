module PGF.Expr(Tree(..), Literal(..),                
                readTree, showTree, pTree, ppTree,

                Expr(..), Patt(..), Equation(..),
                readExpr, showExpr, pExpr, ppExpr, ppPatt,

                tree2expr, expr2tree, normalForm,

                -- needed in the typechecker
                Value(..), Env, Funs, eval, apply,

                MetaId,

                -- helpers
                pStr,pFactor,freshName,ppMeta
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

-- | The tree is an evaluated expression in the abstract syntax
-- of the grammar. The type is especially restricted to not
-- allow unapplied lambda abstractions. The tree is used directly 
-- from the linearizer and is produced directly from the parser.
data Tree = 
   Abs [CId] Tree                   -- ^ lambda abstraction. The list of variables is non-empty
 | Var CId                          -- ^ variable
 | Fun CId [Tree]                   -- ^ function application
 | Lit Literal                      -- ^ literal
 | Meta {-# UNPACK #-} !MetaId      -- ^ meta variable
  deriving (Eq, Ord)

-- | An expression represents a potentially unevaluated expression
-- in the abstract syntax of the grammar.
data Expr =
   EAbs CId Expr                    -- ^ lambda abstraction
 | EApp Expr Expr                   -- ^ application
 | ELit Literal                     -- ^ literal
 | EMeta  {-# UNPACK #-} !MetaId    -- ^ meta variable
 | EFun   CId                       -- ^ function or data constructor
 | EVar   {-# UNPACK #-} !Int       -- ^ variable with de Bruijn index
 | ETyped Expr Type
  deriving (Eq,Ord,Show)

-- | The pattern is used to define equations in the abstract syntax of the grammar.
data Patt =
   PApp CId [Patt]                  -- ^ application. The identifier should be constructor i.e. defined with 'data'
 | PLit Literal                     -- ^ literal
 | PVar CId                         -- ^ variable
 | PWild                            -- ^ wildcard
  deriving (Eq,Ord)

-- | The equation is used to define lambda function as a sequence
-- of equations with pattern matching. The list of 'Expr' represents
-- the patterns and the second 'Expr' is the function body for this
-- equation.
data Equation =
   Equ [Patt] Expr
  deriving (Eq,Ord)

-- | parses 'String' as an expression
readTree :: String -> Maybe Tree
readTree s = case [x | (x,cs) <- RP.readP_to_S (pTree False) s, all isSpace cs] of
               [x] -> Just x
               _   -> Nothing

-- | renders expression as 'String'
showTree :: Tree -> String
showTree = PP.render . ppTree 0

instance Show Tree where
    showsPrec i x = showString (PP.render (ppTree i x))

instance Read Tree where
    readsPrec _ = RP.readP_to_S (pTree False)

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


-----------------------------------------------------
-- Parsing
-----------------------------------------------------

pTrees :: RP.ReadP [Tree]
pTrees = liftM2 (:) (pTree True) pTrees RP.<++ (RP.skipSpaces >> return [])

pTree :: Bool -> RP.ReadP Tree
pTree isNested = RP.skipSpaces >> (pParen RP.<++ pAbs RP.<++ pApp RP.<++ fmap Lit pLit RP.<++ fmap Meta pMeta)
  where 
        pParen = RP.between (RP.char '(') (RP.char ')') (pTree False)
        pAbs = do xs <- RP.between (RP.char '\\') (RP.skipSpaces >> RP.string "->") (RP.sepBy1 (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ','))
                  t  <- pTree False
                  return (Abs xs t)
        pApp = do f  <- pCId
                  ts <- (if isNested then return [] else pTrees)
                  return (Fun f ts)

pExpr :: RP.ReadP Expr
pExpr = pExpr0 >>= optTyped
  where
    pExpr0  = RP.skipSpaces >> (pAbs RP.<++ pTerm)

    pTerm   =       fmap (foldl1 EApp) (RP.sepBy1 pFactor RP.skipSpaces)

    pAbs = do xs <- RP.between (RP.char '\\') (RP.skipSpaces >> RP.string "->") (RP.sepBy1 (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ','))
              e  <- pExpr0
              return (foldr EAbs e xs)

    optTyped e = do RP.skipSpaces
                    RP.char ':'
                    RP.skipSpaces
                    ty <- pType
                    return (ETyped e ty)
                 RP.<++
                 return e 
                 
pFactor =       fmap EFun  pCId
        RP.<++  fmap ELit  pLit
        RP.<++  fmap EMeta pMeta
        RP.<++  RP.between (RP.char '(') (RP.char ')') pExpr

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

ppTree d (Abs xs t) = ppParens (d > 0) (PP.char '\\' PP.<>
                                        PP.hsep (PP.punctuate PP.comma (List.map (PP.text . prCId) xs)) PP.<+>
                                        PP.text "->" PP.<+>
                                        ppTree 0 t)
ppTree d (Fun f []) = PP.text (prCId f)
ppTree d (Fun f ts) = ppParens (d > 0) (PP.text (prCId f) PP.<+> PP.hsep (List.map (ppTree 1) ts))
ppTree d (Lit l)    = ppLit l
ppTree d (Meta n)   = ppMeta n
ppTree d (Var id)   = PP.text (prCId id)


ppExpr :: Int -> [CId] -> Expr -> PP.Doc
ppExpr d scope (EAbs x e)   = let (xs,e1) = getVars [x] e
                              in ppParens (d > 1) (PP.char '\\' PP.<>
                                                   PP.hsep (PP.punctuate PP.comma (List.map (PP.text . prCId) (reverse xs))) PP.<+>
                                                   PP.text "->" PP.<+>
                                                   ppExpr 1 (xs++scope) e1)
                              where
                                getVars xs (EAbs x e) = getVars (freshName x xs:xs) e
                                getVars xs e          = (xs,e)
ppExpr d scope (EApp e1 e2) = ppParens (d > 3) ((ppExpr 3 scope e1) PP.<+> (ppExpr 4 scope e2))
ppExpr d scope (ELit l)     = ppLit l
ppExpr d scope (EMeta n)    = ppMeta n
ppExpr d scope (EFun f)     = PP.text (prCId f)
ppExpr d scope (EVar i)     = PP.text (prCId (scope !! i))
ppExpr d scope (ETyped e ty)= ppParens (d > 0) (ppExpr 0 scope e PP.<+> PP.colon PP.<+> ppType 0 scope ty)

ppPatt d scope (PApp f ps) = let (scope',ds) = mapAccumL (ppPatt 2) scope ps
                             in (scope',ppParens (not (List.null ps) && d > 1) (PP.text (prCId f) PP.<+> PP.hsep ds))
ppPatt d scope (PLit l)    = (scope,ppLit l)
ppPatt d scope (PVar f)    = (scope,PP.text (prCId f))
ppPatt d scope PWild       = (scope,PP.char '_')

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
freshName x xs = loop 1 x
  where
    loop i y
      | elem y xs = loop (i+1) (mkCId (show x++"'"++show i))
      | otherwise = y

-----------------------------------------------------
-- Conversion Expr <-> Tree
-----------------------------------------------------

-- | Converts a tree to expression. The conversion
-- is always total, every tree is a valid expression.
tree2expr :: Tree -> Expr
tree2expr = tree2expr []
  where
    tree2expr ys (Fun x ts) = foldl EApp (EFun x) (List.map (tree2expr ys) ts) 
    tree2expr ys (Lit l)    = ELit l
    tree2expr ys (Meta n)   = EMeta n
    tree2expr ys (Abs xs t) = foldr EAbs (tree2expr (reverse xs++ys) t) xs
    tree2expr ys (Var x)    = case List.lookup x (zip ys [0..]) of
                                Just i  -> EVar i
                                Nothing -> error "unknown variable"

-- | Converts an expression to tree. The conversion is only partial.
-- Variables and meta variables of function type and beta redexes are not allowed.
expr2tree :: Expr -> Tree
expr2tree e = abs [] [] e
  where
    abs ys xs (EAbs x e)      = abs ys (x:xs) e
    abs ys xs (ETyped e _)    = abs ys xs e
    abs ys xs e               = case xs of
                                  [] -> app ys [] e
                                  xs -> Abs (reverse xs) (app (xs++ys) [] e)

    app xs as (EApp e1 e2)    = app xs ((abs xs [] e2) : as) e1
    app xs as (ELit l)
               | List.null as = Lit l
               | otherwise    = error "literal of function type encountered"
    app xs as (EMeta n)
               | List.null as = Meta n
               | otherwise    = error "meta variables of function type are not allowed in trees"
    app xs as (EAbs x e)      = error "beta redexes are not allowed in trees"
    app xs as (EVar i)        = Var (xs !! i)
    app xs as (EFun f)        = Fun f as
    app xs as (ETyped e _)    = app xs as e


-----------------------------------------------------
-- Computation
-----------------------------------------------------

-- | Compute an expression to normal form
normalForm :: Funs -> Int -> Env -> Expr -> Expr
normalForm funs k env e = value2expr k (eval funs env e)
  where
    value2expr i (VApp f vs)               = foldl EApp (EFun f)       (List.map (value2expr i) vs)
    value2expr i (VGen j vs)               = foldl EApp (EVar (i-j-1)) (List.map (value2expr i) vs)
    value2expr i (VMeta j env vs)          = foldl EApp (EMeta j)      (List.map (value2expr i) vs)
    value2expr i (VSusp j env vs k)        = value2expr i (k (VGen j vs))
    value2expr i (VLit l)                  = ELit l
    value2expr i (VClosure env (EAbs x e)) = EAbs x (value2expr (i+1) (eval funs ((VGen i []):env) e))

data Value
  = VApp CId [Value]
  | VLit Literal
  | VMeta {-# UNPACK #-} !MetaId Env [Value]
  | VSusp {-# UNPACK #-} !MetaId Env [Value] (Value -> Value)
  | VGen  {-# UNPACK #-} !Int [Value]
  | VClosure Env Expr

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
                              Nothing        -> error ("unknown function "++prCId f)
eval funs env (EApp e1 e2) = apply funs env e1 [eval funs env e2]
eval funs env (EAbs x e)   = VClosure env (EAbs x e)
eval funs env (EMeta i)    = VMeta i env []
eval funs env (ELit l)     = VLit l
eval funs env (ETyped e _) = eval funs env e

apply :: Funs -> Env -> Expr -> [Value] -> Value
apply funs env e            []     = eval funs env e
apply funs env (EVar i)     vs     = applyValue funs (env !! i) vs
apply funs env (EFun f)     vs     = case Map.lookup f funs of
                                       Just (_,a,eqs) -> if a <= length vs
                                                           then let (as,vs') = splitAt a vs
                                                                in match funs f eqs as vs'
                                                           else VApp f vs
                                       Nothing      -> error ("unknown function "++prCId f)
apply funs env (EApp e1 e2) vs     = apply funs env e1 (eval funs env e2 : vs)
apply funs env (EAbs x e)   (v:vs) = apply funs (v:env) e vs
apply funs env (EMeta i)    vs     = VMeta i env vs
apply funs env (ELit l)     vs     = error "literal of function type"
apply funs env (ETyped e _) vs     = apply funs env e vs

applyValue funs v                         []     = v
applyValue funs (VApp f  vs0)             vs     = apply funs [] (EFun f) (vs0++vs)
applyValue funs (VLit _)                  vs     = error "literal of function type"
applyValue funs (VMeta i env vs0)         vs     = VMeta i env (vs0++vs)
applyValue funs (VGen  i vs0)             vs     = VGen  i (vs0++vs)
applyValue funs (VSusp i env vs0 k)       vs     = VSusp i env vs0 (\v -> applyValue funs (k v) vs)
applyValue funs (VClosure env (EAbs x e)) (v:vs) = apply funs (v:env) e vs

-----------------------------------------------------
-- Pattern matching
-----------------------------------------------------

match :: Funs -> CId -> [Equation] -> [Value] -> [Value] -> Value
match sig f eqs as0 vs0 =
  case eqs of
    []               -> VApp f (as0++vs0)
    (Equ ps res):eqs -> tryMatches eqs ps as0 res []
  where
    tryMatches eqs []     []     res env = apply sig env res vs0
    tryMatches eqs (p:ps) (a:as) res env = tryMatch p a env
      where
        tryMatch (PVar x     ) (v                ) env            = tryMatches eqs  ps        as  res (v:env)
        tryMatch (PWild      ) (_                ) env            = tryMatches eqs  ps        as  res env
        tryMatch (p          ) (VMeta i envi vs  ) env            = VSusp i envi vs (\v -> tryMatch p v env)
        tryMatch (p          ) (VGen  i vs       ) env            = VApp f (as0++vs0)
        tryMatch (p          ) (VSusp i envi vs k) env            = VSusp i envi vs (\v -> tryMatch p (k v) env)
        tryMatch (PApp f1 ps1) (VApp f2 vs2      ) env | f1 == f2 = tryMatches eqs (ps1++ps) (vs2++as) res env
        tryMatch (PLit l1    ) (VLit l2          ) env | l1 == l2 = tryMatches eqs  ps        as  res env
        tryMatch _             _                   env            = match sig f eqs as0 vs0

