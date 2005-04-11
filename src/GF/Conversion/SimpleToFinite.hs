----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:48 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Calculating the finiteness of each type in a grammar
-----------------------------------------------------------------------------

module GF.Conversion.SimpleToFinite 
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC

import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.BacktrackM
import GF.Data.Utilities (lookupList)

import Ident (Ident(..))

type CnvMonad a = BacktrackM () a

convertGrammar :: SimpleGrammar -> SimpleGrammar
convertGrammar rules = tracePrt "#finite simpleGFC rules" (prt . length) $
		       solutions cnvMonad ()
    where split = calcSplitable rules
	  cnvMonad = member rules >>= convertRule split

convertRule :: Splitable -> SimpleRule -> CnvMonad SimpleRule
convertRule split (Rule abs cnc) 
    = do newAbs <- convertAbstract split abs
	 return $ Rule newAbs cnc

convertAbstract :: Splitable -> Abstract Decl Name -> CnvMonad (Abstract Decl Name)
convertAbstract split (Abs (_ ::: typ) decls fun)
    = case splitableFun split fun of
        Just newCat -> return $ Abs (anyVar ::: (newCat :@ [])) decls fun
	Nothing -> expandTyping split fun [] typ decls []


expandTyping :: Splitable -> Name -> [(Var, Cat)] -> Type -> [Decl] -> [Decl] 
	     -> CnvMonad (Abstract Decl Name)
expandTyping split fun env (cat :@ atoms) [] decls 
    = return $ Abs decl (reverse decls) fun
    where decl = anyVar ::: substAtoms split env cat atoms []
expandTyping split fun env typ ((x ::: (xcat :@ xatoms)) : declsToDo) declsDone
    = do (xcat', env') <- calcNewEnv
         let decl = x ::: substAtoms split env xcat' xatoms []
	 expandTyping split fun env' typ declsToDo (decl : declsDone)
    where calcNewEnv = case splitableCat split xcat of
		         Just newCats -> do newCat <- member newCats
					    return (newCat, (x,newCat) : env)
			 Nothing -> return (xcat, env)

substAtoms :: Splitable -> [(Var, Cat)] -> Cat -> [Atom] -> [Atom] -> Type
substAtoms split env cat [] atoms = cat :@ reverse atoms
substAtoms split env cat (atom:atomsToDo) atomsDone
    = case atomLookup split env atom of
        Just newCat -> substAtoms split env (mergeArg cat newCat) atomsToDo atomsDone
	Nothing -> substAtoms split env cat atomsToDo (atom : atomsDone)

atomLookup split env (AVar x) = lookup x env 
atomLookup split env (ACon con) = splitableFun split (constr2name con)
      

----------------------------------------------------------------------
-- splitable categories (finite, no dependencies)
-- they should also be used as some dependency

type Splitable = (Assoc Cat [Cat], Assoc Name Cat)

splitableCat :: Splitable -> Cat -> Maybe [Cat]
splitableCat = lookupAssoc . fst 

splitableFun :: Splitable -> Name -> Maybe Cat
splitableFun = lookupAssoc . snd

calcSplitable :: [SimpleRule] -> Splitable
calcSplitable rules = (listAssoc splitableCat2Funs, listAssoc splitableFun2Cat)
    where splitableCat2Funs = groupPairs $ nubsort 
			      [ (cat, mergeFun fun cat) | (cat, fun) <- splitableCatFuns ]

	  splitableFun2Cat = nubsort
			     [ (fun, mergeFun fun cat) | (cat, fun) <- splitableCatFuns ]

          -- cat-fun pairs that are splitable
	  splitableCatFuns = [ (cat, fun) |
			       Rule (Abs (_ ::: (cat :@ [])) [] fun) _ <- rules,
			       splitableCats ?= cat ]

          -- all cats that are splitable
          splitableCats = listSet $
			  tracePrt "finite categories to split" prt $
			  (nondepCats <**> depCats) <\\> resultCats

          -- all result cats for some pure function
	  resultCats = nubsort [ cat | Rule (Abs (_ ::: (cat :@ _)) decls _) _ <- rules,
				 not (null decls) ]

          -- all cats in constants without dependencies
          nondepCats = nubsort [ cat | Rule (Abs (_ ::: (cat :@ [])) [] _) _ <- rules ]

          -- all cats occurring as some dependency of another cat
	  depCats = nubsort [ cat | Rule (Abs decl decls _) _ <- rules,
			      cat <- varCats [] (decls ++ [decl]) ]

	  varCats _ [] = []
	  varCats env ((x ::: (xcat :@ atoms)) : decls)
	      = varCats ((x,xcat) : env) decls ++
		[ cat | AVar y <- atoms, cat <- lookupList y env ]


----------------------------------------------------------------------
-- utilities
-- mergeing categories

mergeCats :: String -> String -> String -> Cat -> Cat -> Cat
mergeCats before middle after (IC cat) (IC arg) 
    = IC (before ++ cat ++ middle ++ arg ++ after)

mergeFun, mergeArg :: Cat -> Cat -> Cat
mergeFun = mergeCats "{" ":" "}"
mergeArg = mergeCats "" "" ""


