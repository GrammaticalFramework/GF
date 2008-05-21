----------------------------------------------------------------------
-- |
-- Module      : Extend
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 21:08:14 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.18 $
--
-- AR 14\/5\/2003 -- 11\/11
-- 4/12/2007 this module is still very very messy... ----
--
-- The top-level function 'extendModule'
-- extends a module symbol table by indirections to the module it extends
-----------------------------------------------------------------------------

module GF.Devel.Compile.Extend (
  extendModule
  ) where

import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import GF.Devel.Grammar.PrGF
import GF.Devel.Grammar.Lookup
import GF.Devel.Grammar.Macros

import GF.Infra.Ident

import GF.Data.Operations

import Data.List (nub)
import Data.Map
import Control.Monad

extendModule :: GF -> SourceModule -> Err SourceModule
extendModule gf nmo0 = do
  (name,mo) <- rebuildModule gf nmo0
  case mtype mo of

  ---- Just to allow inheritance in incomplete concrete (which are not
  ---- compiled anyway), extensions are not built for them.
  ---- Should be replaced by real control. AR 4/2/2005
    MTConcrete _ | not (isCompleteModule mo) -> return (name,mo)
    _  -> do
      mo' <- foldM (extOne name) mo (mextends mo) 
      return (name, mo') 
 where
   extOne name mo (n,cond) = do
     mo0 <- lookupModule gf n

     -- test that the module types match
     testErr True ---- (legalExtension mo mo0) 
                    ("illegal extension type to module" +++ prt name)

     -- find out if the old is complete
     let isCompl = isCompleteModule mo0

     -- if incomplete, remove it from extension list --- because??
     let me' = (if isCompl then id else (Prelude.filter ((/=n) . fst))) 
                 (mextends mo) 

     -- build extension depending on whether the old module is complete
     js0 <- extendMod isCompl n (isInherited cond) name (mjments mo0) (mjments mo)

     return $ mo {mextends = me', mjments = js0}

-- | When extending a complete module: new information is inserted,
-- and the process is interrupted if unification fails.
-- If the extended module is incomplete, its judgements are just copied.
extendMod :: Bool -> Ident -> (Ident -> Bool) -> Ident -> 
             Map Ident Judgement -> Map Ident Judgement -> 
             Err (Map Ident Judgement)
extendMod isCompl name cond base old new = foldM try new $ assocs old where
  try t i@(c,_) | not (cond c) = return t
  try t i@(c,_) = errIn ("constant" +++ prt c) $
                  tryInsert (extendAnyInfo isCompl name base) indirIf t i
  indirIf = if isCompl then indirInfo name else id

indirInfo :: Ident -> Judgement -> Judgement
indirInfo n ju = case jform ju of
  JLink -> ju -- original link is passed
  _     -> linkInherited (isConstructor ju) n

extendAnyInfo :: Bool -> Ident -> Ident -> Judgement -> Judgement -> Err Judgement
extendAnyInfo isc n o i j = 
  errIn ("building extension for" +++ prt n +++ "in" +++ prt o) $ 
  unifyJudgement i j

tryInsert :: Ord a => (b -> b -> Err b) -> (b -> b) ->
             Map a b -> (a,b) -> Err (Map a b)
tryInsert unif indir tree z@(x, info) = case Data.Map.lookup x tree of
  Just info0 -> do
    info1 <- unif info info0
    return $ insert x info1 tree 
  _ -> return $ insert x (indir info) tree

-- | rebuilding instance + interface, and "with" modules, prior to renaming. 
-- AR 24/10/2003
rebuildModule :: GF -> SourceModule -> Err SourceModule
rebuildModule gr mo@(i,mi) = case mtype mi of

  -- copy interface contents to instance
  MTInstance i0 -> do
    m0 <- lookupModule gr i0
    testErr (isInterface m0) ("not an interface:" +++ prt i0)
    js1 <- extendMod False i0 (const True) i (mjments m0) (mjments mi)

    --- to avoid double inclusions, in instance J of I0 = J0 ** ...
    case mextends mi of
      [] -> return $ (i,mi {mjments = js1})
      es -> do 
        mes <- mapM (lookupModule gr . fst) es ---- restricted?? 12/2007
        let notInExts c _  = all (notMember c . mjments) mes
        let js2 = filterWithKey notInExts js1
        return $ (i,mi {
          mjments = js2
          })

  -- copy functor contents to instantiation, and also add opens
  _ -> case minstances mi of
    [((ext,incl),ops)] -> do
      let interfs  = Prelude.map fst ops

      -- test that all interfaces are instantiated
      let isCompl = Prelude.null [i | (_,i) <- minterfaces mi, notElem i interfs]
      testErr isCompl ("module" +++ prt i +++ "remains incomplete")

      -- look up the functor and build new opens set
      mi0 <- lookupModule gr ext
      let 
        ops1 = nub $
             mopens mi   -- own opens; N.B. mi0 has been name-resolved already
          ++ ops         -- instantiating opens
          ++ [(n,o) | 
               (n,o) <- mopens mi0, notElem o interfs] -- ftor's non-if opens
          ++ [(i,i) | i <- Prelude.map snd ops] ----   -- insts w. real names

      -- combine flags; new flags have priority
      let fs1 = union (mflags mi) (mflags mi0)  
      
      -- copy inherited functor judgements
      let js0 = [ci | ci@(c,_) <- assocs (mjments mi0), isInherited incl c]
      let js1 = fromList (assocs (mjments mi) ++ js0)

      return $ (i,mi {
          mflags = fs1, 
          mextends = mextends mi,  -- extends of instantiation
          mopens = ops1,
          mjments = js1
          })
    _ -> return (i,mi)

