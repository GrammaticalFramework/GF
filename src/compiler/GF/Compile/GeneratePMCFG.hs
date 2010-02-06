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

import GF.Infra.Option
import GF.Data.BacktrackM
import GF.Data.Utilities (updateNthM, updateNth, sortNub)

import System.IO
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.IntMap as IntMap
import qualified Data.ByteString.Char8 as BS
import Data.Array.IArray
import Data.Maybe
import Control.Monad
import Control.Exception

----------------------------------------------------------------------
-- main conversion function


--convertConcrete :: Options -> Abstr -> CId -> Concr -> IO Concr
convertConcrete opts lang flags printnames abs_defs cnc_defs lincats params lin_defs = do
  let env0 = emptyGrammarEnv cnc_defs cat_defs params
  when (flag optProf opts) $ do
    profileGrammar lang cnc_defs env0 pfrules
  env1 <- expandHOAS opts abs_defs cnc_defs cat_defs lin_defs env0
  env2 <- foldM (convertRule opts cnc_defs) env1 pfrules
  return $ getParserInfo flags printnames env2
  where
    cat_defs = Map.insert cidVar (S []) lincats

    pfrules = [
      (PFRule id args (0,res) (map findLinType args) (findLinType (0,res)) term) | 
        (id, (ty,_,_)) <- Map.toList abs_defs, let (args,res) = typeSkeleton ty, 
        term <- maybeToList (Map.lookup id cnc_defs)]
        
    findLinType (_,id) = fromMaybe (error $ "No lincat for " ++ show id) (Map.lookup id cat_defs)

profileGrammar lang cnc_defs (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) pfrules = do
  hPutStrLn stderr ""
  hPutStrLn stderr ("Language: " ++ show lang)
  hPutStrLn stderr ""
  hPutStrLn stderr "Categories                 Count"
  hPutStrLn stderr "--------------------------------"
  case IntMap.lookup 0 catSet of
    Just cats -> mapM_ profileCat (Map.toList cats)
    Nothing   -> return ()
  hPutStrLn stderr "--------------------------------"
  hPutStrLn stderr ""
  hPutStrLn stderr "Rules                      Count"
  hPutStrLn stderr "--------------------------------"
  mapM_ profileRule pfrules
  hPutStrLn stderr "--------------------------------"
  where
    profileCat (cid,(fcat1,fcat2,_,_)) = do
      hPutStrLn stderr (lformat 23 cid ++ rformat 9 (fcat2-fcat1+1))

    profileRule (PFRule fun args res ctypes ctype term) = do
      let pargs = zipWith (protoFCat cnc_defs) args ctypes
      hPutStrLn stderr (lformat 23 fun ++ rformat 9 (product [length xs | PFCat _ _ _ tcs <- pargs, (_,xs) <- tcs]))

    lformat :: Show a => Int -> a -> String
    lformat n x = s ++ replicate (n-length s) ' '
      where
        s = show x

    rformat :: Show a => Int -> a -> String
    rformat n x = replicate (n-length s) ' ' ++ s
      where
        s = show x

brk :: (GrammarEnv -> GrammarEnv) -> (GrammarEnv -> GrammarEnv)
brk f (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) =
  case f (GrammarEnv last_id catSet seqSet funSet crcSet IntMap.empty) of
    (GrammarEnv last_id catSet seqSet funSet crcSet topdown1) -> IntMap.foldWithKey optimize (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) topdown1
  where
    optimize cat ps env = IntMap.foldWithKey ff env (IntMap.fromListWith (++) [(funid,[args]) | PApply funid args <- Set.toList ps])
      where
        ff :: FunId -> [[FId]] -> GrammarEnv -> GrammarEnv
        ff funid xs env
          | product (map Set.size ys) == count = 
                                   case List.mapAccumL (\env c -> addFCoercion env (Set.toList c)) env ys of
                                     (env,args) -> addProduction env cat (PApply funid args)
          | otherwise                           =  List.foldl (\env args -> addProduction env cat (PApply funid args)) env xs
          where
            count = length xs
            ys    = foldr (zipWith Set.insert) (repeat Set.empty) xs

convertRule :: Options -> TermMap -> GrammarEnv -> ProtoFRule -> IO GrammarEnv
convertRule opts cnc_defs grammarEnv (PFRule fun args res ctypes ctype term) = do
  let pres  = protoFCat cnc_defs res ctype
      pargs = zipWith (protoFCat cnc_defs) args ctypes

      b     = runBranchM (convertTerm cnc_defs [] ctype term) (pargs,[])
      (grammarEnv1,b1) = addSequences' grammarEnv b
      grammarEnv2 = brk (\grammarEnv -> foldBM addRule
                                               grammarEnv
                                               (go' b1 [] [])
                                               (pres,pargs)  ) grammarEnv1
  when (verbAtLeast opts Verbose) $ hPutStrLn stderr ("+ "++showCId fun)
  return $! grammarEnv2
  where
    addRule lins (newCat', newArgs') env0 =
      let [newCat]        = getFCats env0 newCat'
          (env1, newArgs) = List.mapAccumL (\env -> addFCoercion env . getFCats env) env0 newArgs'

          (env2,funid) = addCncFun env1 (CncFun fun (mkArray lins))

      in addProduction env2 newCat (PApply funid newArgs)

----------------------------------------------------------------------
-- Branch monad

newtype BranchM a = BM (forall b . (a -> ([ProtoFCat],[Symbol]) -> Branch b) -> ([ProtoFCat],[Symbol]) -> Branch b)

instance Monad BranchM where
    return a   = BM (\c s -> c a s)
    BM m >>= k = BM (\c s -> m (\a s -> unBM (k a) c s) s)
	where unBM (BM m) = m

instance MonadState ([ProtoFCat],[Symbol]) BranchM where
    get = BM (\c s -> c s s)
    put s = BM (\c _ -> c () s)

instance Functor BranchM where
    fmap f (BM m) = BM (\c s -> m (c . f) s)

runBranchM :: BranchM (Value a) -> ([ProtoFCat],[Symbol]) -> Branch a
runBranchM (BM m) s = m (\v s -> Return v) s

variants :: [a] -> BranchM a
variants xs = BM (\c s -> Variant [c x s | x <- xs])

choices :: Int -> FPath -> BranchM LIndex
choices nr path = BM (\c s -> let (args,_) = s
		                  PFCat _ _ _ tcs = args !! nr
                              in case fromMaybe (error "evalTerm: wrong path") (lookup path tcs) of
                                   [index] -> c index s
                                   indices -> Case nr path [c i (updateEnv i s) | i <- indices])
  where    
    updateEnv index (args,seq) = (updateNth (restrictArg path index) nr args,seq)

    restrictArg path index (PFCat n cat rcs tcs) = PFCat n cat rcs (addConstraint path index tcs)

    addConstraint path0 index0 []    = error "restrictProtoFCat: unknown path"
    addConstraint path0 index0 (c@(path,indices) : tcs)
      | path0 == path = ((path,[index0]) : tcs)
      | otherwise     = c : addConstraint path0 index0 tcs

mkRecord :: [BranchM (Value a)] -> BranchM (Value a)
mkRecord xs = BM (\c -> foldl (\c (BM m) bs s -> c (m (\v s -> Return v) s : bs) s) (c . Rec) xs [])


----------------------------------------------------------------------
-- term conversion

type CnvMonad a = BranchM a

type FPath = [LIndex]
data ProtoFCat  = PFCat Int CId [FPath] [(FPath,[LIndex])]
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
  
    loop path rcs tcs (R record) = List.foldr (\(index,term) (rcs,tcs) -> loop (index:path) rcs tcs term) (rcs,tcs) (zip [0..] record)
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
  | Con LIndex


go' :: Branch SeqId -> FPath -> [SeqId] -> BacktrackM Env [SeqId]
go' (Case nr path_ bs) path ss = do (index,b) <- member (zip [0..] bs)
                                    restrictArg nr path_ index
                                    go' b path ss
go' (Variant bs)      path ss = do b <- member bs
                                   go' b path ss
go' (Return  v)       path ss = go v path ss

go :: Value SeqId -> FPath -> [SeqId] -> BacktrackM Env [SeqId]
go (Rec xs)    path ss = foldM (\ss (lbl,b) -> go' b (lbl:path) ss) ss (reverse (zip [0..] xs))
go (Str seqid) path ss = return (seqid : ss)
go (Con i)     path ss = restrictHead path i >> return ss

addSequences' :: GrammarEnv -> Branch [Symbol] -> (GrammarEnv, Branch SeqId)
addSequences' env (Case nr path bs) = let (env1,bs1) = List.mapAccumL addSequences' env bs
                                      in (env1,Case nr path bs1)
addSequences' env (Variant bs)      = let (env1,bs1) = List.mapAccumL addSequences' env bs
                                      in (env1,Variant bs1)
addSequences' env (Return  v)       = let (env1,v1) = addSequences env v
                                      in (env1,Return v1)

addSequences :: GrammarEnv -> Value [Symbol] -> (GrammarEnv, Value SeqId)
addSequences env (Rec vs)  = let (env1,vs1) = List.mapAccumL addSequences' env vs
                             in (env1,Rec vs1)
addSequences env (Str lin) = let (env1,seqid) = addFSeq env (optimizeLin lin)
                             in (env1,Str seqid)
addSequences env (Con i)   = (env,Con i)


optimizeLin [] = []
optimizeLin lin@(SymKS _ : _) = 
  let (ts,lin') = getRest lin
  in SymKS ts : optimizeLin lin'
  where
    getRest (SymKS ts : lin) = let (ts1,lin') = getRest lin
                               in (ts++ts1,lin')
    getRest             lin  = ([],lin)
optimizeLin (sym : lin) = sym : optimizeLin lin


convertTerm :: TermMap -> FPath -> Term -> Term -> CnvMonad (Value [Symbol])
convertTerm cnc_defs sel ctype (V nr)     = convertArg ctype nr (reverse sel)
convertTerm cnc_defs sel ctype (C nr)     = convertCon ctype nr (reverse sel)
convertTerm cnc_defs sel ctype (R record) = convertRec cnc_defs sel ctype record
convertTerm cnc_defs sel ctype (P term p) = do nr <- evalTerm cnc_defs [] p
                                               convertTerm cnc_defs (nr:sel) ctype term
convertTerm cnc_defs sel ctype (FV vars)  = do term <- variants vars
                                               convertTerm cnc_defs sel ctype term
convertTerm cnc_defs sel ctype (S ts)     = do vs <- mapM (convertTerm cnc_defs sel ctype) ts
                                               return (Str (concat [s | Str s <- vs]))
convertTerm cnc_defs sel ctype (K (KS t)) = return (Str [SymKS [t]])
convertTerm cnc_defs sel ctype (K (KP s v))=return (Str [SymKP s v])
convertTerm cnc_defs sel ctype (F id)     = case Map.lookup id cnc_defs of
                                              Just term -> convertTerm cnc_defs sel ctype term
                                              Nothing   -> error ("unknown id " ++ showCId id)
convertTerm cnc_defs sel ctype (W s t)    = do
  ss <- case t of
    R ss -> return ss
    F f -> case Map.lookup f cnc_defs of
             Just (R ss) -> return ss
             _           -> error ("unknown id " ++ showCId f)
  convertRec cnc_defs sel ctype [K (KS (s ++ s1)) | K (KS s1) <- ss]
convertTerm cnc_defs sel ctype x          = error ("convertTerm ("++show x++")")

convertArg :: Term -> Int -> FPath -> CnvMonad (Value [Symbol])
convertArg (R ctypes) nr path = do
  mkRecord (zipWith (\lbl ctype -> convertArg ctype nr (lbl:path)) [0..] ctypes)
convertArg (C max)    nr path = do
  index <- choices nr path
  return (Con index)
convertArg (S _)      nr path = do
  (args,_) <- get
  let PFCat _ cat rcs tcs = args !! nr
      l = index path rcs 0
      sym | isLiteralCat cat = SymLit nr l
          | otherwise        = SymCat nr l
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

evalTerm :: TermMap -> FPath -> Term -> CnvMonad LIndex
evalTerm cnc_defs path (V nr)       = choices nr (reverse path)
evalTerm cnc_defs path (C nr)       = return nr
evalTerm cnc_defs path (R record)   = case path of
                                        (index:path) -> evalTerm cnc_defs path (record !! index)
evalTerm cnc_defs path (P term sel) = do index <- evalTerm cnc_defs [] sel
                                         evalTerm cnc_defs (index:path) term
evalTerm cnc_defs path (FV terms)   = variants terms >>= evalTerm cnc_defs path
evalTerm cnc_defs path (F id)       = case Map.lookup id cnc_defs of
                                        Just term -> evalTerm cnc_defs path term
                                        Nothing   -> error ("unknown id " ++ showCId id)
evalTerm cnc_defs path x = error ("evalTerm ("++show x++")")


----------------------------------------------------------------------
-- GrammarEnv

data GrammarEnv = GrammarEnv {-# UNPACK #-} !Int CatSet SeqSet FunSet CoerceSet (IntMap.IntMap (Set.Set Production))
type CatSet   = IntMap.IntMap (Map.Map CId (FId,FId,[Int],Array LIndex String))
type SeqSet   = Map.Map Sequence SeqId
type FunSet   = Map.Map CncFun FunId
type CoerceSet= Map.Map [FId] FId

emptyGrammarEnv cnc_defs lincats params =
  let (last_id,catSet) = Map.mapAccumWithKey computeCatRange 0 lincats
  in GrammarEnv last_id (IntMap.singleton 0 catSet) Map.empty Map.empty Map.empty IntMap.empty
  where
    computeCatRange index cat ctype
      | cat == cidString = (index,     (fcatString,fcatString,[],listArray (0,0) ["s"]))
      | cat == cidInt    = (index,     (fcatInt,   fcatInt,   [],listArray (0,0) ["s"]))
      | cat == cidFloat  = (index,     (fcatFloat, fcatFloat, [],listArray (0,0) ["s"]))
      | cat == cidVar    = (index,     (fcatVar,   fcatVar,   [],listArray (0,0) ["s"]))
      | otherwise        = (index+size,(index,index+size-1, poly,maybe (error "missing params") (mkArray . getLabels []) (Map.lookup cat params)))
      where
        (size,poly) = getMultipliers 1 [] ctype
 
    getMultipliers m ms (R record)    = foldr (\t (m,ms) -> getMultipliers m ms t) (m,ms) record
    getMultipliers m ms (S _)         = (m,ms)
    getMultipliers m ms (C max_index) = (m*(max_index+1),m : ms)
    getMultipliers m ms (F id)        = case Map.lookup id cnc_defs of
                                          Just term -> getMultipliers m ms term
                                          Nothing   -> error ("unknown identifier: "++showCId id)

    getLabels ls (R record)    = concat [getLabels (l:ls) t | P (K (KS l)) t <- record]
    getLabels ls (S [FV ps,t]) = concat [getLabels (l:ls) t | K (KS l) <- ps]
    getLabels ls (S [])        = [unwords (reverse ls)]
    getLabels ls (FV _)        = []
    getLabels _ t = error (show t)

expandHOAS opts abs_defs cnc_defs lincats lindefs env = 
  foldM add_varFun (foldl (\env ncat -> add_hoFun (add_hoCat env ncat) ncat) env hoTypes) (Map.keys lincats)
  where
    hoTypes :: [(Int,CId)]
    hoTypes = sortNub [(n,c) | (_,(ty,_,_)) <- Map.toList abs_defs
                             , (n,c) <- fst (typeSkeleton ty), n > 0]
  
    -- add a range of PMCFG categories for each GF high-order category
    add_hoCat env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) (n,cat) =
      case IntMap.lookup 0 catSet >>= Map.lookup cat of
        Just (start,end,ms,lbls) -> let !catSet'  = IntMap.insertWith Map.union n (Map.singleton cat (last_id,last_id+(end-start),ms,lbls)) catSet
                                        !last_id' = last_id+(end-start)+1
                                    in (GrammarEnv last_id' catSet' seqSet funSet crcSet prodSet)
        Nothing                  -> env
        
    -- add one PMCFG function for each high-order type: _B : Cat -> Var -> ... -> Var -> HoCat
    add_hoFun env (n,cat) =
      let linRec = [[SymCat 0 i] | i <- case arg of {PFCat _ _ rcs _ -> [0..length rcs-1]}] ++
                   [[SymLit i 0] | i <- [1..n]]
          (env1,lins) = List.mapAccumL addFSeq env linRec
          newLinRec = mkArray lins
	  
	  (env2,funid) = addCncFun env1 (CncFun _B newLinRec)

          env3 = foldl (\env (arg,res) -> addProduction env res (PApply funid (arg : replicate n fcatVar)))
                       env2
                       (zip (getFCats env2 arg) (getFCats env2 res))
      in env3
      where
        (arg,res) = case Map.lookup cat lincats of
	              Nothing    -> error $ "No lincat for " ++ showCId cat
                      Just ctype -> (protoFCat cnc_defs (0,cat) ctype, protoFCat cnc_defs (n,cat) ctype)

    -- add one PMCFG function for each high-order category: _V : Var -> Cat
    add_varFun env cat =
      case Map.lookup cat lindefs of
        Nothing     -> return env
        Just lindef -> convertRule opts cnc_defs env (PFRule _V [(0,cidVar)] (0,cat) [arg] res lindef)
      where
        arg =
          case Map.lookup cidVar lincats of
            Nothing    -> error $ "No lincat for " ++ showCId cat
            Just ctype -> ctype

        res =
          case Map.lookup cat lincats of
            Nothing    -> error $ "No lincat for " ++ showCId cat
            Just ctype -> ctype

addProduction :: GrammarEnv -> FId -> Production -> GrammarEnv
addProduction (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) cat p =
  GrammarEnv last_id catSet seqSet funSet crcSet (IntMap.insertWith Set.union cat (Set.singleton p) prodSet)

addFSeq :: GrammarEnv -> [Symbol] -> (GrammarEnv,SeqId)
addFSeq env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) lst =
  case Map.lookup seq seqSet of
    Just id -> (env,id)
    Nothing -> let !last_seq = Map.size seqSet
               in (GrammarEnv last_id catSet (Map.insert seq last_seq seqSet) funSet crcSet prodSet,last_seq)
  where
    seq = mkArray lst

addCncFun :: GrammarEnv -> CncFun -> (GrammarEnv,FunId)
addCncFun env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) fun = 
  case Map.lookup fun funSet of
    Just id -> (env,id)
    Nothing -> let !last_funid = Map.size funSet
               in (GrammarEnv last_id catSet seqSet (Map.insert fun last_funid funSet) crcSet prodSet,last_funid)

addFCoercion :: GrammarEnv -> [FId] -> (GrammarEnv,FId)
addFCoercion env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) sub_fcats =
  case sub_fcats of
    [fcat] -> (env,fcat)
    _      -> case Map.lookup sub_fcats crcSet of
                Just fcat -> (env,fcat)
                Nothing   -> let !fcat = last_id+1
                             in (GrammarEnv fcat catSet seqSet funSet (Map.insert sub_fcats fcat crcSet) prodSet,fcat)

getParserInfo :: Map.Map CId Literal -> Map.Map CId String -> GrammarEnv -> Concr
getParserInfo flags printnames (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) =
  Concr { cflags = flags
        , printnames = printnames
        , cncfuns   = mkArray funSet
        , sequences   = mkArray seqSet
        , productions = IntMap.union prodSet coercions
        , pproductions = IntMap.empty
        , lproductions = Map.empty
        , cnccats   = maybe Map.empty (Map.map (\(start,end,_,lbls) -> (CncCat start end lbls))) (IntMap.lookup 0 catSet)
        , totalCats   = last_id+1
        }
  where
    mkArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
    
    coercions = IntMap.fromList [(fcat,Set.fromList (map PCoerce sub_fcats)) | (sub_fcats,fcat) <- Map.toList crcSet]

getFCats :: GrammarEnv -> ProtoFCat -> [FId]
getFCats (GrammarEnv last_id catSet seqSet funSet crcSet prodSet) (PFCat n cat rcs tcs) =
  case IntMap.lookup n catSet >>= Map.lookup cat of
    Just (start,end,ms,_) -> reverse (solutions (variants ms tcs start) ())
  where
    variants _      []                  fcat = return fcat
    variants (m:ms) ((_,indices) : tcs) fcat = do index <- member indices
                                                  variants ms tcs ((m*index) + fcat)


------------------------------------------------------------
-- updating the MCF rule

restrictArg :: LIndex -> FPath -> LIndex -> BacktrackM Env ()
restrictArg nr path index = do
  (head, args) <- get
  args' <- updateNthM (restrictProtoFCat path index) nr args
  put (head, args')

restrictHead :: FPath -> LIndex -> BacktrackM Env ()
restrictHead path term
    = do (head, args) <- get
	 head' <- restrictProtoFCat path term head
	 put (head', args)

restrictProtoFCat :: FPath -> LIndex -> ProtoFCat -> BacktrackM Env ProtoFCat
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
