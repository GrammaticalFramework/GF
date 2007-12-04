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

import GF.Devel.Grammar.Modules
import GF.Devel.Grammar.Judgements
import GF.Devel.Grammar.MkJudgements
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
     (m0,isCompl) <- do
        m <- lookupModule gf n

        -- test that the module types match, and find out if the old is complete
        testErr True ---- (mtype mo == mtype m) 
                    ("illegal extension type to module" +++ prt name)
        return (m, isCompleteModule m)

     -- build extension in a way depending on whether the old module is complete
     js0 <- extendMod isCompl n (isInherited cond) name (mjments m0) (mjments mo)

     -- if incomplete, throw away extension information
     let me' = mextends mo ----if isCompl then es else (filter ((/=n) . fst) es) 
     return $ mo {mextends = me', mjments = js0}

-- | When extending a complete module: new information is inserted,
-- and the process is interrupted if unification fails.
-- If the extended module is incomplete, its judgements are just copied.
extendMod :: Bool -> Ident -> (Ident -> Bool) -> Ident -> 
             MapJudgement -> MapJudgement -> Err MapJudgement
extendMod isCompl name cond base old new = foldM try new $ assocs old where
  try t i@(c,_) | not (cond c) = return t
  try t i@(c,_) = errIn ("constant" +++ prt c) $
                  tryInsert (extendAnyInfo isCompl name base) indirIf t i
  indirIf = if isCompl then indirInfo name else id

indirInfo :: Ident -> JEntry -> JEntry
indirInfo n info = Right $ case info of
  Right (k,b) -> (k,b) -- original link is passed
  Left j      -> (n,isConstructor j)

extendAnyInfo :: Bool -> Ident -> Ident -> JEntry -> JEntry -> Err JEntry
extendAnyInfo isc n o i j = 
  errIn ("building extension for" +++ prt n +++ "in" +++ prt o) $ case (i,j) of
    (Left j1,Left j2) -> liftM Left $ unifyJudgement j1 j2
    (Right (m1,b1), Right (m2,b2)) -> do
      testErr (b1 == b2) "inconsistent indirection status"
      testErr (m1 == m2) $ 
        "different sources of inheritance:" +++ show m1 +++ show m2
      return i
    _ -> Bad $ "cannot unify information in"---- ++++ prt i ++++ "and" ++++ prt j

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
  MTInstance i0 -> do
          m1 <- lookupModule gr i0
          testErr (mtype m1 == MTInterface) 
                  ("interface expected as type of" +++ prt i0)
          js' <- extendMod False i0 (const True) i (mjments m1) (mjments mi)
          --- to avoid double inclusions, in instance I of I0 = J0 ** ...
          case mextends mi of
            [] -> return $ (i,mi {mjments = js'})
            j0s -> do 
              m0s <- mapM (lookupModule gr . fst) j0s ---- restricted?? 12/2007
              let notInM0 c _  = all (notMember c . mjments) m0s
              let js2 = filterWithKey notInM0 js'
              return $ (i,mi {mjments = js2})

    -- add the instance opens to an incomplete module "with" instances
    --      ModWith mt stat ext me ops -> do
    --    ModWith (Module mt stat fs_ me ops_ js_) (ext,incl) ops -> do

  _ -> case minstances mi of
    [((ext,incl),ops)] -> do
        let infs  = Prelude.map fst ops
        let stat' = Prelude.null [i | (_,i) <- minterfaces mi, notElem i infs]
        testErr stat' ("module" +++ prt i +++ "remains incomplete")
           --        Module mt0 _ fs me' ops0 js <- lookupModMod gr ext
        mo0 <- lookupModule gr ext
        let ops1 = nub $
                     mopens mi ++   -- N.B. mo0 has been name-resolved already
                     ops ++ 
                     [(n,o) | (n,o) <- mopens mo0, notElem o infs] ++
                     [(i,i) | i <- Prelude.map snd ops] ----
                     ----    ++ [oSimple i   | i <- map snd ops] ----

        --- check if me is incomplete
        let fs1 = union (mflags mi) (mflags mo0)  -- new flags have priority
        let js0 = [ci | ci@(c,_) <- assocs (mjments mo0), isInherited incl c]
        let js1 = fromList (assocs (mjments mi) ++ js0)
        return $ (i,mo0 {
          mflags = fs1, 
          mextends = mextends mi,
          mopens = ops1,
          mjments = js1
          })
    _ -> return (i,mi)

