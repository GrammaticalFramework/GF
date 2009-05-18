{-# LANGUAGE BangPatterns, RankNTypes, FlexibleInstances, MultiParamTypeClasses #-}
----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Convert PGF grammar to PMCFG grammar.
--
-----------------------------------------------------------------------------

module GF.Compile.GeneratePMCFG
    (convertConcrete) where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.BacktrackM
import GF.Data.Utilities (updateNthM, updateNth, sortNub)

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.IntMap as IntMap
import qualified Data.ByteString.Char8 as BS
import Data.Array.IArray
import Data.Maybe
import Control.Monad
import Debug.Trace

----------------------------------------------------------------------
-- main conversion function

convertConcrete :: Abstr -> Concr -> ParserInfo
convertConcrete abs cnc = trace "convertConcrete" $ convert abs_defs conc cats
       where abs_defs = Map.assocs (funs abs)
             conc = Map.union (opers cnc) (lins cnc) -- "union big+small most efficient"
             cats = lincats cnc

convert :: [(CId,(Type,Expr))] -> TermMap -> TermMap -> ParserInfo
convert abs_defs cnc_defs cat_defs =
  let env = expandHOAS abs_defs cnc_defs cat_defs (emptyGrammarEnv cnc_defs cat_defs)
  in getParserInfo (List.foldl' (convertRule cnc_defs) env pfrules)
  where
    pfrules = [
      (PFRule id args (0,res) (map findLinType args) (findLinType (0,res)) term) | 
        (id, (ty,_)) <- abs_defs, let (args,res) = typeSkeleton ty, 
        term <- maybeToList (Map.lookup id cnc_defs)]
        
    findLinType (_,id) = fromMaybe (error $ "No lincat for " ++ show id) (Map.lookup id cat_defs)

brk :: (GrammarEnv -> GrammarEnv) -> (GrammarEnv -> GrammarEnv)
brk f (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) =
  case f (GrammarEnv last_id catSet seqSet funSet crcSet IntMap.empty) of
    (GrammarEnv last_id catSet seqSet funSet crcSet topdown1) -> IntMap.foldWithKey optimize (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) topdown1
  where
    optimize cat ps env = IntMap.foldWithKey ff env (IntMap.fromListWith (++) [(funid,[args]) | FApply funid args <- Set.toList ps])
      where
        ff :: FunId -> [[FCat]] -> GrammarEnv -> GrammarEnv
        ff funid xs env
          | product (map Set.size ys) == count = 
                                   case List.mapAccumL (\env c -> addFCoercion env (Set.toList c)) env ys of
                                     (env,args) -> addProduction env cat (FApply funid args)
          | otherwise                           =  List.foldl (\env args -> addProduction env cat (FApply funid args)) env xs
          where
            count = length xs
            ys    = foldr (zipWith Set.insert) (repeat Set.empty) xs

convertRule :: TermMap -> GrammarEnv -> ProtoFRule -> GrammarEnv
convertRule cnc_defs grammarEnv (PFRule fun args res ctypes ctype term) = trace (show fun) $
  let pres  = protoFCat cnc_defs res ctype
      pargs = zipWith (protoFCat cnc_defs) args ctypes

      b     = runBranchM (convertTerm cnc_defs [] ctype term) (pargs,[])
      (grammarEnv1,b1) = addSequences' grammarEnv b
      grammarEnv2 = brk (\grammarEnv -> foldBM addRule
                                               grammarEnv
                                               (go' b1 [] [])
                                               (pres,pargs)  ) grammarEnv1
  in grammarEnv2
  where
    addRule lins (newCat', newArgs') env0 =
      let [newCat]        = getFCats env0 newCat'
          (env1, newArgs) = List.mapAccumL (\env -> addFCoercion env . getFCats env) env0 newArgs'

          (env2,funid) = addFFun env1 (FFun fun [[n] | n <- [0..length newArgs-1]] (mkArray lins))

      in addProduction env2 newCat (FApply funid newArgs)

----------------------------------------------------------------------
-- Branch monad

newtype BranchM a = BM (forall b . (a -> ([ProtoFCat],[FSymbol]) -> Branch b) -> ([ProtoFCat],[FSymbol]) -> Branch b)

instance Monad BranchM where
    return a   = BM (\c s -> c a s)
    BM m >>= k = BM (\c s -> m (\a s -> unBM (k a) c s) s)
	where unBM (BM m) = m

instance MonadState ([ProtoFCat],[FSymbol]) BranchM where
    get = BM (\c s -> c s s)
    put s = BM (\c _ -> c () s)

instance Functor BranchM where
    fmap f (BM m) = BM (\c s -> m (c . f) s)

runBranchM :: BranchM (Value a) -> ([ProtoFCat],[FSymbol]) -> Branch a
runBranchM (BM m) s = m (\v s -> Return v) s

variants :: [a] -> BranchM a
variants xs = BM (\c s -> Variant (go xs c s))
  where
    go []     c s = []
    go (x:xs) c s = c x s : go xs c s

choices :: Int -> FPath -> BranchM FIndex
choices nr path = BM (\c s -> let (args,_) = s
		                  PFCat _ _ _ tcs = args !! nr
                              in case fromMaybe (error "evalTerm: wrong path") (lookup path tcs) of
                                   [index] -> c index s
                                   indices -> Case nr path (go indices c s))
  where
    go []     c s = []
    go (i:is) c s = (c i (updateEnv i s)) : go is c s
    
    updateEnv index (args,seq) = (updateNth (restrictArg path index) nr args,seq)

    restrictArg path index (PFCat n cat rcs tcs) = PFCat n cat rcs (addConstraint path index tcs)

    addConstraint path0 index0 []    = error "restrictProtoFCat: unknown path"
    addConstraint path0 index0 (c@(path,indices) : tcs)
      | path0 == path = ((path,[index0]) : tcs)
      | otherwise     = c : addConstraint path0 index0 tcs

mkRecord :: [BranchM (Value a)] -> BranchM (Value a)
mkRecord xs = BM (\c -> go xs (c . Rec))
  where
    go []        c s = c [] s
    go (BM m:fs) c s = go fs (\bs s -> c (m (\v s -> Return v) s : bs) s) s

-- cutBranch :: BranchM (Value a) -> BranchM (Branch a)
-- cutBranch (BM m) = BM (\c e -> c (m (\v e -> Return v) e) e)


----------------------------------------------------------------------
-- term conversion

type CnvMonad a = BranchM a

type FPath = [FIndex]
data ProtoFCat  = PFCat Int CId [FPath] [(FPath,[FIndex])]
type Env        = (ProtoFCat, [ProtoFCat])
data ProtoFRule = PFRule CId           {- function -}
                         [(Int,CId)]   {- argument types: context size and category -}
                         (Int,CId)     {- result   type : context size (always 0) and category  -}
                         [Term]        {- argument lin-types representation -}
                         Term          {- result   lin-type  representation -}
                         Term          {- body -}
type TermMap    = Map.Map CId Term


protoFCat :: TermMap -> (Int,CId) -> Term -> ProtoFCat
protoFCat cnc_defs (n,cat) ctype = 
  let (rcs,tcs) = loop [] [] [] ctype'
  in PFCat n cat rcs tcs
  where
    ctype'    -- extend the high-order linearization type
      | n > 0     = case ctype of
                      R xs -> R (xs ++ replicate n (S []))
                      _    -> error $ "Not a record: " ++ show ctype
      | otherwise = ctype
  
    loop path rcs tcs (R record) = List.foldl' (\(rcs,tcs) (index,term) -> loop (index:path) rcs tcs term) (rcs,tcs) (zip [0..] record)
    loop path rcs tcs (C i)      = (     rcs,(path,[0..i]):tcs)
    loop path rcs tcs (S _)      = (path:rcs,              tcs)
    loop path rcs tcs (F id)     = case Map.lookup id cnc_defs of
                                     Just term -> loop path rcs tcs term
                                     Nothing   -> error ("unknown identifier: "++show id)

data Branch a
  = Case Int FPath [Branch a]
  | Variant [Branch a]
  | Return  (Value a)

data Value a
  = Rec [Branch a]
  | Str a
  | Con FIndex


go' :: Branch SeqId -> FPath -> [SeqId] -> BacktrackM Env [SeqId]
go' (Case nr path_ bs) path ss = do (index,b) <- member (zip [0..] bs)
                                    restrictArg nr path_ index
                                    go' b path ss
go' (Variant bs)      path ss = do b <- member bs
                                   go' b path ss
go' (Return  v)       path ss = go v path ss

go :: Value SeqId -> FPath -> [SeqId] -> BacktrackM Env [SeqId]
go (Rec xs)    path ss = foldM (\ss (lbl,b) -> go' b (lbl:path) ss) ss (zip [0..] xs)
go (Str seqid) path ss = return (seqid : ss)
go (Con i)     path ss = restrictHead path i >> return ss

addSequences' :: GrammarEnv -> Branch [FSymbol] -> (GrammarEnv, Branch SeqId)
addSequences' env (Case nr path bs) = let (env1,bs1) = List.mapAccumL addSequences' env bs
                                      in (env1,Case nr path bs1)
addSequences' env (Variant bs)      = let (env1,bs1) = List.mapAccumL addSequences' env bs
                                      in (env1,Variant bs1)
addSequences' env (Return  v)       = let (env1,v1) = addSequences env v
                                      in (env1,Return v1)

addSequences :: GrammarEnv -> Value [FSymbol] -> (GrammarEnv, Value SeqId)
addSequences env (Rec vs)  = let (env1,vs1) = List.mapAccumL addSequences' env vs
                             in (env1,Rec vs1)
addSequences env (Str lin) = let (env1,seqid) = addFSeq env lin
                             in (env1,Str seqid)
addSequences env (Con i)   = (env,Con i)

convertTerm :: TermMap -> FPath -> Term -> Term -> CnvMonad (Value [FSymbol])
convertTerm cnc_defs sel ctype (V nr)     = convertArg ctype nr (reverse sel)
convertTerm cnc_defs sel ctype (C nr)     = convertCon ctype nr (reverse sel)
convertTerm cnc_defs sel ctype (R record) = convertRec cnc_defs sel ctype record
convertTerm cnc_defs sel ctype (P term p) = do nr <- evalTerm cnc_defs [] p
                                               convertTerm cnc_defs (nr:sel) ctype term
convertTerm cnc_defs sel ctype (FV vars)  = do term <- variants vars
                                               convertTerm cnc_defs sel ctype term
convertTerm cnc_defs sel ctype (S ts)     = do vs <- mapM (convertTerm cnc_defs sel ctype) ts
                                               return (Str (concat [s | Str s <- vs]))
--convertTerm cnc_defs sel ctype (K t)      = return (Str [FSymTok t])
convertTerm cnc_defs sel ctype (K (KS t)) = return (Str [FSymTok (KS t)])
convertTerm cnc_defs sel ctype (K (KP strs vars)) =
  do toks <- variants (strs:[strs' | Alt strs' _ <- vars])
     return (Str (map (FSymTok . KS) toks))
convertTerm cnc_defs sel ctype (F id)     = case Map.lookup id cnc_defs of
                                              Just term -> convertTerm cnc_defs sel ctype term
                                              Nothing   -> error ("unknown id " ++ prCId id)
convertTerm cnc_defs sel ctype (W s t)    = do
  ss <- case t of
    R ss -> return ss
    F f -> case Map.lookup f cnc_defs of
             Just (R ss) -> return ss
             _           -> error ("unknown id " ++ prCId f)
  convertRec cnc_defs sel ctype [K (KS (s ++ s1)) | K (KS s1) <- ss]
convertTerm cnc_defs sel ctype x          = error ("convertTerm ("++show x++")")

convertArg :: Term -> Int -> FPath -> CnvMonad (Value [FSymbol])
convertArg (R ctypes) nr path = do
  mkRecord (zipWith (\lbl ctype -> convertArg ctype nr (lbl:path)) [0..] ctypes)
convertArg (C max)    nr path = do
  index <- choices nr path
  return (Con index)
convertArg (S _)      nr path = do
  (args,_) <- get
  let PFCat _ cat rcs tcs = args !! nr
      l = index path rcs 0
      sym | isLiteralCat cat = FSymLit nr l
          | otherwise        = FSymCat nr l
  return (Str [sym])
  where
    index lbl' (lbl:lbls) idx
      | lbl' == lbl = idx
      | otherwise   = index lbl' lbls $! (idx+1)

convertCon (C max) index [] = return (Con index)
convertCon x _ _            = fail $ "SimpleToFCFG.convertCon: " ++ show x

convertRec cnc_defs [] (R ctypes) record = do
  mkRecord (zipWith (convertTerm cnc_defs []) ctypes record)
convertRec cnc_defs (index:sub_sel) ctype record =
  convertTerm cnc_defs sub_sel ctype (record !! index)


------------------------------------------------------------
-- eval a term to ground terms

evalTerm :: TermMap -> FPath -> Term -> CnvMonad FIndex
evalTerm cnc_defs path (V nr)       = choices nr (reverse path)
evalTerm cnc_defs path (C nr)       = return nr
evalTerm cnc_defs path (R record)   = case path of
                                        (index:path) -> evalTerm cnc_defs path (record !! index)
evalTerm cnc_defs path (P term sel) = do index <- evalTerm cnc_defs [] sel
                                         evalTerm cnc_defs (index:path) term
evalTerm cnc_defs path (FV terms)   = variants terms >>= evalTerm cnc_defs path
evalTerm cnc_defs path (F id)       = case Map.lookup id cnc_defs of
                                        Just term -> evalTerm cnc_defs path term
                                        Nothing   -> error ("unknown id " ++ prCId id)
evalTerm cnc_defs path x = error ("evalTerm ("++show x++")")


----------------------------------------------------------------------
-- GrammarEnv

data GrammarEnv = GrammarEnv {-# UNPACK #-} !Int CatSet SeqSet FunSet CoerceSet (IntMap.IntMap (Set.Set Production))
type CatSet   = IntMap.IntMap (Map.Map CId (FCat,FCat,[Int]))
type SeqSet   = Map.Map FSeq SeqId
type FunSet   = Map.Map FFun FunId
type CoerceSet= Map.Map [FCat] FCat

emptyGrammarEnv cnc_defs lincats = 
  let (last_id,catSet) = Map.mapAccumWithKey computeCatRange 0 lincats
  in GrammarEnv last_id (IntMap.singleton 0 catSet) Map.empty Map.empty Map.empty IntMap.empty
  where
    computeCatRange index cat ctype
      | cat == cidString = (index,     (fcatString,fcatString,[]))
      | cat == cidInt    = (index,     (fcatInt,   fcatInt,   []))
      | cat == cidFloat  = (index,     (fcatFloat, fcatFloat, []))
      | otherwise        = (index+size,(index,index+size-1,poly))
      where
        (size,poly) = getMultipliers 1 [] ctype
 
    getMultipliers m ms (R record)    = foldl (\(m,ms) t -> getMultipliers m ms t) (m,ms) record
    getMultipliers m ms (S _)         = (m,ms)
    getMultipliers m ms (C max_index) = (m*(max_index+1),m : ms)
    getMultipliers m ms (F id)        = case Map.lookup id cnc_defs of
                                          Just term -> getMultipliers m ms term
                                          Nothing   -> error ("unknown identifier: "++prCId id)

expandHOAS abs_defs cnc_defs lincats env = 
  foldl add_varFun (foldl (\env ncat -> add_hoFun (add_hoCat env ncat) ncat) env hoTypes) hoCats
  where
    hoTypes :: [(Int,CId)]
    hoTypes = sortNub [(n,c) | (_,(ty,_)) <- abs_defs
                             , (n,c) <- fst (typeSkeleton ty), n > 0]

    hoCats :: [CId]
    hoCats = sortNub [c | (_,(ty,_)) <- abs_defs
                        , Hyp _ ty <- case ty of {DTyp hyps val _ -> hyps}
                        , c   <- fst (catSkeleton ty)]
  
    -- add a range of PMCFG categories for each GF high-order category
    add_hoCat env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) (n,cat) =
      case IntMap.lookup 0 catSet >>= Map.lookup cat of
        Just (start,end,ms) -> let !catSet'  = IntMap.insertWith Map.union n (Map.singleton cat (last_id,last_id+(end-start),ms)) catSet
                                   !last_id' = last_id+(end-start)+1
                               in (GrammarEnv last_id' catSet' seqSet funSet crcSet prodSet)
        Nothing             -> env
        
    -- add one PMCFG function for each high-order type: _B : Cat -> Var -> ... -> Var -> HoCat
    add_hoFun env (n,cat) =
      let linRec = reverse $
                   [[FSymCat 0 i] | (l,i) <- case arg of {PFCat _ _ rcs _ -> zip rcs [0..]}] ++
                   [[FSymLit i 0] | i <- [1..n]]
          (env1,lins) = List.mapAccumL addFSeq env linRec
          newLinRec = mkArray lins
	  
	  (env2,funid) = addFFun env1 (FFun _B [[i] | i <- [0..n]] newLinRec)

          env3 = foldl (\env (arg,res) -> addProduction env res (FApply funid (arg : replicate n fcatVar)))
                       env2
                       (zip (getFCats env2 arg) (getFCats env2 res))
      in env3
      where
        (arg,res) = case Map.lookup cat lincats of
	              Nothing    -> error $ "No lincat for " ++ prCId cat
                      Just ctype -> (protoFCat cnc_defs (0,cat) ctype, protoFCat cnc_defs (n,cat) ctype)

    -- add one PMCFG function for each high-order category: _V : Var -> Cat
    add_varFun env cat =
      let (env1,seqid) = addFSeq env [FSymLit 0 0]
          lins         = replicate (case res of {PFCat _ _ rcs _ -> length rcs}) seqid
          (env2,funid) = addFFun env1 (FFun _V [[0]] (mkArray lins))
          env3         = foldl (\env res -> addProduction env2 res (FApply funid [fcatVar]))
                               env2
                               (getFCats env2 res)
      in env3
      where
        res = case Map.lookup cat lincats of
	        Nothing    -> error $ "No lincat for " ++ prCId cat
                Just ctype -> protoFCat cnc_defs (0,cat) ctype

    _B = mkCId "_B"
    _V = mkCId "_V"

addProduction :: GrammarEnv -> FCat -> Production -> GrammarEnv
addProduction (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) cat p =
  GrammarEnv last_id catSet seqSet funSet crcSet (IntMap.insertWith Set.union cat (Set.singleton p) prodSet)

addFSeq :: GrammarEnv -> [FSymbol] -> (GrammarEnv,SeqId)
addFSeq env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) lst =
  case Map.lookup seq seqSet of
    Just id -> (env,id)
    Nothing -> let !last_seq = Map.size seqSet
               in (GrammarEnv last_id catSet (Map.insert seq last_seq seqSet) funSet crcSet prodSet,last_seq)
  where
    seq = mkArray lst

addFFun :: GrammarEnv -> FFun -> (GrammarEnv,FunId)
addFFun env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) fun = 
  case Map.lookup fun funSet of
    Just id -> (env,id)
    Nothing -> let !last_funid = Map.size funSet
               in (GrammarEnv last_id catSet seqSet (Map.insert fun last_funid funSet) crcSet prodSet,last_funid)

addFCoercion :: GrammarEnv -> [FCat] -> (GrammarEnv,FCat)
addFCoercion env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) sub_fcats =
  case sub_fcats of
    [fcat] -> (env,fcat)
    _      -> case Map.lookup sub_fcats crcSet of
                Just fcat -> (env,fcat)
                Nothing   -> let !fcat = last_id+1
                             in (GrammarEnv fcat catSet seqSet funSet (Map.insert sub_fcats fcat crcSet) prodSet,fcat)

getParserInfo :: GrammarEnv -> ParserInfo
getParserInfo (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) =
  ParserInfo { functions   = mkArray funSet
             , sequences   = mkArray seqSet
	     , productions0= productions0
	     , productions = filterProductions productions0
	     , startCats   = maybe Map.empty (Map.map (\(start,end,_) -> range (start,end))) (IntMap.lookup 0 catSet)
	     , totalCats   = last_id+1
	     }
  where
    mkArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
    
    productions0 = IntMap.union prodSet coercions
    coercions = IntMap.fromList [(fcat,Set.fromList (map FCoerce sub_fcats)) | (sub_fcats,fcat) <- Map.toList crcSet]

getFCats :: GrammarEnv -> ProtoFCat -> [FCat]
getFCats (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) (PFCat n cat rcs tcs) =
  case IntMap.lookup n catSet >>= Map.lookup cat of
    Just (start,end,ms) -> reverse (solutions (variants ms tcs start) ())
  where
    variants _      []                  fcat = return fcat
    variants (m:ms) ((_,indices) : tcs) fcat = do index <- member indices
                                                  variants ms tcs ((m*index) + fcat)


------------------------------------------------------------
-- updating the MCF rule

restrictArg :: FIndex -> FPath -> FIndex -> BacktrackM Env ()
restrictArg nr path index = do
  (head, args) <- get
  args' <- updateNthM (restrictProtoFCat path index) nr args
  put (head, args')

restrictHead :: FPath -> FIndex -> BacktrackM Env ()
restrictHead path term
    = do (head, args) <- get
	 head' <- restrictProtoFCat path term head
	 put (head', args)

restrictProtoFCat :: FPath -> FIndex -> ProtoFCat -> BacktrackM Env ProtoFCat
restrictProtoFCat path0 index0 (PFCat n cat rcs tcs) = do
  tcs <- addConstraint tcs
  return (PFCat n cat rcs tcs)
  where
    addConstraint []    = error "restrictProtoFCat: unknown path"
    addConstraint (c@(path,indices) : tcs)
      | path0 == path = guard (index0 `elem` indices) >>
                        return ((path,[index0]) : tcs)
      | otherwise     = liftM (c:) (addConstraint tcs)

mkArray lst = listArray (0,length lst-1) lst
