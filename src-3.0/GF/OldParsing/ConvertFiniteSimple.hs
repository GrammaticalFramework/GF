----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:43 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Calculating the finiteness of each type in a grammar
-----------------------------------------------------------------------------

module GF.OldParsing.ConvertFiniteSimple
    (convertGrammar) where

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm

import GF.Data.Operations
import GF.Infra.Ident (Ident(..))
import GF.OldParsing.SimpleGFC
import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.BacktrackM

type CnvMonad a = BacktrackM () a

convertGrammar :: Grammar -> Grammar
convertGrammar rules = solutions cnvMonad () 
    where split = calcSplitable rules
	  cnvMonad = member rules >>= convertRule split

convertRule :: Splitable -> Rule -> CnvMonad Rule
convertRule split (Rule name typing term) 
    = do newTyping <- convertTyping split name typing
	 return $ Rule name newTyping term

convertTyping :: Splitable -> Name -> Typing -> CnvMonad Typing
convertTyping split name (typ, decls)
    = case splitableFun split name of
        Just newCat -> return (newCat :@ [], decls)
	Nothing -> expandTyping split [] typ decls []


expandTyping :: Splitable -> [(Var, Cat)] -> Type -> [Decl] -> [Decl] -> CnvMonad Typing
expandTyping split env (cat :@ atoms) [] decls 
    = return (substAtoms split env cat atoms [], reverse decls)
expandTyping split env typ ((x ::: (xcat :@ xatoms)) : declsToDo) declsDone
    = do env' <- calcNewEnv
         expandTyping split env' typ declsToDo (decl : declsDone)
    where decl = x ::: substAtoms split env xcat xatoms []
	  calcNewEnv = case splitableCat split xcat of
		         Just newCats -> do newCat <- member newCats
					    return ((x,newCat) : env)
			 Nothing -> return env

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

calcSplitable :: [Rule] -> Splitable
calcSplitable rules = (listAssoc splitableCats, listAssoc splitableFuns)
    where splitableCats = tracePrt "splitableCats" (prtSep " ") $
			  groupPairs $ nubsort 
			  [ (cat, mergeFun fun cat) | (cat, fun) <- constantCats ]

	  splitableFuns = tracePrt "splitableFuns" (prtSep " ") $
			  nubsort
			  [ (fun, mergeFun fun cat) | (cat, fun) <- constantCats ]

	  constantCats = tracePrt "constantCats" (prtSep " ") $
			 [ (cat, fun) |
			   Rule fun (cat :@ [], []) _ <- rules,
			   dependentConstants ?= cat ]

          dependentConstants = listSet $
			       tracePrt "dep consts" prt $
			       dependentCats <\\> funCats

	  funCats = tracePrt "fun cats" prt $
		    nubsort [ cat | Rule _ (cat :@ _, decls) _ <- rules,
			      not (null decls) ]

          dependentCats = tracePrt "dep cats" prt $
			  nubsort [ cat | Rule _ (cat :@ [], []) _ <- rules ]


----------------------------------------------------------------------
-- utilities

-- mergeing categories
mergeCats :: String -> String -> String -> Cat -> Cat -> Cat
mergeCats before middle after (IC cat) (IC arg) 
    = IC (before ++ cat ++ middle ++ arg ++ after)

mergeFun, mergeArg :: Cat -> Cat -> Cat
mergeFun = mergeCats "{" ":" "}"
mergeArg = mergeCats "" "" ""


