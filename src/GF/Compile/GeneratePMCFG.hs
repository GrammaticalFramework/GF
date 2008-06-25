{-# OPTIONS -fbang-patterns #-}
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
import PGF.Parsing.FCFG.Utilities

import GF.Data.BacktrackM
import GF.Data.SortedList
import GF.Data.Utilities (updateNthM, sortNub)

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.ByteString.Char8 as BS
import Data.Array
import Data.Maybe
import Control.Monad
import Debug.Trace

----------------------------------------------------------------------
-- main conversion function

convertConcrete :: Abstr -> Concr -> FGrammar
convertConcrete abs cnc = fixHoasFuns $ convert abs_defs' conc' cats'
       where abs_defs = Map.assocs (funs abs)
             conc = Map.union (opers cnc) (lins cnc) -- "union big+small most efficient"
             cats = lincats cnc
             (abs_defs',conc',cats') = expandHOAS abs_defs conc cats

expandHOAS :: [(CId,(Type,Expr))] -> TermMap -> TermMap -> ([(CId,(Type,Expr))],TermMap,TermMap)
expandHOAS funs lins lincats = (funs' ++ hoFuns ++ varFuns, 
                                Map.unions [lins, hoLins, varLins], 
                                Map.unions [lincats, hoLincats, varLincat])
    where
      -- replace higher-order fun argument types with new categories
      funs' = [(f,(fixType ty,e)) | (f,(ty,e)) <- funs]
          where
            fixType :: Type -> Type
            fixType ty = let (ats,rt) = typeSkeleton ty in cftype (map catName ats) rt

      hoTypes :: [(Int,CId)]
      hoTypes = sortNub [(n,c) | (_,(ty,_)) <- funs, (n,c) <- fst (typeSkeleton ty), n > 0]
      hoCats = sortNub (map snd hoTypes)
      -- for each Cat with N bindings, we add a new category _NCat
      -- each new category contains a single function __NCat : Cat -> _Var -> ... -> _Var -> _NCat
      hoFuns = [(funName ty,(cftype (c : replicate n varCat) (catName ty),EEq [])) | ty@(n,c) <- hoTypes]
      -- lincats for the new categories
      hoLincats = Map.fromList [(catName ty, modifyRec (++ replicate n (S [])) (lincatOf c)) | ty@(n,c) <- hoTypes]
      -- linearizations of the new functions, lin __NCat v_0 ... v_n-1 x = { s1 = x.s1; ...; sk = x.sk; $0 = v_0.s ...
      hoLins = Map.fromList [ (funName ty, mkLin c n) | ty@(n,c) <- hoTypes]
          where mkLin c n = modifyRec (\fs -> [P (V 0) (C j) | j <- [0..length fs-1]] ++ [P (V i) (C 0) | i <- [1..n]]) (lincatOf c)
      -- for each Cat, we a add a fun _Var_Cat : _Var -> Cat
      varFuns = [(varFunName cat, (cftype [varCat] cat,EEq [])) | cat <- hoCats]
      -- linearizations of the _Var_Cat functions
      varLins = Map.fromList [(varFunName cat, R [P (V 0) (C 0)]) | cat <- hoCats]
      -- lincat for the _Var category
      varLincat = Map.singleton varCat (R [S []])

      lincatOf c = fromMaybe (error $ "No lincat for " ++ prCId c) $ Map.lookup c lincats

      modifyRec :: ([Term] -> [Term]) -> Term -> Term
      modifyRec f (R xs) = R (f xs)
      modifyRec _ t = error $ "Not a record: " ++ show t

      varCat = mkCId "_Var"

      catName :: (Int,CId) -> CId
      catName (0,c) = c
      catName (n,c) = mkCId ("_" ++ show n ++ prCId c)

      funName :: (Int,CId) -> CId
      funName (n,c) = mkCId ("__" ++ show n ++ prCId c)

      varFunName :: CId -> CId
      varFunName c = mkCId ("_Var_" ++ prCId c)

-- replaces __NCat with _B and _Var_Cat with _.
-- the temporary names are just there to avoid name collisions.
fixHoasFuns :: FGrammar -> FGrammar
fixHoasFuns (!rs, !cs) = ([FRule (fixName n) ps args cat lins | FRule n ps args cat lins <- rs], cs)
  where fixName (CId n) | BS.pack "__"    `BS.isPrefixOf` n = (mkCId "_B")
                        | BS.pack "_Var_" `BS.isPrefixOf` n = wildCId
        fixName n = n

convert :: [(CId,(Type,Expr))] -> TermMap -> TermMap -> FGrammar
convert abs_defs cnc_defs cat_defs = getFGrammar (List.foldl' (convertRule cnc_defs) emptyFRulesEnv srules)
  where
    srules = [
      (XRule id args res (map findLinType args) (findLinType res) term) | 
        (id, (ty,_)) <- abs_defs, let (args,res) = catSkeleton ty, 
        term <- Map.lookup id cnc_defs]
        
    findLinType id = fromMaybe (error $ "No lincat for " ++ show id) (Map.lookup id cat_defs)


convertRule :: TermMap -> FRulesEnv -> XRule -> FRulesEnv
convertRule cnc_defs frulesEnv (XRule fun args cat ctypes ctype term) =
  foldBM addRule
         frulesEnv
         (convertTerm cnc_defs [] ctype term [([],[])])
         (protoFCat cnc_defs cat ctype, zipWith (protoFCat cnc_defs) args ctypes)
  where
    addRule linRec (newCat', newArgs') env0 =
      let (env1, newCat)  = genFCatHead env0 newCat'
          (env2, newArgs) = List.mapAccumL (genFCatArg cnc_defs) env1 newArgs'

          newLinRec = mkArray (map (mkArray . snd) linRec)
          mkArray lst = listArray (0,length lst-1) lst

          rule = FRule fun [] newArgs newCat newLinRec
      in addFRule env2 rule

----------------------------------------------------------------------
-- term conversion

type CnvMonad a = BacktrackM Env a

type FPath     = [FIndex]
data ProtoFCat = PFCat CId [FPath] [(FPath,FIndex)] Term
type Env       = (ProtoFCat, [ProtoFCat])
type LinRec    = [(FPath, [FSymbol])]
data XRule     = XRule CId     {- function -}
                       [CId]   {- argument types -}
                       CId     {- result   type  -}
                       [Term]  {- argument lin-types representation -}
                       Term    {- result   lin-type  representation -}
                       Term    {- body -}

protoFCat :: TermMap -> CId -> Term -> ProtoFCat
protoFCat cnc_defs cat ctype = PFCat cat (getRCS cnc_defs ctype) [] ctype

type TermMap = Map.Map CId Term

convertTerm :: TermMap -> FPath -> Term -> Term -> LinRec -> CnvMonad LinRec
convertTerm cnc_defs sel ctype (V nr)       ((lbl_path,lin) : lins) = convertArg ctype nr (reverse sel) lbl_path lin lins
convertTerm cnc_defs sel ctype (C nr)       ((lbl_path,lin) : lins) = convertCon ctype nr (reverse sel) lbl_path lin lins
convertTerm cnc_defs sel ctype (R record)   ((lbl_path,lin) : lins) = convertRec cnc_defs sel ctype record lbl_path lin lins
convertTerm cnc_defs sel ctype (P term p)                     lins  = do nr <- evalTerm cnc_defs [] p
                                                                         convertTerm cnc_defs (nr:sel) ctype term lins
convertTerm cnc_defs sel ctype (FV vars)                      lins  = do term <- member vars
                                                                         convertTerm cnc_defs sel ctype term lins
convertTerm cnc_defs sel ctype (S ts)       ((lbl_path,lin) : lins) = foldM (\lins t -> convertTerm cnc_defs sel ctype t lins) ((lbl_path,lin) : lins) (reverse ts)
convertTerm cnc_defs sel ctype (K (KS str)) ((lbl_path,lin) : lins) = return ((lbl_path,FSymTok str : lin) : lins)
convertTerm cnc_defs sel ctype (K (KP strs vars))((lbl_path,lin) : lins) = 
  do toks <- member (strs:[strs' | Alt strs' _ <- vars])
     return ((lbl_path, map FSymTok toks ++ lin) : lins)
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
  let PFCat cat rcs tcs _ = args !! nr
  return ((lbl_path, FSymCat (index path rcs 0) nr : lin) : lins)
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
		                         let PFCat _ _ _ ctype = args !! nr
                                         unifyPType nr (reverse path) (selectTerm path ctype)
evalTerm cnc_defs path (C nr)       = return nr
evalTerm cnc_defs path (R record)   = case path of
                                        (index:path) -> evalTerm cnc_defs path (record !! index)
evalTerm cnc_defs path (P term sel) = do index <- evalTerm cnc_defs [] sel
                                         evalTerm cnc_defs (index:path) term
evalTerm cnc_defs path (FV terms)   = member terms >>= evalTerm cnc_defs path
evalTerm cnc_defs path (F id)       = do term <- Map.lookup id cnc_defs
                                         evalTerm cnc_defs path term
evalTerm cnc_defs path x = error ("evalTerm ("++show x++")")

unifyPType :: FIndex -> FPath -> Term -> CnvMonad FIndex
unifyPType nr path (C max_index) =
    do (_, args) <- readState
       let PFCat _ _ tcs _ = args !! nr
       case lookup path tcs of
         Just index -> return index
         Nothing    -> do index <- member [0..max_index]
		          restrictArg nr path index
		          return index
unifyPType nr path t = error $ "unifyPType " ++ show t ---- AR 2/10/2007

selectTerm :: FPath -> Term -> Term
selectTerm []           term        = term
selectTerm (index:path) (R  record) = selectTerm path (record !! index)


----------------------------------------------------------------------
-- FRulesEnv

data FRulesEnv = FRulesEnv {-# UNPACK #-} !Int FCatSet [FRule]
type FCatSet   = Map.Map CId (Map.Map [(FPath,FIndex)] FCat)

emptyFRulesEnv = FRulesEnv 0 (ins fcatString (mkCId "String") [] $
                              ins fcatInt    (mkCId "Int")    [] $
                              ins fcatFloat  (mkCId "Float")  [] $
                              ins fcatVar    (mkCId "_Var")   [] $
                              Map.empty) []
  where
    ins fcat cat tcs fcatSet =
      Map.insertWith (\_ -> Map.insert tcs fcat) cat tmap_s fcatSet
      where
        tmap_s = Map.singleton tcs fcat

addFRule :: FRulesEnv -> FRule -> FRulesEnv
addFRule (FRulesEnv last_id fcatSet rules) rule = FRulesEnv last_id fcatSet (rule:rules)

getFGrammar :: FRulesEnv -> FGrammar
getFGrammar (FRulesEnv last_id fcatSet rules) = (rules, Map.map Map.elems fcatSet)

genFCatHead :: FRulesEnv -> ProtoFCat -> (FRulesEnv, FCat)
genFCatHead env@(FRulesEnv last_id fcatSet rules) (PFCat cat rcs tcs _) =
  case Map.lookup cat fcatSet >>= Map.lookup tcs of
    Just fcat -> (env, fcat)
    Nothing   -> let fcat = last_id+1
                 in (FRulesEnv fcat (ins fcat) rules, fcat)
  where
    ins fcat = Map.insertWith (\_ -> Map.insert tcs fcat) cat tmap_s fcatSet
      where
        tmap_s = Map.singleton tcs fcat

genFCatArg :: TermMap -> FRulesEnv -> ProtoFCat -> (FRulesEnv, FCat)
genFCatArg cnc_defs env@(FRulesEnv last_id fcatSet rules) (PFCat cat rcs tcs ctype) =
  case Map.lookup cat fcatSet of
    Just tmap -> case Map.lookup tcs tmap of
                   Just fcat -> (env, fcat)
                   Nothing   -> ins tmap
    Nothing   -> ins Map.empty
  where
    ins tmap =
      let fcat = last_id+1
          (last_id1,tmap1,rules1)
                  = foldBM (\tcs st (last_id,tmap,rules) ->
                                   let (last_id1,tmap1,fcat_arg) = addArg tcs last_id tmap
                                       rule = FRule wildCId [[0]] [fcat_arg] fcat
                                                    (listArray (0,length rcs-1) [listArray (0,0) [FSymCat lbl 0] | lbl <- [0..length rcs-1]])
                                   in if st
                                        then (last_id1,tmap1,rule:rules)
                                        else (last_id, tmap,      rules))
                           (fcat,Map.insert tcs fcat tmap,rules)
                           (gen_tcs ctype [] [])
                           False
      in (FRulesEnv last_id1 (Map.insert cat tmap1 fcatSet) rules1, fcat)
      where
        addArg tcs last_id tmap =
	  case Map.lookup tcs tmap of
	    Just fcat -> (last_id, tmap, fcat)
	    Nothing   -> let fcat = last_id+1
                         in (fcat, Map.insert tcs fcat tmap, fcat)

    gen_tcs :: Term -> FPath -> [(FPath,FIndex)] -> BacktrackM Bool [(FPath,FIndex)]
    gen_tcs (R record)    path acc = foldM (\acc (label,ctype) -> gen_tcs ctype (label:path) acc) acc (zip [0..] record)
    gen_tcs (S _)         path acc = return acc
    gen_tcs (C max_index) path acc =
      case List.lookup path tcs of
        Just index -> return $! addConstraint path index acc
        Nothing    -> do writeState True
                         index <- member [0..max_index]
                         return $! addConstraint path index acc
      where
        addConstraint path0 index0 (c@(path,index) : cs)
	  | path0 > path = c:addConstraint path0 index0 cs
        addConstraint path0 index0 cs  = (path0,index0) : cs
    gen_tcs (F id)        path acc = case Map.lookup id cnc_defs of
                                        Just term -> gen_tcs term path acc
                                        Nothing   -> error ("unknown identifier: "++prCId id)


getRCS :: TermMap -> Term -> [FPath]
getRCS cnc_defs = loop [] []
  where
    loop path rcs (R record) = List.foldl' (\rcs (index,term) -> loop (index:path) rcs term) rcs (zip [0..] record)
    loop path rcs (C i)      = rcs
    loop path rcs (S _)      = path:rcs
    loop path rcs (F id)     = case Map.lookup id cnc_defs of
                                 Just term -> loop path rcs term
                                 Nothing   -> error ("unknown identifier: "++show id)

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
restrictProtoFCat path0 index0 (PFCat cat rcs tcs ctype) = do
  tcs <- addConstraint tcs
  return (PFCat cat rcs tcs ctype)
  where
    addConstraint (c@(path,index) : cs)
        | path0 >  path = liftM (c:) (addConstraint cs)
        | path0 == path = guard (index0 == index) >>
                          return (c : cs)
    addConstraint cs    = return ((path0,index0) : cs)
