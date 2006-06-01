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
import GF.Formalism.GCFG 
import GF.Formalism.FCFG
import GF.Formalism.MCFG(Lin(..))
import GF.Formalism.SimpleGFC 
import GF.Conversion.Types
import GF.Canon.AbsGFC(CIdent(..))

import GF.Data.BacktrackM
import GF.Data.SortedList
import GF.Data.Utilities (updateNthM)

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import Data.Array

----------------------------------------------------------------------
-- main conversion function

convertGrammar :: SGrammar -> FGrammar
convertGrammar srules = getFRules (loop frulesEnv)
  where
    (srulesMap,frulesEnv) = foldl helper (Map.empty,emptyFRulesEnv) srules
      where
        helper (srulesMap,frulesEnv) rule@(Rule (Abs decl _ _) (Cnc ctype _ _)) = 
           ( Map.insertWith (++) (decl2cat decl) [rule] srulesMap
           , foldBM (\selector _ env -> convertRule selector rule env) 
                    frulesEnv
                    (mkSingletonSelector ctype)
                    ()
           )
           
    loop frulesEnv = 
      let (todo, frulesEnv') = takeToDoRules srulesMap frulesEnv
      in case todo of
           [] -> frulesEnv'
           _  -> loop $! foldl (\env (srules,selector) -> 
                         foldl (\env srule             -> convertRule selector srule env) env srules) frulesEnv' todo


----------------------------------------------------------------------
-- rule conversion

convertRule :: STermSelector -> SRule -> FRulesEnv -> FRulesEnv
convertRule selector (Rule (Abs decl decls (Name fun profile)) (Cnc ctype ctypes (Just term))) frulesEnv =
  foldBM addRule
         frulesEnv
         (convertTerm selector term [Lin emptyPath []])
         (let cat : args = map decl2cat (decl : decls)
          in (initialFCat cat, map initialFCat args, ctype, ctypes))
  where
    addRule linRec (newCat', newArgs', _, _) env0 =
      let (env1, newCat)          = genFCatHead env0 newCat'
          (env2, newArgs,idxArgs) = foldr (\(fcat,ctype,idx) (env,args,all_args) -> 
                                       let (env1, fcat1) = genFCatArg env fcat ctype
                                       in case fcat of
                                            FCat _ _ [] _ -> (env ,      args,            all_args)
                                            _             -> (env1,fcat1:args,(idx,fcat1):all_args)) (env1,[],[]) (zip3 newArgs' ctypes [0..])
          
          (catPaths : argsPaths) = [rcs | (FCat _ _ rcs _) <- (newCat : newArgs)]
          
          newLinRec = listArray (0,length linRec-1) [translateLin idxArgs path linRec | path <- catPaths]

          (_,newProfile) = List.mapAccumL accumProf 0 newArgs'
            where
              accumProf nr (FCat _ _ [] _) = (nr,   Unify []  )
              accumProf nr _               = (nr+1, Unify [nr])

	  newName = Name fun (profile `composeProfiles` newProfile)
          rule = FRule (Abs newCat newArgs (Name fun newProfile)) newLinRec
      in addFCatRule env2 rule
convertRule selector _ frulesEnv = frulesEnv

translateLin idxArgs lbl' []                    = array (0,-1) []
translateLin idxArgs lbl' (Lin lbl syms : lins)
  | lbl' == lbl = listArray (0,length syms-1) (map instSym syms)
  | otherwise   = translateLin idxArgs lbl' lins
  where instSym = symbol (\(_, lbl, nr) -> instCat lbl nr 0 idxArgs) FSymTok
        instCat lbl nr nr' ((idx,arg@(FCat _ _ rcs _)):idxArgs)
          | nr == idx = FSymCat arg (index lbl rcs 0) nr'
          | otherwise = instCat lbl nr (nr'+1) idxArgs

        index lbl' (lbl:lbls) idx
          | lbl' == lbl = idx
          | otherwise   = index lbl' lbls $! (idx+1)

----------------------------------------------------------------------
-- term conversion

type CnvMonad a = BacktrackM Env a

type Env    = (FCat, [FCat], SLinType, [SLinType])
type LinRec = [Lin SCat SPath Token]


convertTerm :: STermSelector -> STerm -> LinRec -> CnvMonad LinRec
convertTerm selector (Arg nr cat path) (Lin lbl_path lin : lins) = convertArg selector nr cat path lbl_path lin lins
convertTerm selector (con   :^   args) (Lin lbl_path lin : lins) = convertCon selector con args lbl_path lin lins
convertTerm selector (Rec      record) (Lin lbl_path lin : lins) = convertRec selector record lbl_path lin lins
convertTerm selector (term  :.    lbl)                     lins  = convertTerm (RecPrj lbl selector) term lins
convertTerm selector (Tbl       table) (Lin lbl_path lin : lins) = convertTbl selector table  lbl_path lin lins
convertTerm selector (term  :!    sel)                     lins  = do sel <- evalTerm sel
                                                                      convertTerm (TblPrj sel selector) term lins
convertTerm selector (Variants   vars)                     lins  = do term <- member vars
                                                                      convertTerm selector term lins
convertTerm selector (t1    :++    t2)                     lins  = do lins <- convertTerm selector t2 lins
                                                                      lins <- convertTerm selector t1 lins
                                                                      return lins
convertTerm selector (Token       str) (Lin lbl_path lin : lins) = do projectHead lbl_path
                                                                      return (Lin lbl_path (Tok str : lin) : lins)
convertTerm selector (Empty          ) (Lin lbl_path lin : lins) = do projectHead lbl_path
                                                                      return (Lin lbl_path lin : lins)

convertArg (RecSel record)  nr cat path lbl_path lin lins =
  foldM (\lins (lbl,  selector) -> convertArg selector nr cat (path ++. lbl)  (lbl_path ++.  lbl) lin lins) lins record
convertArg (TblSel cases)   nr cat path lbl_path lin lins =
  foldM (\lins (term, selector) -> convertArg selector nr cat (path ++! term) (lbl_path ++! term) lin lins) lins cases
convertArg (RecPrj lbl  selector) nr cat path lbl_path lin lins = 
  convertArg selector nr cat (path ++. lbl ) lbl_path lin lins
convertArg (TblPrj term selector) nr cat path lbl_path lin lins = 
  convertArg selector nr cat (path ++! term) lbl_path lin lins
convertArg (ConSel terms)   nr cat path lbl_path lin lins = do
  sel <- member terms
  restrictHead   lbl_path sel
  restrictArg nr path sel
  return lins
convertArg StrSel          nr cat path lbl_path lin lins = do
  projectHead lbl_path
  projectArg  nr path
  return (Lin lbl_path (Cat (cat, path, nr) : lin) : lins)

convertCon (ConSel terms) con args lbl_path lin lins = do
  args <- mapM evalTerm args
  let term = con :^ args
  guard (term `elem` terms)
  restrictHead lbl_path term
  return lins

convertRec selector                 []                    lbl_path lin lins = return lins
convertRec selector@(RecSel fields) ((label, val):record) lbl_path lin lins = select fields
  where
    select []                          = convertRec selector record lbl_path lin lins
    select ((label',sub_sel) : fields)
      | label == label'                = do lins <- convertTerm sub_sel val (Lin (lbl_path ++. label) lin : lins)
                                            convertRec selector record lbl_path lin lins
      | otherwise                      = select fields
convertRec (RecPrj label sub_sel) record lbl_path lin lins = do
  (label',val) <- member record
  guard (label==label')
  convertTerm sub_sel val (Lin lbl_path lin : lins)

convertTbl selector                []                  lbl_path lin lins = return lins
convertTbl selector@(TblSel cases) ((term, val):table) lbl_path lin lins = case selector of { TblSel cases -> select cases }
  where
    select []                          = convertTbl selector table lbl_path lin lins
    select ((term',sub_sel)  : cases)
      | term == term'                  = do lins <- convertTerm sub_sel val (Lin (lbl_path ++! term) lin : lins)
                                            convertTbl selector table lbl_path lin lins
      | otherwise                      = select cases
convertTbl (TblPrj term sub_sel) table lbl_path lin lins = do
  (term',val) <- member table
  guard (term==term')
  convertTerm sub_sel val (Lin lbl_path lin : lins)


------------------------------------------------------------
-- eval a term to ground terms

evalTerm :: STerm -> CnvMonad STerm
evalTerm arg@(Arg nr _ path) = do ctype <- readArgCType nr
	                          unifyPType arg $ lintypeFollowPath path ctype
evalTerm (con :^ terms)      = do terms <- mapM evalTerm terms
                                  return (con :^ terms)
evalTerm (Rec record)        = do record <- mapM evalAssign record
                                  return (Rec record)
evalTerm (term :. lbl)       = do term <- evalTerm term
                                  evalTerm (term +. lbl)
evalTerm (Tbl table)         = do table <- mapM evalCase table
                                  return (Tbl table)
evalTerm (term :! sel)       = do sel  <- evalTerm sel
	                          evalTerm (term +! sel)
evalTerm (Variants terms)    = member terms >>= evalTerm
evalTerm (t1 :++ t2)         = do t1 <- evalTerm t1
                                  t2 <- evalTerm t2
                                  return (t1 :++ t2)
evalTerm (Token str)         = do return (Token str)
evalTerm Empty               = do return Empty

evalAssign :: (Label, STerm) -> CnvMonad (Label, STerm)
evalAssign (lbl, term) = liftM ((,) lbl) $ evalTerm term

evalCase :: (STerm, STerm) -> CnvMonad (STerm, STerm)
evalCase (pat, term) = liftM2 (,) (evalTerm pat) (evalTerm term)

unifyPType :: STerm -> SLinType -> CnvMonad STerm
unifyPType arg (RecT prec) = 
    liftM Rec $
    sequence [ liftM ((,) lbl) $
	       unifyPType (arg +. lbl) ptype |
	       (lbl, ptype) <- prec ]
unifyPType (Arg nr _ path) (ConT terms) = 
    do (_, args, _, _) <- readState
       let (FCat _ _ _ tcs) = args !! nr
       case lookup path tcs of
         Just term -> return term
         Nothing   -> do term <- member terms
		         restrictArg nr path term
		         return term


----------------------------------------------------------------------
-- FRulesEnv

data FRulesEnv = FRulesEnv {-# UNPACK #-} !Int FCatSet [FRule]

type SRulesMap = Map.Map SCat [SRule]
type FCatSet = Map.Map SCat (Map.Map [SPath] (Map.Map [(SPath,STerm)] (Either FCat FCat)))


emptyFRulesEnv = FRulesEnv 0 Map.empty []

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

genFCatArg :: FRulesEnv -> FCat -> SLinType -> (FRulesEnv, FCat)
genFCatArg env@(FRulesEnv last_id fcatSet rules) m1@(FCat _ cat rcs tcs) ctype =
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
                                       rule = FRule (Abs fcat  [fcat_arg] coercionName)
                                                    (listArray (0,length rcs-1) [listArray (0,0) [FSymCat fcat_arg lbl 0] | lbl <- [0..length rcs-1]])
                                   in if st
                                        then (Right fcat,last_id1,tmap1,rule:rules)
                                        else (x_fcat,    last_id,  tmap,     rules))
                           (Left fcat,next_id,Map.insert tcs x_fcat tmap,rules)
                           (gen_tcs ctype emptyPath [])
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

    gen_tcs :: SLinType -> SPath -> [(SPath,STerm)] -> BacktrackM Bool [(SPath,STerm)]
    gen_tcs (RecT record)      path acc = foldM (\acc (label,ctype) -> gen_tcs ctype (path ++. label) acc) acc record
    gen_tcs (TblT terms ctype) path acc = foldM (\acc term          -> gen_tcs ctype (path ++! term ) acc) acc terms
    gen_tcs (StrT)             path acc = return acc
    gen_tcs (ConT terms)       path acc =
      case List.lookup path tcs of
        Just term -> return ((path,term) : acc)
        Nothing   -> do writeState True
                        term <- member terms
                        return ((path,term) : acc)

takeToDoRules :: SRulesMap -> FRulesEnv -> ([([SRule], STermSelector)], FRulesEnv)
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
-- The STermSelector

data STermSelector
  = RecSel [(Label, STermSelector)]
  | TblSel [(STerm, STermSelector)]
  | RecPrj   Label  STermSelector
  | TblPrj   STerm  STermSelector
  | ConSel [STerm]
  | StrSel
  deriving Show


mkSingletonSelector :: SLinType -> BacktrackM () STermSelector
mkSingletonSelector ctype = do
  let (rcss,tcss) = loop emptyPath ([],[]) ctype
  rcs <- member rcss
  return (mkSelector [rcs] tcss)
  where
    loop path st          (RecT record)      = foldl (\st (lbl,ctype) -> loop (path ++. lbl ) st ctype) st record
    loop path st          (TblT terms ctype) = foldl (\st term        -> loop (path ++! term) st ctype) st terms
    loop path (rcss,tcss) (ConT terms)       = (rcss,       map ((,) path) terms : tcss)
    loop path (rcss,tcss) (StrT)             = (path : rcss,                       tcss)


mkSelector :: [SPath] -> [[(SPath,STerm)]] -> STermSelector
mkSelector rcs tcss =
  foldl addRestriction (case xs of
                          (path:xs) -> foldl addProjection (path2selector StrSel path) xs) ys
  where
    xs = [ reverse path       |               Path path       <- rcs]
    ys = [(reverse path,term) | tcs <- tcss, (Path path,term) <- tcs]
    
    addProjection :: STermSelector -> [Either Label STerm] -> STermSelector
    addProjection StrSel          []                 = StrSel
    addProjection (RecSel fields) (Left  lbl : path) = RecSel (add fields)
      where
        add []                      = [(lbl,path2selector StrSel path)]
        add (field@(lbl',sub_sel):fields)
          | lbl == lbl'             = (lbl',addProjection sub_sel path):fields
          | otherwise               = field : add fields
    addProjection (TblSel cases)  (Right pat : path) = TblSel (add cases)
      where
        add []                      = [(pat,path2selector StrSel path)]
        add (cas@(pat',sub_sel):cases)
          | pat == pat'             = (pat',addProjection sub_sel path):cases
          | otherwise               = cas : add cases
    addProjection x y = error ("addProjection "++show x ++ " " ++ prt (Path y))

    addRestriction :: STermSelector -> ([Either Label STerm],STerm) -> STermSelector
    addRestriction (ConSel terms)  ([]              ,term) = ConSel (term:terms)
    addRestriction (RecSel fields) (Left  lbl : path,term) = RecSel (add fields)
      where
        add []                      = [(lbl,path2selector (ConSel [term]) path)]
        add (field@(lbl',sub_sel):fields)
          | lbl == lbl'             = (lbl',addRestriction sub_sel (path,term)):fields
          | otherwise               = field : add fields
    addRestriction (TblSel cases)  (Right pat : path,term) = TblSel (add cases)
      where
        add []                      = [(pat,path2selector (ConSel [term]) path)]
        add (field@(pat',sub_sel):cases)
          | pat == pat'             = (pat',addRestriction sub_sel (path,term)):cases
          | otherwise               = field : add cases

    path2selector base []                 = base
    path2selector base (Left  lbl : path) = RecSel [(lbl,path2selector base path)]
    path2selector base (Right sel : path) = TblSel [(sel,path2selector base path)]


------------------------------------------------------------
-- updating the MCF rule

readArgCType :: Int -> CnvMonad SLinType
readArgCType arg = do (_, _, _, ctypes) <- readState
		      return (ctypes !! arg)

restrictArg :: Int -> SPath -> STerm -> CnvMonad ()
restrictArg arg path term
    = do (head, args, ctype, ctypes) <- readState 
	 args' <- updateNthM (restrictFCat path term) arg args
	 writeState (head, args', ctype, ctypes)

projectArg :: Int -> SPath -> CnvMonad ()
projectArg arg path
    = do (head, args, ctype, ctypes) <- readState 
	 args' <- updateNthM (projectFCat path) arg args
	 writeState (head, args', ctype, ctypes)

readHeadCType :: CnvMonad SLinType
readHeadCType = do (_, _, ctype, _) <- readState
		   return ctype

restrictHead :: SPath -> STerm -> CnvMonad ()
restrictHead path term
    = do (head, args, ctype, ctypes) <- readState
	 head' <- restrictFCat path term head
	 writeState (head', args, ctype, ctypes)

projectHead :: SPath -> CnvMonad ()
projectHead path
    = do (head, args, ctype, ctypes) <- readState
	 head' <- projectFCat path head
	 writeState (head', args, ctype, ctypes)

restrictFCat :: SPath -> STerm -> FCat -> CnvMonad FCat
restrictFCat path0 term0 (FCat id cat rcs tcs) = do
  tcs <- addConstraint tcs
  return (FCat id cat rcs tcs)
  where
    addConstraint (c@(path,term) : cs)
        | path0 >  path = liftM (c:) (addConstraint cs)
        | path0 == path = guard (term0 == term) >>
                          return (c : cs)
    addConstraint cs    = return ((path0,term0) : cs)

projectFCat :: SPath -> FCat -> CnvMonad FCat
projectFCat path0 (FCat id cat rcs tcs) = do
  return (FCat id cat (addConstraint rcs) tcs)
  where
    addConstraint (path : rcs)
        | path0 >  path = path  : addConstraint rcs
        | path0 == path = path  : rcs
    addConstraint rcs   = path0 : rcs
