module Transfer.Interpreter where

import Transfer.Core.Abs
import Transfer.Core.Print

import Control.Monad
import Data.List
import Data.Maybe

import Debug.Trace

data Value = VStr String
           | VInt Integer
           | VDbl Double
           | VType
           | VRec [(CIdent,Value)]
           | VClos Env Exp
           | VCons CIdent [Value]
           | VPrim (Value -> Value)
           | VMeta Integer
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

seqEnv :: Env -> Env
seqEnv (Env e) = Env $! deepSeqList [ fst p `seq` p | p <- e ]

-- | The built-in types and functions.
builtin :: Env
builtin = 
    mkEnv [(CIdent "Integer",VType),
           (CIdent "Double",VType),
           (CIdent "String",VType),
           mkIntUn  "neg"  negate  toInt,
           mkIntBin "add"  (+)     toInt,
           mkIntBin "sub"  (-)     toInt,
           mkIntBin "mul"  (*)     toInt,
           mkIntBin "div"  div     toInt,
           mkIntBin "mod"  mod     toInt,
           mkIntBin "eq"   (==)    toBool,
           mkIntBin "cmp"  compare toOrd,
           mkIntUn  "show" show    toStr,
           mkDblUn  "neg"  negate  toDbl,
           mkDblBin "add"  (+)     toDbl,
           mkDblBin "sub"  (-)     toDbl,
           mkDblBin "mul"  (*)     toDbl,
           mkDblBin "div"  (/)     toDbl,
           mkDblBin "mod"  (\_ _ -> 0.0) toDbl,
           mkDblBin "eq"   (==)    toBool,
           mkDblBin "cmp"  compare toOrd,
           mkDblUn  "show" show    toStr,
           mkStrBin "add"  (++)    toStr,
           mkStrBin "eq"   (==)    toBool,
           mkStrBin "cmp"  compare toOrd,
           mkStrUn  "show" show    toStr
          ]
  where 
  toInt i  = VInt i
  toDbl i  = VDbl i
  toBool b = VCons (CIdent (show b)) []
  toOrd o  = VCons (CIdent (show o)) []
  toStr s  = VStr s
  mkUn t a x f g = let c = CIdent ("prim_" ++ x ++ "_" ++ t)
                   in (c, VPrim (\n -> a f g n))
  mkBin t a x f g = let c = CIdent ("prim_" ++ x ++ "_" ++ t)
                    in (c, VPrim (\n -> VPrim (\m -> a f g n m )))
  mkIntUn = mkUn "Integer" $ \ f g x -> 
                     case x of
                         VInt n -> g (f n)
                         _ -> error $ printValue x ++ " is not an integer"
  mkIntBin = mkBin "Integer" $ \ f g x y -> 
                     case (x,y) of
                         (VInt n,VInt m) -> g (f n m)
                         _ -> error $ printValue x ++ " and " ++ printValue y 
                                      ++ " are not both integers"
  mkDblUn = mkUn "Double" $ \ f g x -> 
                     case x of
                         VDbl n -> g (f n)
                         _ -> error $ printValue x ++ " is not a double"
  mkDblBin = mkBin "Double" $ \ f g x y -> 
                     case (x,y) of
                         (VDbl n,VDbl m) -> g (f n m)
                         _ -> error $ printValue x ++ " and " ++ printValue y 
                                      ++ " are not both doubles"
  mkStrUn = mkUn "String" $ \ f g x -> 
                     case x of
                         VStr n -> g (f n)
                         _ -> error $ printValue x ++ " is not a string"
  mkStrBin = mkBin "String" $ \ f g x y -> 
                     case (x,y) of
                         (VStr n,VStr m) -> g (f n m)
                         _ -> error $ printValue x ++ " and " ++ printValue y 
                                      ++ " are not both strings"

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
      let env' = [ (id, v) | LetDef id e <- defs, 
                             let v = eval env' e] 
                 `addToEnv` env
       in eval (seqEnv env') exp2
  ECase exp cases -> 
      let v = eval env exp
          r = case firstMatch env v cases of
                  Nothing -> error $ "No pattern matched " ++ printValue v
                  Just (e,env') -> eval env' e
       in v `seq` r
  EAbs _ _ -> VClos env x
  EPi _ _ _  -> VClos env x
  EApp exp1 exp2 -> 
      let v1 = eval env exp1
          v2 = eval env exp2
       in case v1 of
                  VClos env' (EAbs id e) -> eval (bind id v2 `addToEnv` env') e
                  VPrim f -> f $! v2
                  VCons c vs -> (VCons $! c) $! ((++) $! vs) $! [v2]
                  _ -> error $ "Bad application (" ++ printValue v1
                                ++ ") (" ++ printValue v2 ++ ")"
  EProj exp id  -> let v = eval env exp
                    in case v of
                               VRec fs -> recLookup id fs
                               _ -> error $ printValue v ++ " is not a record, "
                                            ++ "cannot get field " ++ printTree id

  ERecType fts -> VRec $! deepSeqList $! [v `seq` (f,v) | FieldType  f e <- fts,
                                                          let v = eval env e]
  ERec fvs     -> VRec $! deepSeqList $! [v `seq` (f,v) | FieldValue f e <- fvs,
                                                          let v = eval env e]
  EVar id  -> lookupEnv env id
  EType  -> VType
  EStr str  -> VStr str
  EInteger n  -> VInt n
  EDouble n  -> VDbl n
  EMeta (TMeta t) -> VMeta (read $ drop 1 t)

firstMatch :: Env -> Value -> [Case] -> Maybe (Exp,Env)
firstMatch _ _ [] = Nothing
firstMatch env v (Case p g e:cs) = 
    case match p v of
        Nothing -> firstMatch env v cs
        Just bs -> let env' = bs `addToEnv` env
                    in case eval env' g of
                           VCons (CIdent "True")  [] -> Just (e,env')
                           VCons (CIdent "False") [] -> firstMatch env v cs
                           x -> error $ "Error in guard: " ++ printValue x 
                                        ++ " is not a Bool"

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
           VInt i     -> EInteger i
           VDbl i     -> EDouble i
           VType      -> EType
           VRec fs    -> ERec [ FieldValue f (valueToExp v) | (f,v) <- fs]
           VClos env e  -> e
           VCons c vs -> foldl EApp (EVar c) (map valueToExp vs)
           VPrim _    -> EVar (CIdent "<<primitive>>") -- FIXME: what to return here?
           VMeta n    -> EMeta $ TMeta $ "?" ++ show n

--
-- * Pretty printing of values
--

printValue :: Value -> String
printValue v = printTree (valueToExp v)
