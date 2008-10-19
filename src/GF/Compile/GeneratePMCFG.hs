{-# OPTIONS -fbang-patterns -cpp #-}
----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Converting SimpleGFC grammars to fast nonerasing MCFG grammar.
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-----------------------------------------------------------------------------

module GF.Compile.GeneratePMCFG
    (convertConcrete) where

import PGF.CId
import PGF.Data
import PGF.Macros --hiding (prt)

import GF.Data.BacktrackM
import GF.Data.SortedList
import GF.Data.Utilities (updateNthM, sortNub)

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
convertConcrete abs cnc = convert abs_defs conc cats
       where abs_defs = Map.assocs (funs abs)
             conc = Map.union (opers cnc) (lins cnc) -- "union big+small most efficient"
             cats = lincats cnc

convert :: [(CId,(Type,Expr))] -> TermMap -> TermMap -> ParserInfo
convert abs_defs cnc_defs cat_defs =
  let env = expandHOAS abs_defs cnc_defs cat_defs (emptyGrammarEnv cnc_defs cat_defs)
  in getParserInfo (List.foldl' (convertRule cnc_defs) env xrules)
  where
    xrules = [
      (XRule id args (0,res) (map findLinType args) (findLinType (0,res)) term) | 
        (id, (ty,_)) <- abs_defs, let (args,res) = typeSkeleton ty, 
        term <- Map.lookup id cnc_defs]
        
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

convertRule :: TermMap -> GrammarEnv -> XRule -> GrammarEnv
convertRule cnc_defs grammarEnv (XRule fun args res ctypes ctype term) =
  brk (\grammarEnv -> foldBM addRule
                             grammarEnv
                             (convertTerm cnc_defs [] ctype term [([],[])])
                             (protoFCat cnc_defs res ctype, zipWith (protoFCat cnc_defs) args ctypes)) grammarEnv
  where
    addRule linRec (newCat', newArgs') env0 =
      let [newCat]        = getFCats env0 newCat'
          (env1, newArgs) = List.mapAccumL (\env -> addFCoercion env . getFCats env) env0 newArgs'

          (env2,lins) = List.mapAccumL addFSeq env1 linRec
          newLinRec = mkArray lins

          (env3,funid) = addFFun env2 (FFun fun [[n] | n <- [0..length newArgs-1]] newLinRec)

      in addProduction env3 newCat (FApply funid newArgs)

----------------------------------------------------------------------
-- term conversion

type CnvMonad a = BacktrackM Env a

type FPath     = [FIndex]
data ProtoFCat = PFCat Int CId [FPath] [(FPath,[FIndex])]
type Env       = (ProtoFCat, [ProtoFCat])
type LinRec    = [(FPath, [FSymbol])]
data XRule     = XRule CId           {- function -}
                       [(Int,CId)]   {- argument types: context size and category -}
                       (Int,CId)     {- result   type : context size (always 0) and category  -}
                       [Term]        {- argument lin-types representation -}
                       Term          {- result   lin-type  representation -}
                       Term          {- body -}

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

type TermMap = Map.Map CId Term

convertTerm :: TermMap -> FPath -> Term -> Term -> LinRec -> CnvMonad LinRec
convertTerm cnc_defs sel ctype (V nr)       ((lbl_path,lin) : lins) = convertArg ctype nr (reverse sel) lbl_path lin lins
convertTerm cnc_defs sel ctype (C nr)       ((lbl_path,lin) : lins) = convertCon ctype nr (reverse sel) lbl_path lin lins
convertTerm cnc_defs sel ctype (R record)   ((lbl_path,lin) : lins) = convertRec cnc_defs sel ctype record lbl_path lin lins
convertTerm cnc_defs sel ctype (P term p)                     lins  = do nr <- evalTerm cnc_defs [] p
                                                                         convertTerm cnc_defs (nr:sel) ctype term lins
convertTerm cnc_defs sel ctype (FV vars)                      lins  = do term <- member vars
                                                                         convertTerm cnc_defs sel ctype term lins
convertTerm cnc_defs sel ctype (S ts)                         lins  = foldM (\lins t -> convertTerm cnc_defs sel ctype t lins) lins (reverse ts)
--convertTerm cnc_defs sel ctype (K t)        ((lbl_path,lin) : lins) = return ((lbl_path,FSymTok t : lin) : lins)
convertTerm cnc_defs sel ctype (K (KS t))   ((lbl_path,lin) : lins) = return ((lbl_path,FSymTok (KS t) : lin) : lins)
convertTerm cnc_defs sel ctype (K (KP strs vars))((lbl_path,lin) : lins) = 
  do toks <- member (strs:[strs' | Alt strs' _ <- vars])
     return ((lbl_path, map (FSymTok . KS) toks ++ lin) : lins)
convertTerm cnc_defs sel ctype (F id)                         lins  = do term <- Map.lookup id cnc_defs
                                                                         convertTerm cnc_defs sel ctype term lins
convertTerm cnc_defs sel ctype (W s t)     ((lbl_path,lin) : lins) = do
  ss <- case t of
    R ss -> return ss
    F f -> do
      t <- Map.lookup f cnc_defs 
      case t of
        R ss -> return ss
  convertRec cnc_defs sel ctype [K (KS (s ++ s1)) | K (KS s1) <- ss] lbl_path lin lins
convertTerm cnc_defs sel ctype x lins  = error ("convertTerm ("++show x++")")


convertArg (R record) nr path lbl_path lin lins =
  foldM (\lins (lbl, ctype) -> convertArg ctype nr (lbl:path) (lbl:lbl_path) lin lins) lins (zip [0..] record)
convertArg (C max) nr path lbl_path lin lins = do
  index <- member [0..max]
  restrictHead lbl_path index
  restrictArg nr path index
  return lins
convertArg (S _) nr path lbl_path lin lins = do
  (_, args) <- readState
  let PFCat _ cat rcs tcs = args !! nr
  return ((lbl_path, FSymCat nr (index path rcs 0) : lin) : lins)
  where
    index lbl' (lbl:lbls) idx
      | lbl' == lbl = idx
      | otherwise   = index lbl' lbls $! (idx+1)


convertCon (C max) index [] lbl_path lin lins = do
  guard (index <= max)
  restrictHead lbl_path index
  return lins
convertCon x _ _ _ _ _ = error $ "SimpleToFCFG,convertCon: " ++ show x

convertRec cnc_defs [] (R ctypes) record lbl_path lin lins =
  foldM (\lins (index,ctype,val) -> convertTerm cnc_defs [] ctype val ((index:lbl_path,lin) : lins))
        lins
        (zip3 [0..] ctypes record)
convertRec cnc_defs (index:sub_sel) ctype record lbl_path lin lins = do
  convertTerm cnc_defs sub_sel ctype (record !! index) ((lbl_path,lin) : lins)


------------------------------------------------------------
-- eval a term to ground terms

evalTerm :: TermMap -> FPath -> Term -> CnvMonad FIndex
evalTerm cnc_defs path (V nr)       = do (_, args) <- readState
		                         let PFCat _ _ _ tcs = args !! nr
		                             rpath = reverse path
                                         index <- member (fromMaybe (error "evalTerm: wrong path") (lookup rpath tcs))
					 restrictArg nr rpath index
					 return index
evalTerm cnc_defs path (C nr)       = return nr
evalTerm cnc_defs path (R record)   = case path of
                                        (index:path) -> evalTerm cnc_defs path (record !! index)
evalTerm cnc_defs path (P term sel) = do index <- evalTerm cnc_defs [] sel
                                         evalTerm cnc_defs (index:path) term
evalTerm cnc_defs path (FV terms)   = member terms >>= evalTerm cnc_defs path
evalTerm cnc_defs path (F id)       = do term <- Map.lookup id cnc_defs
                                         evalTerm cnc_defs path term
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
                   [(l ,[FSymCat 0 i]) | (l,i) <- case arg of {PFCat _ _ rcs _ -> zip rcs [0..]}] ++
                   [([],[FSymCat i 0]) | i <- [1..n]]
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
      let (env1,seqid) = addFSeq env ([],[FSymCat 0 0])
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

addFSeq :: GrammarEnv -> (FPath,[FSymbol]) -> (GrammarEnv,SeqId)
addFSeq env@(GrammarEnv last_id catSet seqSet funSet crcSet prodSet) (_,lst) =
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
	     , productions = IntMap.union prodSet coercions
	     , startCats   = maybe Map.empty (Map.map (\(start,end,_) -> range (start,end))) (IntMap.lookup 0 catSet)
	     , totalCats   = last_id+1
	     }
  where
    mkArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
    
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

restrictArg :: FIndex -> FPath -> FIndex -> CnvMonad ()
restrictArg nr path index = do
  (head, args) <- readState 
  args' <- updateNthM (restrictProtoFCat path index) nr args
  writeState (head, args')

restrictHead :: FPath -> FIndex -> CnvMonad ()
restrictHead path term
    = do (head, args) <- readState
	 head' <- restrictProtoFCat path term head
	 writeState (head', args)

restrictProtoFCat :: FPath -> FIndex -> ProtoFCat -> CnvMonad ProtoFCat
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
