----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:18:39 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Calculating the finiteness of each type in a grammar
-----------------------------------------------------------------------------

module GF.Parsing.ConvertFiniteGFC where

import Operations
import GFC
import MkGFC
import AbsGFC
import Ident (Ident(..))
import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm
import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.BacktrackM

type Cat = Ident
type Name = Ident

type CnvMonad a = BacktrackM () () a

convertGrammar :: CanonGrammar -> CanonGrammar
convertGrammar = canon2grammar . convertCanon . grammar2canon

convertCanon :: Canon -> Canon
convertCanon (Gr modules) = Gr (map (convertModule split) modules)
    where split = calcSplitable modules

convertModule :: Splitable -> Module -> Module
convertModule split (Mod mtyp ext op fl defs) 
    = Mod mtyp ext op fl newDefs
    where newDefs  = solutions defMonad () () 
	  defMonad = member defs >>= convertDef split

-- the main conversion function
convertDef :: Splitable -> Def -> CnvMonad Def

convertDef split (AbsDCat cat decls cidents)
    = case splitableCat split cat of
        Just newCats -> do newCat <- member newCats
			   return $ AbsDCat newCat decls cidents
	Nothing -> do (newCat, newDecls) <- expandDecls cat decls
		      return $ AbsDCat newCat newDecls cidents
    where expandDecls cat [] = return (cat, [])
	  expandDecls cat (decl@(Decl var typ) : decls)
	      = do (newCat, newDecls) <- expandDecls cat decls
		   let argCat = resultCat typ
		   case splitableCat split argCat of
		     Nothing -> return (newCat, decl : newDecls) 
		     Just newArgs -> do newArg <- member newArgs
					return (mergeCats "/" newCat newArg, newDecls)

convertDef split (AbsDFun fun typ@(EAtom (AC (CIQ mod cat))) def)
    = case splitableFun split fun of
        Just newCat -> return (AbsDFun fun (EAtom (AC (CIQ mod newCat))) def)
	Nothing -> do newTyp <- expandType split [] typ
		      return (AbsDFun fun newTyp def)
convertDef split (AbsDFun fun typ def)
    = do newTyp <- expandType split [] typ
	 return (AbsDFun fun newTyp def)

convertDef _ def = return def

-- expanding Exp's
expandType :: Splitable -> [(Ident, Cat)] -> Exp -> CnvMonad Exp
expandType split env (EProd x a@(EAtom (AC (CIQ mod cat))) b)
    = case splitableCat split cat of
        Nothing -> do b' <- expandType split env b
		      return (EProd x a b')
	Just newCats -> do newCat <- member newCats
			   b' <- expandType split ((x,newCat):env) b
			   return (EProd x (EAtom (AC (CIQ mod newCat))) b')
expandType split env (EProd x a b)
    = do a' <- expandType split env a
	 b' <- expandType split env b
	 return (EProd x a' b')
expandType split env app
    = expandApp split env [] app

expandApp :: Splitable -> [(Ident, Cat)] -> [Cat] -> Exp -> CnvMonad Exp
expandApp split env addons (EAtom (AC (CIQ mod cat)))
    = return (EAtom (AC (CIQ mod (foldl (mergeCats "/") cat addons))))
expandApp split env addons (EApp exp arg@(EAtom (AC (CIQ mod fun))))
    = case splitableFun split fun of
        Just newCat -> expandApp split env (newCat:addons) exp
	Nothing -> do exp' <- expandApp split env addons exp
		      return (EApp exp' arg)
expandApp split env addons (EApp exp arg@(EAtom (AV x)))
    = case lookup x env of
        Just newCat -> expandApp split env (newCat:addons) exp
	Nothing -> do exp' <- expandApp split env addons exp
		      return (EApp exp' arg)

----------------------------------------------------------------------
-- splitable categories (finite, no dependencies)
-- they should also be used as some dependency

type Splitable = (Assoc Cat [Cat], Assoc Name Cat)

splitableCat :: Splitable -> Cat -> Maybe [Cat]
splitableCat = lookupAssoc . fst 

splitableFun :: Splitable -> Name -> Maybe  Cat
splitableFun = lookupAssoc . snd

calcSplitable :: [Module] -> Splitable
calcSplitable modules = (listAssoc splitableCats, listAssoc splitableFuns)
    where splitableCats = tracePrt "splitableCats" (prtSep " ") $
			  groupPairs $ nubsort 
			  [ (cat, mergeCats ":" fun cat) | (cat, fun) <- constantCats ]

	  splitableFuns = tracePrt "splitableFuns" (prtSep " ") $
			  nubsort
			  [ (fun, mergeCats ":" fun cat) | (cat, fun) <- constantCats ]

	  constantCats = tracePrt "constantCats" (prtSep " ") $
			 [ (cat, fun) |
			   AbsDFun fun (EAtom (AC (CIQ _ cat))) _ <- absDefs,
			   dependentConstants ?= cat ]

          dependentConstants = listSet $
			       tracePrt "dep consts" prt $
			       dependentCats <\\> funCats

	  funCats = tracePrt "fun cats" prt $
		    nubsort [ resultCat typ |
			      AbsDFun _ typ@(EProd _ _ _) _ <- absDefs ]

          dependentCats = tracePrt "dep cats" prt $
			  nubsort [ cat | AbsDCat _ decls _ <- absDefs,
				    Decl _ (EAtom (AC (CIQ _ cat))) <- decls ]
			    
          absDefs = concat [ defs | Mod (MTAbs _) _ _ _ defs <- modules ]


----------------------------------------------------------------------

resultCat :: Exp -> Cat
resultCat (EProd _ _ b) = resultCat b
resultCat (EApp a _) = resultCat a
resultCat (EAtom (AC (CIQ _ cat))) = cat

mergeCats :: String -> Cat -> Cat -> Cat
mergeCats str (IC cat) (IC arg) = IC (cat ++ str ++ arg)

----------------------------------------------------------------------
-- obsolete?

{-
type FiniteCats = Assoc Cat Integer

calculateFiniteness :: Canon -> FiniteCats
calculateFiniteness canon@(Gr modules) 
    = trace2 "#typeInfo" (prt tInfo) $
      finiteCats

    where finiteCats = listAssoc [ (cat, fin) | (cat, Just fin) <- finiteInfo ]
          finiteInfo = map finInfo groups 

	  finInfo :: (Cat, [[Cat]]) -> (Cat, Maybe Integer)
	  finInfo (cat, ctxts)
	      | cyclicCats ?= cat = (cat, Nothing)
	      | otherwise = (cat, fmap (sum . map product) $
			     sequence (map (sequence . map lookFinCat) ctxts))

	  lookFinCat :: Cat -> Maybe Integer
	  lookFinCat cat = maybe (error "lookFinCat: Nothing") id $
			   lookup cat finiteInfo

	  cyclicCats :: Set Cat
	  cyclicCats = listSet $
		       tracePrt "cyclic cats" prt $
		       union $ map nubsort $ cyclesIn dependencies

	  dependencies :: [(Cat, [Cat])]
	  dependencies = tracePrt "dependencies" (prtAfter "\n") $
			 mapSnd (union . nubsort) groups

	  groups :: [(Cat, [[Cat]])]
	  groups  = tracePrt "groups" (prtAfter "\n") $
		    mapSnd (map snd) $ groupPairs (nubsort allFuns)

	  allFuns = tracePrt "all funs" (prtAfter "\n") $
		    [ (cat, (fun, ctxt)) |
		      Mod (MTAbs _) _ _ _ defs <- modules,
		      AbsDFun fun typ _ <- defs,
		      let (cat, ctxt) = err error id $ typeForm typ ]

          tInfo = calculateTypeInfo 30 finiteCats (splitDefs canon)

-- | stolen from 'Macros.qTypeForm', converted to GFC, and severely simplified
typeForm :: Monad m => Exp -> m (Cat, [Cat])
typeForm t = case t of
  EProd x a b  -> do
    (cat, ctxt) <- typeForm b 
    a' <- stripType a
    return (cat, a':ctxt)
  EApp c a -> do
    (cat, _) <- typeForm c
    return (cat, [])
  EAtom (AC (CIQ _ con)) ->
    return (con, []) 
  _       -> 
    fail $ "no normal form of type: " ++ prt t

stripType :: Monad m => Exp -> m Cat
stripType (EApp c a) = stripType c
stripType (EAtom (AC (CIQ _ con))) = return con
stripType t = fail $ "can't strip type: " ++ prt t

mapSnd f xs = [ (a, f b) | (a, b) <- xs ]
-}

----------------------------------------------------------------------
-- obsolete?

{-
type SplitDefs = ([Def],  [Def],  [Def],  [Def])
-----            AbsDCat AbsDFun CncDCat CncDFun

splitDefs :: Canon -> SplitDefs
splitDefs (Gr modules) = foldr splitDef ([], [], [], []) $ 
			 concat [ defs | Mod _ _ _ _ defs <- modules ]

splitDef :: Def -> SplitDefs -> SplitDefs
splitDef ac@(AbsDCat _ _ _) (acs, afs, ccs, cfs) = (ac:acs, afs, ccs, cfs)
splitDef af@(AbsDFun _ _ _) (acs, afs, ccs, cfs) = (acs, af:afs, ccs, cfs)
splitDef cc@(CncDCat _ _ _ _) (acs, afs, ccs, cfs) = (acs, afs, cc:ccs, cfs)
splitDef cf@(CncDFun _ _ _ _ _) (acs, afs, ccs, cfs) = (acs, afs, ccs, cf:cfs)
splitDef _ sd = sd

--calculateTypeInfo :: Integer -> FiniteCats -> SplitDefs -> ?
calculateTypeInfo maxFin allFinCats (acs, afs, ccs, cfs)
    = (depCatsToExpand, catsToSplit)
    where absDefsToExpand = tracePrt "absDefsToExpand" prt $
			    [ ((cat, fin), cats) | 
			      AbsDCat cat args _ <- acs, 
			      not (null args),
			      cats <- mapM catOfDecl args,
			      fin <- lookupAssoc allFinCats cat,
			      fin <= maxFin
			    ]
	  (depCatsToExpand, argsCats') = unzip absDefsToExpand
	  catsToSplit = union (map nubsort argsCats')
	  catOfDecl (Decl _ exp) = err fail return $ stripType exp
-}
