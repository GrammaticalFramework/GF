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


module GF.Conversion.SimpleToFCFG
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print
import GF.Infra.Ident

import Control.Monad

import GF.Formalism.Utilities
import GF.Formalism.FCFG
import GF.Conversion.Types
import GF.Canon.GFCC.AbsGFCC
import GF.Canon.GFCC.DataGFCC

import GF.Data.BacktrackM
import GF.Data.SortedList
import GF.Data.Utilities (updateNthM)

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import Data.Array
import Data.Maybe

----------------------------------------------------------------------
-- main conversion function

convertGrammar :: Grammar -> [(Ident,FGrammar)]
convertGrammar g@(Grm hdr (Abs abs_defs) cncs) = [(i2i cncname,convert abs_defs conc) | cncname <- cncnames gfcc, conc <- Map.lookup cncname (concretes gfcc)]
  where
    gfcc = mkGFCC g

    i2i (CId i) = IC i

    convert :: [AbsDef] -> TermMap -> FGrammar
    convert abs_defs cnc_defs = getFRules (loop frulesEnv)
      where
        srules = [(XRule id args res (map findLinType args) (findLinType res) term) | Fun id (Typ args res) exp <- abs_defs, term <- Map.lookup id cnc_defs]
        
        findLinType (CId id) = fromJust (Map.lookup (CId ("__"++id)) cnc_defs)

        (srulesMap,frulesEnv) = List.foldl' helper (Map.empty,emptyFRulesEnv) srules
           where
	     helper (srulesMap,frulesEnv) rule@(XRule id abs_args abs_res cnc_args cnc_res term) = 
	       let srulesMap' = Map.insertWith (++) abs_res [rule] srulesMap
	           frulesEnv' = List.foldl' (\env selector -> convertRule cnc_defs selector rule env)
	                                    frulesEnv
	                                    (mkSingletonSelectors cnc_res)
               in srulesMap' `seq` frulesEnv' `seq` (srulesMap',frulesEnv')

        loop frulesEnv =
          let (todo, frulesEnv') = takeToDoRules srulesMap frulesEnv
          in case todo of
               [] -> frulesEnv'
               _  -> loop $! List.foldl' (\env (srules,selector) -> 
                             List.foldl' (\env srule             -> convertRule cnc_defs selector srule env) env srules) frulesEnv' todo

convertRule :: TermMap -> TermSelector -> XRule -> FRulesEnv -> FRulesEnv
convertRule cnc_defs selector (XRule fun args cat ctypes ctype term) frulesEnv =
  foldBM addRule
         frulesEnv
         (convertTerm cnc_defs selector term [([],[])])
         (initialFCat cat, map (\scat -> (initialFCat scat,[])) args, ctype, ctypes)
  where
    addRule linRec (newCat', newArgs', _, _) env0 =
      let (env1, newCat)          = genFCatHead env0 newCat'
          (env2, newArgs,idxArgs) = foldr (\((fcat@(FCat _ cat rcs tcs),xpaths),ctype,idx) (env,args,all_args) ->
                                       let xargs          = fcat:[FCat 0 cat [path] tcs | path <- reverse xpaths]
                                           (env1, xargs1) = List.mapAccumL (genFCatArg ctype) env xargs
                                       in case fcat of
                                            FCat _ _ [] _ -> (env ,        args,             all_args)
                                            _             -> (env1,xargs1++args,(idx,xargs1):all_args)) (env1,[],[]) (zip3 newArgs' ctypes [0..])

          newLinRec = listArray (0,length linRec-1) [translateLin idxArgs path linRec | path <- case newCat of {FCat _ _ rcs _ -> rcs}]

          (_,newProfile) = List.mapAccumL accumProf 0 newArgs'
            where
              accumProf nr (FCat _ _ [] _,_     ) = (nr,       Unify []          )
              accumProf nr (_            ,xpaths) = (nr+cnt+1, Unify [nr..nr+cnt])
                where cnt = length xpaths

          rule = FRule (Name fun newProfile) newArgs newCat newLinRec
      in addFCatRule env2 rule

translateLin idxArgs lbl' []                    = array (0,-1) []
translateLin idxArgs lbl' ((lbl,syms) : lins)
  | lbl' == lbl = listArray (0,length syms-1) (map instSym syms)
  | otherwise   = translateLin idxArgs lbl' lins
  where
    instSym = symbol (\(lbl, nr, xnr) -> instCat lbl nr xnr 0 idxArgs) FSymTok
    instCat lbl nr xnr nr' ((idx,xargs):idxArgs)
      | nr == idx = let arg@(FCat _ _ rcs _) = xargs !! xnr
                    in FSymCat arg (index lbl rcs 0) (nr'+xnr)
      | otherwise = instCat lbl nr xnr (nr'+length xargs) idxArgs

    index lbl' (lbl:lbls) idx
      | lbl' == lbl = idx
      | otherwise   = index lbl' lbls $! (idx+1)


----------------------------------------------------------------------
-- term conversion

type CnvMonad a = BacktrackM Env a

type Env     = (FCat, [(FCat,[FPath])], Term, [Term])
type LinRec  = [(FPath, [Symbol (FPath, FIndex, Int) Token])]

type TermMap = Map.Map CId Term

convertTerm :: TermMap -> TermSelector -> Term -> LinRec -> CnvMonad LinRec
convertTerm cnc_defs selector (V nr)       ((lbl_path,lin) : lins) = convertArg selector nr []    lbl_path lin lins
convertTerm cnc_defs selector (C nr)       ((lbl_path,lin) : lins) = convertCon selector nr       lbl_path lin lins
convertTerm cnc_defs selector (R record)   ((lbl_path,lin) : lins) = convertRec cnc_defs selector 0 record lbl_path lin lins
convertTerm cnc_defs selector (P term sel)                   lins  = do nr <- evalTerm cnc_defs [] sel
                                                                        convertTerm cnc_defs (TuplePrj nr selector) term lins
convertTerm cnc_defs selector (FV vars)                      lins  = do term <- member vars
                                                                        convertTerm cnc_defs selector term lins
convertTerm cnc_defs selector (S ts)       ((lbl_path,lin) : lins) = do projectHead lbl_path
                                                                        foldM (\lins t -> convertTerm cnc_defs selector t lins) ((lbl_path,lin) : lins) (reverse ts)
convertTerm cnc_defs selector (KS str)     ((lbl_path,lin) : lins) = do projectHead lbl_path
                                                                        return ((lbl_path,Tok str : lin) : lins)
convertTerm cnc_defs selector (KP (str:_)_)((lbl_path,lin) : lins) = do projectHead lbl_path
                                                                        return ((lbl_path,Tok str : lin) : lins)
convertTerm cnc_defs selector (RP _ term)                    lins  = convertTerm cnc_defs selector term lins
convertTerm cnc_defs selector (F id)                         lins  = do term <- Map.lookup id cnc_defs
                                                                        convertTerm cnc_defs selector term lins
convertTerm cnc_defs selector (W s ss)     ((lbl_path,lin) : lins) = convertRec cnc_defs selector 0 [KS (s ++ s1) | s1 <- ss] lbl_path lin lins
convertTerm cnc_defs selector x lins  = error ("convertTerm ("++show x++")")


convertArg (TupleSel record)  nr path lbl_path lin lins =
  foldM (\lins (lbl,  selector) -> convertArg selector nr (lbl:path)  (lbl:lbl_path) lin lins) lins record
convertArg (TuplePrj lbl selector) nr path lbl_path lin lins = 
  convertArg selector nr (lbl:path) lbl_path lin lins
convertArg (ConSel indices) nr path lbl_path lin lins = do
  index <- member indices
  restrictHead lbl_path index
  restrictArg nr path index
  return lins
convertArg StrSel nr path lbl_path lin lins = do
  projectHead lbl_path
  xnr <- projectArg nr path
  return ((lbl_path, Cat (path, nr, xnr) : lin) : lins)

convertCon (ConSel indices) index lbl_path lin lins = do
  guard (index `elem` indices)
  restrictHead lbl_path index
  return lins

convertRec cnc_defs selector                   index []           lbl_path lin lins = return lins
convertRec cnc_defs selector@(TupleSel fields) index (val:record) lbl_path lin lins = select fields
  where
    select []                          = convertRec cnc_defs selector (index+1) record lbl_path lin lins
    select ((index',sub_sel) : fields)
      | index == index'                = do lins <- convertTerm cnc_defs sub_sel val ((index:lbl_path,lin) : lins)
                                            convertRec cnc_defs selector (index+1) record lbl_path lin lins
      | otherwise                      = select fields
convertRec cnc_defs (TuplePrj index' sub_sel) index record lbl_path lin lins = do
  convertTerm cnc_defs sub_sel (record !! (index'-index)) ((lbl_path,lin) : lins)


------------------------------------------------------------
-- eval a term to ground terms

evalTerm :: TermMap -> FPath -> Term -> CnvMonad FIndex
evalTerm cnc_defs path (V nr)       = do term <- readArgCType nr
                                         unifyPType nr (reverse path) (selectTerm path term)
evalTerm cnc_defs path (C nr)       = return nr
evalTerm cnc_defs path (R record)   = case path of
                                        (index:path) -> evalTerm cnc_defs path (record !! index)
evalTerm cnc_defs path (P term sel) = do index <- evalTerm cnc_defs [] sel
                                         evalTerm cnc_defs (index:path) term
evalTerm cnc_defs path (FV terms)   = member terms >>= evalTerm cnc_defs path
evalTerm cnc_defs path (RP alias _) = evalTerm cnc_defs path alias
evalTerm cnc_defs path (F id)       = do term <- Map.lookup id cnc_defs
                                         evalTerm cnc_defs path term
evalTerm cnc_defs path x = error ("evalTerm ("++show x++")")

unifyPType :: FIndex -> FPath -> Term -> CnvMonad FIndex
unifyPType nr path (C max_index) =
    do (_, args, _, _) <- readState
       let (FCat _ _ _ tcs,_) = args !! nr
       case lookup path tcs of
         Just index -> return index
         Nothing    -> do index <- member [0..max_index-1]
		          restrictArg nr path index
		          return index
unifyPType nr path (RP alias _) = unifyPType nr path alias

selectTerm :: FPath -> Term -> Term
selectTerm []           term        = term
selectTerm (index:path) (R  record) = selectTerm path (record !! index)
selectTerm path         (RP _ term) = selectTerm path term

----------------------------------------------------------------------
-- FRulesEnv

data FRulesEnv = FRulesEnv {-# UNPACK #-} !Int FCatSet [FRule]

type XRulesMap = Map.Map CId [XRule]
data XRule     = XRule CId     {- function -}
                       [CId]   {- argument types -}
                       CId     {- result   type  -}
                       [Term]  {- argument lin-types representation -}
                       Term    {- result   lin-type  representation -}
                       Term    {- body -}
type FCatSet   = Map.Map CId (Map.Map [FPath] (Map.Map [(FPath,FIndex)] (Either FCat FCat)))


emptyFRulesEnv = FRulesEnv 0 (ins fcatString (ins fcatInt (ins fcatFloat Map.empty))) []
  where
    ins fcat@(FCat _ cat rcs tcs) fcatSet =
      Map.insertWith (\_ -> Map.insertWith (\_ -> Map.insert tcs x_fcat) rcs tmap_s) cat rmap_s fcatSet
      where
        x_fcat = Right fcat
        tmap_s = Map.singleton tcs x_fcat
        rmap_s = Map.singleton rcs tmap_s

genFCatHead :: FRulesEnv -> FCat -> (FRulesEnv, FCat)
genFCatHead env@(FRulesEnv last_id fcatSet rules) m1@(FCat _ cat rcs tcs) =
  case Map.lookup cat fcatSet >>= Map.lookup rcs >>= Map.lookup tcs of
    Just (Left  fcat) -> (FRulesEnv last_id (ins fcat) rules, fcat)
    Just (Right fcat) -> (env, fcat)
    Nothing           -> let next_id = last_id+1
                             fcat    = FCat next_id cat rcs tcs
                         in (FRulesEnv next_id (ins fcat) rules, fcat)
  where
    ins fcat = Map.insertWith (\_ -> Map.insertWith (\_ -> Map.insert tcs x_fcat) rcs tmap_s) cat rmap_s fcatSet
      where
        x_fcat = Right fcat
        tmap_s = Map.singleton tcs x_fcat
        rmap_s = Map.singleton rcs tmap_s

genFCatArg :: Term -> FRulesEnv -> FCat -> (FRulesEnv, FCat)
genFCatArg ctype env@(FRulesEnv last_id fcatSet rules) m1@(FCat _ cat rcs tcs) =
  case Map.lookup cat fcatSet >>= Map.lookup rcs of
    Just tmap -> case Map.lookup tcs tmap of
                   Just (Left  fcat) -> (env,   fcat)
                   Just (Right fcat) -> (env,   fcat)
                   Nothing           -> ins tmap
    Nothing   -> ins Map.empty
  where
    ins tmap =
      let next_id = last_id+1
          fcat    = FCat next_id cat rcs tcs
          (x_fcat,last_id1,tmap1,rules1)
                  = foldBM (\tcs st (x_fcat,last_id,tmap,rules) ->
                                   let (last_id1,tmap1,fcat_arg) = addArg tcs last_id tmap
                                       rule = FRule (Name (CId "_") [Unify [0]]) [fcat_arg] fcat
                                                    (listArray (0,length rcs-1) [listArray (0,0) [FSymCat fcat_arg lbl 0] | lbl <- [0..length rcs-1]])
                                   in if st
                                        then (Right fcat,last_id1,tmap1,rule:rules)
                                        else (x_fcat,    last_id,  tmap,     rules))
                           (Left fcat,next_id,Map.insert tcs x_fcat tmap,rules)
                           (gen_tcs ctype [] [])
                           False
          rmap1 = Map.singleton rcs tmap1
      in (FRulesEnv last_id1 (Map.insertWith (\_ -> Map.insert rcs tmap1) cat rmap1 fcatSet) rules1, fcat)
      where
        addArg tcs last_id tmap =
	  case Map.lookup tcs tmap of
	    Just (Left  fcat) -> (last_id, tmap, fcat)
	    Just (Right fcat) -> (last_id, tmap, fcat)
	    Nothing           -> let next_id = last_id+1
	                             fcat    = FCat next_id cat rcs tcs
                                 in (next_id, Map.insert tcs (Left fcat) tmap, fcat)

    gen_tcs :: Term -> FPath -> [(FPath,FIndex)] -> BacktrackM Bool [(FPath,FIndex)]
    gen_tcs (R record)    path acc = foldM (\acc (label,ctype) -> gen_tcs ctype (label:path) acc) acc (zip [0..] record)
    gen_tcs (S _)         path acc = return acc
    gen_tcs (RP _ term)   path acc = gen_tcs term path acc
    gen_tcs (C max_index) path acc =
      case List.lookup path tcs of
        Just index -> return $! addConstraint path index acc
        Nothing    -> do writeState True
                         index <- member [0..max_index-1]
                         return $! addConstraint path index acc
      where
        addConstraint path0 index0 (c@(path,index) : cs)
	  | path0 > path = c:addConstraint path0 index0 cs
        addConstraint path0 index0 cs  = (path0,index0) : cs

takeToDoRules :: XRulesMap -> FRulesEnv -> ([([XRule], TermSelector)], FRulesEnv)
takeToDoRules srulesMap (FRulesEnv last_id fcatSet rules) = (todo,FRulesEnv last_id fcatSet' rules)
  where
    (todo,fcatSet') =
          Map.mapAccumWithKey (\todo cat rmap ->
                let (todo1,rmap1) = Map.mapAccumWithKey (\todo rcs tmap -> 
                                          let (tcss,tmap') = Map.mapAccumWithKey (\tcss tcs x_fcat ->
                                                                   case x_fcat of
                                                                     Left  fcat -> (tcs:tcss,Right fcat)
                                                                     Right fcat -> (    tcss,    x_fcat)) [] tmap
                                          in case tcss of
                                               [] -> (                               todo,tmap )
                                               _  -> ((srules,mkSelector rcs tcss) : todo,tmap')) todo rmap
                    mb_srules   = Map.lookup cat srulesMap
                    Just srules = mb_srules

                in case mb_srules of
                     Just srules -> (todo1,rmap1)
                     Nothing     -> (todo ,rmap1)) [] fcatSet

addFCatRule :: FRulesEnv -> FRule -> FRulesEnv
addFCatRule (FRulesEnv last_id fcatSet rules) rule = FRulesEnv last_id fcatSet (rule:rules)

getFRules :: FRulesEnv -> [FRule]
getFRules (FRulesEnv last_id fcatSet rules) = rules


------------------------------------------------------------
-- The TermSelector

data TermSelector
  = TupleSel [(FIndex, TermSelector)]
  | TuplePrj   FIndex  TermSelector
  | ConSel   [FIndex]
  | StrSel
  deriving Show

mkSingletonSelectors :: Term               -- ^ Type representation term
                     -> [TermSelector]     -- ^ list of selectors containing just one string field
mkSingletonSelectors term = sels0
  where
    (sels0,tcss0) = loop [] ([],[]) term

    loop path st          (R record) = List.foldl' (\st (index,term) -> loop (index:path) st term) st (zip [0..] record)
    loop path st          (RP _ t)   = loop path st t
    loop path (sels,tcss) (C i)      = (                          sels,map ((,) path) [0..i-1] : tcss)
    loop path (sels,tcss) (S _)      = (mkSelector [path] tcss0 : sels,                          tcss)

mkSelector :: [FPath] -> [[(FPath,FIndex)]] -> TermSelector
mkSelector rcs tcss =
  List.foldl' addRestriction (case xs of
                                (path:xs) -> List.foldl' addProjection (path2selector StrSel path) xs) ys
  where
    xs = [ reverse path       |               path       <- rcs]
    ys = [(reverse path,term) | tcs <- tcss, (path,term) <- tcs]
    
    addRestriction :: TermSelector -> (FPath,FIndex) -> TermSelector
    addRestriction (ConSel indices)  ([]          ,n_index) = ConSel (add indices)
      where
        add []                      = [n_index]
        add (index':indices)
          | n_index == index'       = index':    indices
          | otherwise               = index':add indices
    addRestriction (TupleSel fields) (index : path,n_index) = TupleSel (add fields)
      where
        add []                      = [(index,path2selector (ConSel [n_index]) path)]
        add (field@(index',sub_sel):fields)
          | index == index'         = (index',addRestriction sub_sel (path,n_index)):fields
          | otherwise               = field : add fields

    addProjection :: TermSelector -> FPath -> TermSelector
    addProjection StrSel            []             = StrSel
    addProjection (TupleSel fields) (index : path) = TupleSel (add fields)
      where
        add []                      = [(index,path2selector StrSel path)]
        add (field@(index',sub_sel):fields)
          | index == index'         = (index',addProjection sub_sel path):fields
          | otherwise               = field : add fields
    
    path2selector base []             = base
    path2selector base (index : path) = TupleSel [(index,path2selector base path)]

------------------------------------------------------------
-- updating the MCF rule

readArgCType :: FIndex -> CnvMonad Term
readArgCType nr = do (_, _, _, ctypes) <- readState
		     return (ctypes !! nr)

restrictArg :: FIndex -> FPath -> FIndex -> CnvMonad ()
restrictArg nr path index = do
  (head, args, ctype, ctypes) <- readState 
  args' <- updateNthM (\(fcat,xs) -> do fcat <- restrictFCat path index fcat
                                        return (fcat,xs)                    ) nr args
  writeState (head, args', ctype, ctypes)

projectArg :: FIndex -> FPath -> CnvMonad Int
projectArg nr path = do
  (head, args, ctype, ctypes) <- readState
  (xnr,args') <- updateArgs nr args
  writeState (head, args', ctype, ctypes)
  return xnr
  where
    updateArgs :: FIndex -> [(FCat,[FPath])] -> CnvMonad (Int,[(FCat,[FPath])])
    updateArgs 0 ((a@(FCat _ _ rcs _),xpaths) : as)
      | path `elem` rcs = return (length xpaths+1,(a,path:xpaths):as)
      | otherwise       = do a <- projectFCat path a
                             return (0,(a,xpaths):as)
    updateArgs n (a : as) = do
      (xnr,as) <- updateArgs (n-1) as
      return (xnr,a:as)

readHeadCType :: CnvMonad Term
readHeadCType = do (_, _, ctype, _) <- readState
		   return ctype

restrictHead :: FPath -> FIndex -> CnvMonad ()
restrictHead path term
    = do (head, args, ctype, ctypes) <- readState
	 head' <- restrictFCat path term head
	 writeState (head', args, ctype, ctypes)

projectHead :: FPath -> CnvMonad ()
projectHead path
    = do (head, args, ctype, ctypes) <- readState
	 head' <- projectFCat path head
	 writeState (head', args, ctype, ctypes)

restrictFCat :: FPath -> FIndex -> FCat -> CnvMonad FCat
restrictFCat path0 index0 (FCat id cat rcs tcs) = do
  tcs <- addConstraint tcs
  return (FCat id cat rcs tcs)
  where
    addConstraint (c@(path,index) : cs)
        | path0 >  path = liftM (c:) (addConstraint cs)
        | path0 == path = guard (index0 == index) >>
                          return (c : cs)
    addConstraint cs    = return ((path0,index0) : cs)

projectFCat :: FPath -> FCat -> CnvMonad FCat
projectFCat path0 (FCat id cat rcs tcs) = do
  return (FCat id cat (addConstraint rcs) tcs)
  where
    addConstraint (path : rcs)
        | path0 >  path = path  : addConstraint rcs
        | path0 == path = path  : rcs
    addConstraint rcs   = path0 : rcs
