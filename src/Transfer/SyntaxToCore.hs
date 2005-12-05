-- | Translate to the core language
module Transfer.SyntaxToCore where

import Transfer.Syntax.Abs
import Transfer.Syntax.Print

import Control.Monad.State
import Data.List
import Data.Maybe
import qualified Data.Set as Set
import Data.Set (Set)
import qualified Data.Map as Map
import Data.Map (Map)
import Data.Monoid

import Debug.Trace

type C a = State CState a

data CState = CState {
                      nextVar :: Integer,
                      nextMeta :: Integer
                     }



declsToCore :: [Decl] -> [Decl]
declsToCore m = evalState (declsToCore_ m) newState

declsToCore_ :: [Decl] -> C [Decl]
declsToCore_ =     deriveDecls
               >>> desugar 
               >>> compilePattDecls 
               >>> numberMetas
               >>> replaceCons 
               >>> expandOrPatts
               >>> optimize

optimize :: [Decl] -> C [Decl]
optimize =     removeUselessMatch
           >>> betaReduce

newState :: CState
newState = CState {
                   nextVar = 0,
                   nextMeta = 0
                  }

--
-- * Number meta variables
--

numberMetas :: [Decl] -> C [Decl]
numberMetas = mapM f
  where
  f :: Tree a -> C (Tree a)
  f t = case t of
               EMeta -> do
                        st <- get
                        put (st { nextMeta = nextMeta st + 1})
                        return $ EVar $ Ident $ "?" ++ show (nextMeta st) -- FIXME: hack
               _ -> composOpM f t


--
-- * Pattern equations
--

compilePattDecls :: [Decl] -> C [Decl]
compilePattDecls [] = return []
compilePattDecls (d@(ValueDecl x _ _ _):ds) =
    do
    let (xs,rest) = span (isValueDecl x) ds
    d <- mergeDecls (d:xs)
    rs <- compilePattDecls rest
    return (d:rs)
compilePattDecls (d:ds) = liftM (d:) (compilePattDecls ds)

-- | Checks if a declaration is a value declaration
--   of the given identifier.
isValueDecl :: Ident -> Decl -> Bool
isValueDecl x (ValueDecl y _ _ _) = x == y
isValueDecl _ _ = False

-- | Take a non-empty list of pattern equations with guards 
--   for the same function, and produce a single declaration.
mergeDecls :: [Decl] -> C Decl
mergeDecls ds@(ValueDecl x p _ _:_)
    = do let cs = [ (ps,g,rhs) | ValueDecl _ ps g rhs <- ds ]
             (pss,_,_) = unzip3 cs
             n = length p
         when (not (all ((== n) . length) pss))
              $ fail $ "Pattern count mismatch for " ++ printTree x
         vs <- freshIdents n
         let cases = map (\ (ps,g,rhs) -> Case (mkPTuple ps) g rhs) cs
             c = ECase (mkETuple (map EVar vs)) cases
             f = foldr (EAbs . VVar) c vs
         return $ ValueDecl x [] GuardNo f

--
-- * Derived function definitions
--

deriveDecls :: [Decl] -> C [Decl]
deriveDecls ds = liftM concat (mapM der ds)
  where 
  ts = dataTypes ds
  der (DeriveDecl (Ident f) t) = 
      case lookup f derivators of
           Just d -> d t k cs
           _ -> fail $ "Don't know how to derive " ++ f
      where (k,cs) = getDataType ts t
  der d = return [d]

type Derivator = Ident -> Exp -> [(Ident,Exp)] -> C [Decl]

derivators :: [(String, Derivator)]
derivators = [
              ("Compos", deriveCompos),
              ("Show", deriveShow),
              ("Eq", deriveEq),
              ("Ord", deriveOrd)
             ]

--
-- * Deriving instances of Compos
--

deriveCompos :: Derivator
deriveCompos t@(Ident ts) k cs = 
    do
    co <- deriveComposOp t k cs
    cf <- deriveComposFold t k cs
    let [c] = argumentTypes k -- FIXME: what if there is not exactly one argument to t?
        d = Ident ("compos_"++ts)
        dt = apply (var "Compos") [c, EVar t]
        r = ERec [FieldValue (Ident "composOp") co,
                  FieldValue (Ident "composFold") cf]
    return [TypeDecl d dt, ValueDecl d [] GuardNo r]

deriveComposOp :: Ident -> Exp -> [(Ident,Exp)] -> C Exp
deriveComposOp t k cs = 
    do
    f <- freshIdent
    x <- freshIdent
    let e = EVar
        pv = VVar
        infixr 3 \->
        (\->) = EAbs
        mkCase ci ct = 
            do
            vars <- freshIdents (arity ct)
            -- FIXME: the type argument to f is wrong if the constructor
            -- has a dependent type
            -- FIXME: make a special case for lists?
            let rec v at = case at of
                                   EApp (EVar t') c | t' == t -> apply (e f) [c, e v]
                                   _ -> e v
                calls = zipWith rec vars (argumentTypes ct)
            return $ Case (PCons ci (map PVar vars)) gtrue (apply (e ci) calls)
    cases <- mapM (uncurry mkCase) cs
    let cases' = cases ++ [Case PWild gtrue (e x)]
    fb <- abstract (arity k) $ const $ pv f \-> pv x \-> ECase (e x) cases'
    return fb

deriveComposFold :: Ident -> Exp -> [(Ident,Exp)] -> C Exp
deriveComposFold t k cs = 
    do
    f <- freshIdent
    x <- freshIdent
    b <- freshIdent
    r <- freshIdent
    let e = EVar
        pv = VVar
        infixr 3 \->
        (\->) = EAbs
        mkCase ci ct = 
            do
            vars <- freshIdents (arity ct)
            -- FIXME: the type argument to f is wrong if the constructor
            -- has a dependent type
            -- FIXME: make a special case for lists?
            let rec v at = case at of
                                   EApp (EVar t') c | t' == t -> apply (e f) [c, e v]
                                   _ -> e v
                calls = zipWith rec vars (argumentTypes ct)
                z = EProj (e r) (Ident "mzero")
                p = EProj (e r) (Ident "mplus")
                joinCalls [] = z
                joinCalls cs = foldr1 (\x y -> apply p [x,y]) cs
            return $ Case (PCons ci (map PVar vars)) gtrue (joinCalls calls)
    cases <- mapM (uncurry mkCase) cs
    let cases' = cases ++ [Case PWild gtrue (e x)]
    fb <- abstract (arity k) $ const $ pv f \-> pv x \-> ECase (e x) cases'
    return $ VWild \-> pv r \-> fb

--
-- * Deriving instances of Show
--

deriveShow :: Derivator
deriveShow t k cs = fail $ "derive Show not implemented"

--
-- * Deriving instances of Eq
--

-- FIXME: how do we require Eq instances for all
-- constructor arguments?

deriveEq :: Derivator
deriveEq t@(Ident tn) k cs = 
    do
    dt <- abstractType ats (EApp (var "Eq") . apply (EVar t))
    f <- mkEq
    r <- abstract (arity k) (\_ -> ERec [FieldValue (Ident "eq") f])
    return [TypeDecl d dt, ValueDecl d [] GuardNo r]
  where
  ats = argumentTypes k
  d = Ident ("eq_"++tn)
  mkEq = do
         x <- freshIdent
         y <- freshIdent
         cases <- mapM (uncurry mkEqCase) cs
         let fc = Case PWild gtrue false
         abstract 2 (\es -> ECase (mkETuple es) (cases++[fc]))
  mkEqCase c ct = 
      do
      let n = arity ct
          ts = argumentTypes ct
      vs1 <- freshIdents n
      vs2 <- freshIdents n
      let pr = mkPTuple [PCons c (map PVar vs1), PCons c (map PVar vs2)]
          eqs = concat $ zipWith3 child_eq ts vs1 vs2
          rhs [] = true
          rhs xs = foldr1 EAnd xs
      return $ Case pr gtrue (rhs eqs)
  -- FIXME: hack: this returns a list to skip testing type arguments.
  child_eq EType _ _ = []
  child_eq t x y = [apply (var "eq") [t,eq_dict t, EVar x, EVar y]]
  -- FIXME: this is a hack to at least support Tree types
  eq_dict (EApp (EVar t') _) 
      | t' == t = apply (EVar d) (replicate (arity k) EMeta)
  eq_dict (EVar (Ident x)) 
      | x `elem` ["String","Integer","Double"] = var ("eq_"++x)
  eq_dict _ = EMeta

--
-- * Deriving instances of Ord
--

deriveOrd :: Derivator
deriveOrd t k cs = fail $ "derive Ord not implemented"

--
-- * Constructor patterns and applications.
--

type DataConsInfo = Map Ident Int

consArities :: [Decl] -> DataConsInfo
consArities ds = Map.fromList [ (c, arity t) | DataDecl _ _ cs <- ds, 
                                               ConsDecl c t <- cs ]

-- | Get the arity of a function type.
arity :: Exp -> Int
arity = length . argumentTypes

-- | Get the argument type of a function type. Note that
--   the returned types may contains free variables 
--   which should be bound to the values of earlier arguments.
argumentTypes :: Exp -> [Exp]
argumentTypes e = case e of
                      EPi _ t e' -> t : argumentTypes e'
                      EPiNoVar t e' -> t : argumentTypes e'
                      _ -> []

-- | Fix up constructor patterns and applications.
replaceCons :: [Decl] -> C [Decl]
replaceCons ds = mapM (f cs) ds
  where
  cs = consArities ds 
  f :: DataConsInfo -> Tree a -> C (Tree a)
  f cs x = case x of
        -- get rid of the PConsTop hack
        PConsTop id p1 ps -> f cs (PCons id (p1:ps))
        -- replace patterns C where C is a constructor with (C)
        PVar id | isCons id -> return $ PCons id []
        -- don't eta-expand overshadowed constructors
        EAbs (VVar id) e | isCons id -> 
                  liftM (EAbs (VVar id)) (f (Map.delete id cs) e)
        EPi (VVar id) t e | isCons id -> 
                  liftM2 (EPi (VVar id)) (f cs t) (f (Map.delete id cs) e)
        -- eta-expand constructors. betaReduce will remove any beta 
        -- redexes produced here.
        EVar id | isCons id -> do
                               let Just n = Map.lookup id cs
                               abstract n (apply x)
        _ -> composOpM (f cs) x
    where isCons = (`Map.member` cs)

--
-- * Do simple beta reductions.
--

betaReduce :: [Decl] -> C [Decl]
betaReduce = return . map f
 where
 f :: Tree a -> Tree a
 f t = case t of
              EApp e1 e2 -> 
                  case (f e1, f e2) of
                       (EAbs (VVar x) b, e) | countFreeOccur x b == 1 -> f (subst x e b)
                       (e1',e2') -> EApp e1' e2'
              _ -> composOp f t

--
-- * Remove useless pattern matching and variable binding.
--

removeUselessMatch :: [Decl] -> C [Decl]
removeUselessMatch = return . map f
 where
 f :: Tree a -> Tree a
 f x = case x of
       EAbs (VVar x) b ->
           case f b of
                    -- replace \x -> case x of { y | True -> e } with \y -> e,
                    -- if x is not free in e
                    ECase (EVar x') [Case (PVar y) g e]
                          | x' == x && isTrueGuard g && not (x `isFreeIn` e)
                              -> f (EAbs (VVar y) e)
                    -- replace unused variable in lambda with wild card
                    e | not (x `isFreeIn` e) -> f (EAbs VWild e)
                    e -> EAbs (VVar x) e
       -- replace unused variable in pi with wild card
       EPi (VVar x) t e ->
           let e' = f e
               v = if not (x `isFreeIn` e') then VWild else VVar x
            in EPi v (f t) e'
       -- replace unused variables in case patterns with wild cards
       Case p (GuardExp g) e ->
           let g' = f g
               e' = f e
               used = freeVars g' `Set.union` freeVars e'
               p' = f (removeUnusedVarPatts used p)
            in Case p' (GuardExp g') e'
       -- for value declarations without patterns, compilePattDecls 
       -- generates pattern matching on the empty record, remove these
       ECase (ERec []) [Case (PRec []) g e] | isTrueGuard g -> f e
       -- if the pattern matching is on a single field of a record expression
       -- with only one field, there is no need to wrap it in a record
       ECase (ERec [FieldValue x e]) cs | all (isSingleFieldPattern x) (casePatterns cs)
              -> f (ECase e [ Case p g r | Case (PRec [FieldPattern _ p]) g r <- cs ])
       -- for all fields in record matching where all patterns for the field just
       -- bind variables, substitute in the field value (if it is a variable)
       -- in the guards and right hand sides.
       ECase (ERec fs) cs | all isPRec (casePatterns cs) ->
           let h (FieldValue f v@(EVar _):fs) xs
                   | all (onlyBindsFieldToVariable f) (casePatterns xs)
                          = h fs (map (inlineField f v) xs)
               h (f:fs) xs = let (fs',xs') = h fs xs in (f:fs',xs')
               h [] xs = ([],xs)
               inlineField f v (Case (PRec fps) (GuardExp g) e) = 
                   let p' = PRec [fp | fp@(FieldPattern f' _) <- fps, f' /= f]
                       ss = zip (fieldPatternVars f fps) (repeat v)
                    in Case p' (GuardExp (substs ss g)) (substs ss e)
               (fs',cs') = h fs cs
               x' = ECase (ERec fs') cs'
            in if length fs' < length fs then f x' else composOp f x'
       -- Remove wild card patterns in record patterns
       PRec fps -> PRec (map f (fps \\ wildcards))
          where wildcards = [fp | fp@(FieldPattern _ PWild) <- fps]
       _ -> composOp f x

isTrueGuard :: Guard -> Bool
isTrueGuard (GuardExp (EVar (Ident "True"))) = True
isTrueGuard GuardNo = True
isTrueGuard _ = False

removeUnusedVarPatts :: Set Ident -> Tree a -> Tree a
removeUnusedVarPatts keep x = case x of
                    PVar id | not (id `Set.member` keep) -> PWild
                    _ -> composOp (removeUnusedVarPatts keep) x    

isSingleFieldPattern :: Ident -> Pattern -> Bool
isSingleFieldPattern x p = case p of
                                PRec [FieldPattern y _] -> x == y
                                _ -> False

casePatterns :: [Case] -> [Pattern]
casePatterns cs = [p | Case p _ _ <- cs]

isPRec :: Pattern -> Bool
isPRec (PRec _) = True
isPRec _ = False

-- | Checks if given pattern is a record pattern, and matches the field
--   with just a variable, with a wild card, or not at all.
onlyBindsFieldToVariable :: Ident -> Pattern -> Bool
onlyBindsFieldToVariable f (PRec fps) = 
    all isVar [p | FieldPattern f' p <- fps, f == f']
  where isVar (PVar _) = True
        isVar PWild = True
        isVar _ = False
onlyBindsFieldToVariable _ _ = False

fieldPatternVars :: Ident -> [FieldPattern] -> [Ident]
fieldPatternVars f fps = [p | FieldPattern f' (PVar p) <- fps, f == f']

--
-- * Expand disjunctive patterns.
--

expandOrPatts :: [Decl] -> C [Decl]
expandOrPatts = return . map f
 where
 f :: Tree a -> Tree a
 f x = case x of
              ECase e cs -> ECase (f e) (concatMap (expandCase . f) cs)
              _          -> composOp f x

expandCase :: Case -> [Case]
expandCase (Case p g e) = [ Case p' g e | p' <- expandPatt p ]

expandPatt :: Pattern -> [Pattern]
expandPatt p = case p of
                    POr p1 p2  -> expandPatt p1 ++ expandPatt p2
                    PCons i ps -> map (PCons i) $ expandPatts ps
                    PRec fps   -> let (fs,ps) = unzip $ fromPRec fps
                                      fpss = map (zip fs) (expandPatts ps)
                                   in map (PRec . toPRec) fpss
                    _ -> [p]

expandPatts :: [Pattern] -> [[Pattern]]
expandPatts [] = [[]]
expandPatts (p:ps) = [ p':ps' | p' <- expandPatt p, ps' <- expandPatts ps]

--
-- * Remove simple syntactic sugar.
--

desugar :: [Decl] -> C [Decl]
desugar = return . map f
 where
 f :: Tree a -> Tree a
 f x = case x of
              PListCons p1 p2    -> pListCons        <| p1   <| p2
              PEmptyList         -> pList []
              PList xs           -> pList [f p | CommaPattern p <- xs]
              PTuple x xs          -> mkPTuple [f p | CommaPattern p <- (x:xs)]
              GuardNo            -> gtrue
              EIf exp0 exp1 exp2 -> ifBool           <| exp0 <| exp1 <| exp2
              EDo bs e           -> mkDo (map f bs) (f e)
              BindNoVar exp0     -> BindVar VWild    <| exp0
              EPiNoVar exp0 exp1 -> EPi VWild        <| exp0 <| exp1
              EBind exp0 exp1    -> appBind          <| exp0 <| exp1
              EBindC exp0 exp1   -> appBindC         <| exp0 <| exp1
              EOr  exp0 exp1     -> orBool           <| exp0 <| exp1
              EAnd exp0 exp1     -> andBool          <| exp0 <| exp1
              EEq  exp0 exp1     -> overlBin "eq"    <| exp0 <| exp1
              ENe  exp0 exp1     -> overlBin "ne"    <| exp0 <| exp1
              ELt  exp0 exp1     -> overlBin "lt"    <| exp0 <| exp1
              ELe  exp0 exp1     -> overlBin "le"    <| exp0 <| exp1
              EGt  exp0 exp1     -> overlBin "gt"    <| exp0 <| exp1
              EGe  exp0 exp1     -> overlBin "ge"    <| exp0 <| exp1
              EListCons exp0 exp1 -> appCons         <| exp0 <| exp1
              EAdd exp0 exp1     -> overlBin "plus"  <| exp0 <| exp1
              ESub exp0 exp1     -> overlBin "minus" <| exp0 <| exp1
              EMul exp0 exp1     -> overlBin "times" <| exp0 <| exp1
              EDiv exp0 exp1     -> overlBin "div"   <| exp0 <| exp1
              EMod exp0 exp1     -> overlBin "mod"   <| exp0 <| exp1
              ENeg exp0          -> overlUn  "neg"   <| exp0
              EEmptyList         -> mkList []
              EList exps         -> mkList (map f exps)
              ETuple exp1 exps   -> mkETuple (map f (exp1:exps))
              _                  -> composOp f x
    where g <| x = g (f x)

--
-- * List patterns
--

pListCons :: Pattern -> Pattern -> Pattern
pListCons p1 p2 = PCons (Ident "Cons") [PWild,p1,p2]

pList :: [Pattern] -> Pattern
pList = foldr pListCons (PCons (Ident "Nil") [PWild])

--
-- * Use an overloaded function.
--

overlUn :: String -> Exp -> Exp
overlUn f e1 = apply (EVar (Ident f)) [EMeta,EVar (Ident "num_Integer"),e1] -- FIXME: hack, should be ?

overlBin :: String -> Exp -> Exp -> Exp
overlBin f e1 e2 = apply (EVar (Ident f)) [EMeta,EVar (Ident "num_Integer"),e1,e2] -- FIXME: hack, should be ?

--
-- * Monad
--

mkDo :: [Bind] -> Exp -> Exp
mkDo bs e = foldr (\ (BindVar v r) x -> appBind r (EAbs v x)) e bs

appBind :: Exp -> Exp -> Exp
appBind e1 e2 = apply (EVar (Ident "bind")) [EMeta,EMeta,EMeta,EMeta,e1,e2]

appBindC :: Exp -> Exp -> Exp
appBindC e1 e2 = appBind e1 (EAbs VWild e2)

--
-- * List
--

mkList :: [Exp] -> Exp
mkList = foldr appCons (EApp (EVar (Ident "Nil")) EMeta)

appCons :: Exp -> Exp -> Exp
appCons e1 e2 = apply (EVar (Ident "Cons")) [EMeta,e1,e2]


--
-- * Booleans
--

andBool :: Exp -> Exp -> Exp
andBool e1 e2 = ifBool e1 e2 false

orBool :: Exp -> Exp -> Exp
orBool e1 e2 = ifBool e1 true e2

ifBool :: Exp -> Exp -> Exp -> Exp
ifBool c t e = ECase c [Case (PCons (Ident "True") []) gtrue t,
                        Case (PCons (Ident "False") []) gtrue e]

--
-- * Substitution
--

subst :: Ident -> Exp -> Exp -> Exp
subst x e = substs [(x,e)]

-- | Simultaneuous substitution
substs :: [(Ident, Exp)] -> Exp -> Exp
substs ss = f (Map.fromList ss)
 where  
 f :: Map Ident Exp -> Tree a -> Tree a
 f ss t | Map.null ss = t
 f ss t = case t of
   ELet ds e3 ->
     ELet [LetDef id (f ss e1) (f ss' e2) | LetDef id e1 e2 <- ds] (f ss' e3)
      where ss' = ss `mapMinusSet` letDefBinds ds
   Case p g e -> Case p (f ss' g) (f ss' e) where ss' = ss `mapMinusSet` binds p
   EAbs (VVar id) e -> EAbs (VVar id) (f ss' e) where ss' = Map.delete id ss
   EPi (VVar id) e1 e2 -> 
       EPi (VVar id) (f ss e1) (f ss' e2) where ss' = Map.delete id ss
   EVar i -> Map.findWithDefault t i ss
   _      -> composOp (f ss) t

--
-- * Abstract syntax utilities
--

var :: String -> Exp
var s = EVar (Ident s)

true :: Exp
true = var "True"

false :: Exp
false = var "False"

gtrue :: Guard
gtrue = GuardExp true


mkETuple :: [Exp] -> Exp
mkETuple = ERec . zipWith (\i -> FieldValue (Ident ("p"++show i))) [0..]

mkPTuple :: [Pattern] -> Pattern
mkPTuple = PRec . zipWith (\i -> FieldPattern (Ident ("p"++show i))) [0..]

-- | Apply an expression to a list of arguments.
apply :: Exp -> [Exp] -> Exp
apply = foldl EApp

-- | Abstract a value over some arguments.
abstract :: Int -- ^ number of arguments
         -> ([Exp] -> Exp) -> C Exp
abstract n f = 
    do
    vs <- freshIdents n
    return $ foldr EAbs (f (map EVar vs)) (map VVar vs)

-- | Abstract a type over some arguments.
abstractType :: [Exp] -- ^ argument types
             -> ([Exp] -> Exp) -- ^ function from variable expressions
                               --   to the expression to return
             -> C Exp
abstractType ts f = 
    do
    vs <- freshIdents (length ts)
    let pi (v,t) e = EPi (VVar v) t e
    return $ foldr pi (f (map EVar vs)) (zip vs ts)

-- | Get an identifier which cannot occur in user-written
--   code, and which has not been generated before.
freshIdent :: C Ident
freshIdent = do
             st <- get
             put (st { nextVar = nextVar st + 1 })
             return (Ident ("x_"++show (nextVar st)))

freshIdents :: Int -> C [Ident]
freshIdents n = replicateM n freshIdent

-- | Get the variables bound by a set of let definitions.
letDefBinds :: [LetDef] -> Set Ident
letDefBinds defs = Set.fromList [ id | LetDef id _ _ <- defs]

letDefTypes :: [LetDef] -> [Exp]
letDefTypes defs = [ exp1 | LetDef _ exp1 _ <- defs ]

letDefRhss :: [LetDef] -> [Exp]
letDefRhss defs = [ exp2 | LetDef _ _ exp2 <- defs ]

-- | Get the free variables in an expression.
freeVars :: Exp -> Set Ident
freeVars = f
  where
  f :: Tree a -> Set Ident
  f t = case t of
   ELet defs exp3 -> 
        Set.unions $
           (Set.unions (f exp3:map f (letDefRhss defs)) Set.\\ letDefBinds defs)
           :map f (letDefTypes defs)
   ECase exp cases -> f exp `Set.union` 
                      Set.unions [(f g `Set.union` f e) Set.\\ binds p 
                                      | Case p g e <- cases]
   EAbs (VVar id) exp -> Set.delete id (f exp)
   EPi (VVar id) exp1 exp2 -> f exp1 `Set.union` Set.delete id (f exp2)
   EVar i -> Set.singleton i
   _      -> composOpMonoid f t

isFreeIn :: Ident -> Exp -> Bool
isFreeIn x e = countFreeOccur x e > 0

-- | Count the number of times a variable occurs free in an expression.
countFreeOccur :: Ident -> Exp -> Int
countFreeOccur x = f
  where
  f :: Tree a -> Int
  f t = case t of
   ELet defs _ | x `Set.member` letDefBinds defs ->
            sum (map f (letDefTypes defs))
   Case p _ _ | x `Set.member` binds p -> 0
   EAbs (VVar id) _ | id == x -> 0
   EPi (VVar id) exp1 _ | id == x -> f exp1
   EVar id | id == x -> 1
   _      -> composOpFold 0 (+) f t

-- | Get the variables bound by a pattern.
binds :: Pattern -> Set Ident
binds = f
 where 
 f :: Tree a -> Set Ident
 f p = case p of
                 -- replaceCons removes non-variable PVars
                 PVar id -> Set.singleton id 
                 _ -> composOpMonoid f p


fromPRec :: [FieldPattern] -> [(Ident,Pattern)]
fromPRec fps = [ (l,p) | FieldPattern l p <- fps ]

toPRec :: [(Ident,Pattern)] -> [FieldPattern]
toPRec = map (uncurry FieldPattern)

--
-- * Data types
--

type DataTypes = Map Ident (Exp,[(Ident,Exp)])

-- | Get a map of data type names to the type of the type constructor
--   and all data constructors with their types.
dataTypes :: [Decl] -> Map Ident (Exp,[(Ident,Exp)])
dataTypes ds = Map.fromList [ (i,(t,[(c,ct) | ConsDecl c ct <- cs])) | DataDecl i t cs <- ds]

getDataType :: DataTypes -> Ident -> (Exp,[(Ident,Exp)])
getDataType ts i = 
    case Map.lookup i ts of
        Just t -> t
        Nothing -> error $ "Data type " ++ printTree i ++ " not found."
                           ++ " Known types: " ++ show (Map.keysSet ts)

--
-- * Utilities
--

infixl 1 >>>

(>>>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
f >>> g = (g =<<) . f

mapMinusSet :: Ord k => Map k a -> Set k -> Map k a
mapMinusSet m s = m Map.\\ (Map.fromList [(x,()) | x <- Set.toList s])
