module Transfer.Interpreter where

import Transfer.Core.Abs
import Transfer.Core.Print

import Control.Monad
import Data.List
import Data.Maybe

import Debug.Trace

data Value = VStr String
           | VInt Integer
           | VType
           | VRec [(CIdent,Value)]
           | VClos Env PatternVariable Exp
           | VCons CIdent [Value]
           | VPrim (Value -> Value)
  deriving (Show)

instance Show (a -> b) where
    show _ = "<<function>>"

--
-- * Environment
--

newtype Env = Env [(CIdent,Value)]
    deriving Show

mkEnv :: [(CIdent,Value)] -> Env
mkEnv = Env

addToEnv :: [(CIdent,Value)] -> Env -> Env
addToEnv bs (Env e) = Env (bs ++ e)

lookupEnv :: Env -> CIdent -> Value
lookupEnv (Env e) id = 
    case lookup id e of
        Just x -> x
        Nothing -> error $ "Variable " ++ printTree id ++ " not in environment."
                           ++ " Environment contains: " ++ show (map (printTree . fst) e)

prEnv :: Env -> String
prEnv (Env e) = unlines [ printTree id ++ ": " ++ printValue v | (id,v) <- e ]

-- | The built-in types and functions.
builtin :: Env
builtin = 
    mkEnv [(CIdent "Int",VType),
           (CIdent "String",VType),
           mkIntUn  "neg" negate,
           mkIntBin "add" (+),
           mkIntBin "sub" (-),
           mkIntBin "mul" (*),
           mkIntBin "div" div,
           mkIntBin "mod" mod,
           mkIntCmp "lt"  (<),
           mkIntCmp "le"  (<=),
           mkIntCmp "gt"  (>),
           mkIntCmp "ge"  (>=),
           mkIntCmp "eq"  (==),
           mkIntCmp "ne"  (/=)]
  where 
  mkIntUn x f = let c = CIdent ("prim_"++x++"_Int")
                 in (c, VPrim (\n -> appInt1 (VInt . f) n))
  mkIntBin x f = let c = CIdent ("prim_"++x++"_Int")
                  in (c, VPrim (\n -> VPrim (\m -> appInt2 (\n m -> VInt (f n m)) n m )))
  mkIntCmp x f = let c = CIdent ("prim_"++x++"_Int")
                  in (c, VPrim (\n -> VPrim (\m -> appInt2 (\n m -> toBool (f n m)) n m)))
  toBool b = VCons (CIdent (if b then "True" else "False")) []
  appInt1 f x = case x of
                         VInt n -> f n
                         _ -> error $ printValue x ++ " is not an integer" -- VCons c [x]
  appInt2 f x y = case (x,y) of
                         (VInt n,VInt m) -> f n m
                         _ -> error $ printValue x ++ " and " ++ printValue y ++ " are not both integers" -- VCons c [x,y]

addModuleEnv :: Env -> Module -> Env
addModuleEnv env (Module ds) = 
    let bs = [ (c,VCons c []) | DataDecl _ _ cs <- ds, ConsDecl c _ <- cs ] 
             ++ [ (t,VCons t []) | DataDecl t _  _ <- ds ] 
             ++ [ (x,eval env' e) | ValueDecl x e <- ds]
        env' = addToEnv bs env
     in env'

--
-- * Evaluation.
--

eval :: Env -> Exp -> Value
eval env x = case x of
  ELet defs exp2 -> 
      let env' = deepSeqList [ v `seq` (id, v) | LetDef id _ e <- defs, 
                                                 let v = eval env' e] 
                 `addToEnv` env
       in eval env' exp2
  ECase exp cases -> 
      let v = eval env exp
          r = case firstMatch v cases of
                  Nothing -> error $ "No pattern matched " ++ printValue v
                  Just (e,bs) -> eval (bs `addToEnv` env) e
       in v `seq` r
  EAbs id exp -> VClos env id $! exp
  -- FIXME: what to do?
  -- EPi id _ exp  -> VClos env id $! exp
  EApp exp1 exp2 -> let v1 = eval env exp1
                        v2 = eval env exp2
                     in case v1 of
                               VClos env' id e -> eval (bind id v2 `addToEnv` env') e
                               VPrim f -> f $! v2
                               VCons c vs -> (VCons $! c) $! ((++) $! vs) $! [v2]
                               _ -> error $ "Bad application (" ++ printValue v1 ++ ") (" ++ printValue v2 ++ ")"
  EProj exp id  -> let v = eval env exp
                    in case v of
                               VRec fs -> recLookup id fs
                               _ -> error $ printValue v ++ " is not a record, cannot get field " ++ printTree id

  EEmptyRec  -> VRec []
  ERecType fts -> VRec $! deepSeqList $! [ v `seq` (f,v) | FieldType  f e <- fts, let v = eval env e]
  ERec fvs     -> VRec $! deepSeqList $! [ v `seq` (f,v) | FieldValue f e <- fvs, let v = eval env e]
  EVar id  -> lookupEnv env id
  EType  -> VType
  EStr str  -> VStr str
  EInt n  -> VInt n

firstMatch :: Value -> [Case] -> Maybe (Exp,[(CIdent,Value)])
firstMatch _ [] = Nothing
firstMatch v (Case p e:cs) = case match p v of
                                            Nothing -> firstMatch v cs
                                            Just env -> Just (e,env)

bind :: PatternVariable -> Value -> [(CIdent,Value)]
bind (PVVar x) v = [(x,v)]
bind PVWild _ = []

match :: Pattern -> Value -> Maybe [(CIdent,Value)]
match (PCons c' ps) (VCons c vs) 
    | c == c' = if length vs == length ps 
                 then concatM $ zipWith match ps vs
                 else error $ "Wrong number of arguments to " ++ printTree c
match (PVar x) v                   = Just (bind x v)
match (PRec fps) (VRec fs) = concatM [ match p (recLookup f fs) | FieldPattern f p <- fps ]
match (PInt i) (VInt i') | i == i' = Just []
match PType VType                  = Just []
match (PStr s) (VStr s') | s == s' = Just []
match (PInt i) (VInt i') | i == i' = Just []
match _ _ = Nothing


recLookup :: CIdent -> [(CIdent,Value)] -> Value
recLookup l fs = 
    case lookup l fs of
        Just x -> x
        Nothing -> error $ printValue (VRec fs) ++ " has no field " ++ printTree l

--
-- * Utilities
--

concatM :: Monad m => [m [a]] -> m [a]
concatM = liftM concat . sequence

-- | Force a list and its values.
deepSeqList :: [a] -> [a]
deepSeqList = foldr (\x xs -> x `seq` xs `seq` (x:xs)) []

--
-- * Convert values to expressions
--

valueToExp :: Value -> Exp
valueToExp v = 
    case v of
           VStr s     -> EStr s
           VInt i     -> EInt i
           VType      -> EType
           VRec fs    -> ERec [ FieldValue f (valueToExp v) | (f,v) <- fs]
           VClos _ id e  -> EAbs id e
           -- FIXME: what do we do with VPi?
           -- VPi id e   -> EPi id (EVar (CIdent "_")) e -- FIXME: should be a meta variable or something
           VCons c vs -> foldl EApp (EVar c) (map valueToExp vs)
           VPrim _    -> EVar (CIdent "<<primitive>>") -- FIXME: what to return here?

--
-- * Pretty printing of values
--

printValue :: Value -> String
printValue v = printTree (valueToExp v)
{-
  prValue 0 0 v ""
  where
  prValue p n v = case v of
              VStr s     -> shows s
              VInt i     -> shows i
              VType      -> showString "Type"
              VRec cs    -> showChar '{' . joinS (showChar ';') 
                               (map prField cs) . showChar '}'
              VAbs id e  -> showString "<<function>>"
                            -- let x = "$"++show n
                            -- in showChar '\\' . showString (x++" -> ") 
                            --        . prValue 0 (n+1) (f (VCons (CIdent x) [])) -- hacky to use VCons

              VPi f      -> showString "<<function type>>"
              VCons c [] -> showIdent c
              VCons c vs -> parenth (showIdent c . concatS (map (\v -> spaceS . prValue 1 n v) vs))
              VPrim _    -> "<<primitive>>"
   where prField (i,v) = showIdent i . showChar '=' . prValue 0 n v
         parenth s = if p > 0 then showChar '(' . s . showChar ')' else s
  showIdent (CIdent i) = showString i
-}

spaceS :: ShowS
spaceS = showChar ' '

joinS :: ShowS -> [ShowS] -> ShowS
joinS glue = concatS . intersperse glue
