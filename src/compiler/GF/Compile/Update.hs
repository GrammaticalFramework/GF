----------------------------------------------------------------------
-- |
-- Module      : Update
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 18:39:44 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.8 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Compile.Update (buildAnyTree, extendModule, rebuildModule) where

import GF.Infra.Ident
import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Grammar.Lookup
import GF.Infra.Modules
import GF.Infra.Option

import GF.Data.Operations

import Data.List
import qualified Data.Map as Map
import Control.Monad
import Text.PrettyPrint

-- | combine a list of definitions into a balanced binary search tree
buildAnyTree :: Ident -> [(Ident,Info)] -> Err (BinTree Ident Info)
buildAnyTree m = go Map.empty
  where
    go map []         = return map
    go map ((c,j):is) = do
      case Map.lookup c map of
        Just i  -> case unifyAnyInfo m i j of
		     Ok k  -> go (Map.insert c k map) is
		     Bad _ -> fail $ render (text "cannot unify the informations" $$ 
		                             nest 4 (ppJudgement Qualified (c,i)) $$
		                             text "and" $+$
		                             nest 4 (ppJudgement Qualified (c,j)) $$
		                             text "in module" <+> ppIdent m)
        Nothing -> go (Map.insert c j map) is

extendModule :: SourceGrammar -> SourceModule -> Err SourceModule
extendModule gr (name,m)
  ---- Just to allow inheritance in incomplete concrete (which are not
  ---- compiled anyway), extensions are not built for them.
  ---- Should be replaced by real control. AR 4/2/2005
  | mstatus m == MSIncomplete && isModCnc m = return (name,m)
  | otherwise                               = do m' <- foldM extOne m (extend m) 
                                                 return (name,m')
 where
   extOne mo (n,cond) = do
     m0 <- lookupModule gr n

     -- test that the module types match, and find out if the old is complete
     testErr (sameMType (mtype m) (mtype mo)) 
             ("illegal extension type to module" +++ showIdent name)

     let isCompl = isCompleteModule m0

     -- build extension in a way depending on whether the old module is complete
     js1 <- extendMod gr isCompl (n, isInherited cond) name (jments m0) (jments mo)

     -- if incomplete, throw away extension information
     return $ 
          if isCompl
            then mo {jments = js1}
            else mo {extend = filter ((/=n) . fst) (extend mo)
                    ,mexdeps= nub (n : mexdeps mo)
                    ,jments = js1
                    }

-- | rebuilding instance + interface, and "with" modules, prior to renaming. 
-- AR 24/10/2003
rebuildModule :: SourceGrammar -> SourceModule -> Err SourceModule
rebuildModule gr mo@(i,mi@(ModInfo mt stat fs_ me mw ops_ med_ js_)) = do
----  deps <- moduleDeps ms
----  is   <- openInterfaces deps i
  let is = [] ---- the method above is buggy: try "i -src" for two grs. AR 8/3/2005
  mi'  <- case mw of

    -- add the information given in interface into an instance module
    Nothing -> do
      testErr (null is || mstatus mi == MSIncomplete) 
              ("module" +++ showIdent i +++ 
               "has open interfaces and must therefore be declared incomplete") 
      case mt of
        MTInstance i0 -> do
          m1 <- lookupModule gr i0
          testErr (isModRes m1) ("interface expected instead of" +++ showIdent i0)
          js' <- extendMod gr False (i0,const True) i (jments m1) (jments mi)
          --- to avoid double inclusions, in instance I of I0 = J0 ** ...
          case extends mi of
            []  -> return $ replaceJudgements mi js'
            j0s -> do
                m0s <- mapM (lookupModule gr) j0s
                let notInM0 c _  = all (not . isInBinTree c . jments) m0s
                let js2 = filterBinTree notInM0 js'
                return $ replaceJudgements mi js2
        _ -> return mi

    -- add the instance opens to an incomplete module "with" instances
    Just (ext,incl,ops) -> do
      let (infs,insts) = unzip ops
      let stat' = ifNull MSComplete (const MSIncomplete)
                    [i | i <- is, notElem i infs]
      testErr (stat' == MSComplete || stat == MSIncomplete) 
              ("module" +++ showIdent i +++ "remains incomplete")
      ModInfo mt0 _ fs me' _ ops0 _ js <- lookupModule gr ext
      let ops1 = nub $
                   ops_ ++ -- N.B. js has been name-resolved already
                   [OQualif i j | (i,j) <- ops] ++
                   [o | o <- ops0, notElem (openedModule o) infs] ++
                   [OQualif i i | i <- insts] ++
                   [OSimple i   | i <- insts]

      --- check if me is incomplete
      let fs1 = fs `addOptions` fs_                           -- new flags have priority
      let js0 = [ci | ci@(c,_) <- tree2list js, isInherited incl c]
      let js1 = buildTree (tree2list js_ ++ js0)
      let med1= nub (ext : infs ++ insts ++ med_)
      return $ ModInfo mt0 stat' fs1 me Nothing ops1 med1 js1

  return (i,mi')

-- | When extending a complete module: new information is inserted,
-- and the process is interrupted if unification fails.
-- If the extended module is incomplete, its judgements are just copied.
extendMod :: SourceGrammar ->
             Bool -> (Ident,Ident -> Bool) -> Ident -> 
             BinTree Ident Info -> BinTree Ident Info -> 
             Err (BinTree Ident Info)
extendMod gr isCompl (name,cond) base old new = foldM try new $ Map.toList old 
  where
    try new (c,i)
      | not (cond c) = return new
      | otherwise    = case Map.lookup c new of
                         Just j -> case unifyAnyInfo name i j of
		                     Ok k  -> return $ updateTree (c,k) new
		                     Bad _ -> do (base,j) <- case j of 
		                                               AnyInd _ m -> lookupOrigInfo gr (m,c)
		                                               _          -> return (base,j)
		                                 (name,i) <- case i of 
                                                               AnyInd _ m -> lookupOrigInfo gr (m,c)
                                                               _          -> return (name,i)
		                                 fail $ render (text "cannot unify the information" $$ 
		                                                nest 4 (ppJudgement Qualified (c,i)) $$
		                                                text "in module" <+> ppIdent name <+> text "with" $$
		                                                nest 4 (ppJudgement Qualified (c,j)) $$
		                                                text "in module" <+> ppIdent base)
                         Nothing-> if isCompl
                                     then return $ updateTree (c,indirInfo name i) new
                                     else return $ updateTree (c,i) new

    indirInfo :: Ident -> Info -> Info
    indirInfo n info = AnyInd b n' where 
      (b,n') = case info of
        ResValue _ -> (True,n)
        ResParam _ _ -> (True,n)
        AbsFun _ _ Nothing -> (True,n) 
        AnyInd b k -> (b,k)
        _ -> (False,n) ---- canonical in Abs

unifyAnyInfo :: Ident -> Info -> Info -> Err Info
unifyAnyInfo m i j = case (i,j) of
  (AbsCat mc1, AbsCat mc2) -> 
    liftM AbsCat (unifMaybeL mc1 mc2)
  (AbsFun mt1 ma1 md1, AbsFun mt2 ma2 md2) -> 
    liftM3 AbsFun (unifMaybeL mt1 mt2) (unifAbsArrity ma1 ma2) (unifAbsDefs md1 md2) -- adding defs

  (ResParam mt1 mv1, ResParam mt2 mv2) ->
    liftM2 ResParam (unifMaybe mt1 mt2) (unifMaybe mv1 mv2)
  (ResValue t1, ResValue t2) 
      | t1==t2    -> return (ResValue t1)
      | otherwise -> fail ""
  (_, ResOverload ms t) | elem m ms ->
    return $ ResOverload ms t
  (ResOper mt1 m1, ResOper mt2 m2) -> 
    liftM2 ResOper (unifMaybeL mt1 mt2) (unifMaybeL m1 m2)

  (CncCat mc1 mf1 mp1, CncCat mc2 mf2 mp2) -> 
    liftM3 CncCat (unifMaybeL mc1 mc2) (unifMaybeL mf1 mf2) (unifMaybeL mp1 mp2)
  (CncFun m mt1 md1, CncFun _ mt2 md2) -> 
    liftM2 (CncFun m) (unifMaybeL mt1 mt2) (unifMaybeL md1 md2) ---- adding defs

  (AnyInd b1 m1, AnyInd b2 m2) -> do
    testErr (b1 == b2) $ "indirection status"
    testErr (m1 == m2) $ "different sources of indirection"
    return i

  _ -> fail "informations"

-- | this is what happens when matching two values in the same module
unifMaybe :: Eq a => Maybe a -> Maybe a -> Err (Maybe a)
unifMaybe Nothing   Nothing   = return Nothing
unifMaybe (Just p1) Nothing   = return (Just p1)
unifMaybe Nothing   (Just p2) = return (Just p2)
unifMaybe (Just p1) (Just p2)
  | p1==p2                    = return (Just p1)
  | otherwise                 = fail ""

-- | this is what happens when matching two values in the same module
unifMaybeL :: Eq a => Maybe (L a) -> Maybe (L a) -> Err (Maybe (L a))
unifMaybeL Nothing          Nothing          = return Nothing
unifMaybeL (Just p1)        Nothing          = return (Just p1)
unifMaybeL Nothing          (Just p2)        = return (Just p2)
unifMaybeL (Just (L l1 p1)) (Just (L l2 p2))
  | p1==p2                                   = return (Just (L l1 p1))
  | otherwise                                = fail ""

unifAbsArrity :: Maybe Int -> Maybe Int -> Err (Maybe Int)
unifAbsArrity Nothing   Nothing   = return Nothing
unifAbsArrity (Just a ) Nothing   = return (Just a )
unifAbsArrity Nothing   (Just a ) = return (Just a )
unifAbsArrity (Just a1) (Just a2)
  | a1==a2                        = return (Just a1)
  | otherwise                     = fail ""

unifAbsDefs :: Maybe [L Equation] -> Maybe [L Equation] -> Err (Maybe [L Equation])
unifAbsDefs Nothing   Nothing   = return Nothing
unifAbsDefs (Just _ ) Nothing   = fail ""
unifAbsDefs Nothing   (Just _ ) = fail ""
unifAbsDefs (Just xs) (Just ys) = return (Just (xs ++ ys))
