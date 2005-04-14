----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/14 11:42:05 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Calculating the finiteness of each type in a grammar
-----------------------------------------------------------------------------

module GF.Conversion.SimpleToFinite 
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Conversion.Types

import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.BacktrackM
import GF.Data.Utilities (lookupList)

import Ident (Ident(..))

type CnvMonad a = BacktrackM () a

convertGrammar :: SGrammar -> SGrammar
convertGrammar rules = tracePrt "#finite simpleGFC rules" (prt . length) $
		       solutions cnvMonad ()
    where split = calcSplitable rules
	  cnvMonad = member rules >>= convertRule split

convertRule :: Splitable -> SRule -> CnvMonad SRule
convertRule split (Rule abs cnc) 
    = do newAbs <- convertAbstract split abs
	 return $ Rule newAbs cnc

convertAbstract :: Splitable -> Abstract SDecl Name
		-> CnvMonad (Abstract SDecl Name)
convertAbstract split (Abs decl decls name)
    = case splitableFun split (name2fun name) of
        Just newCat -> return $ Abs (Decl anyVar newCat []) decls name
	Nothing -> expandTyping split name [] decl decls []


expandTyping :: Splitable -> Name -> [(Var, SCat)] -> SDecl -> [SDecl] -> [SDecl] 
	     -> CnvMonad (Abstract SDecl Name)
expandTyping split fun env (Decl x cat args) [] decls 
    = return $ Abs decl (reverse decls) fun
    where decl = substArgs split x env cat args []
expandTyping split fun env typ (Decl x xcat xargs : declsToDo) declsDone
    = do (xcat', env') <- calcNewEnv
         let decl = substArgs split x env xcat' xargs []
	 expandTyping split fun env' typ declsToDo (decl : declsDone)
    where calcNewEnv = case splitableCat split xcat of
		         Just newCats -> do newCat <- member newCats
					    return (newCat, (x,newCat) : env)
			 Nothing -> return (xcat, env)

substArgs :: Splitable -> Var -> [(Var, SCat)] -> SCat -> [TTerm] -> [TTerm] -> SDecl
substArgs split x env cat [] args = Decl x cat (reverse args)
substArgs split x env cat (arg:argsToDo) argsDone
    = case argLookup split env arg of
        Just newCat -> substArgs split x env (mergeArg cat newCat) argsToDo argsDone
	Nothing     -> substArgs split x env cat argsToDo (arg : argsDone)

argLookup split env (TVar x)   = lookup x env 
argLookup split env (con :@ _) = splitableFun split (constr2fun con)
      

----------------------------------------------------------------------
-- splitable categories (finite, no dependencies)
-- they should also be used as some dependency

type Splitable = (Assoc SCat [SCat], Assoc Fun SCat)

splitableCat :: Splitable -> SCat -> Maybe [SCat]
splitableCat = lookupAssoc . fst 

splitableFun :: Splitable -> Fun -> Maybe SCat
splitableFun = lookupAssoc . snd

calcSplitable :: [SRule] -> Splitable
calcSplitable rules = (listAssoc splitableCat2Funs, listAssoc splitableFun2Cat)
    where splitableCat2Funs = groupPairs $ nubsort 
			      [ (cat, mergeFun fun cat) | (cat, fun) <- splitableCatFuns ]

	  splitableFun2Cat = nubsort
			     [ (fun, mergeFun fun cat) | (cat, fun) <- splitableCatFuns ]

          -- cat-fun pairs that are splitable
	  splitableCatFuns = [ (cat, name2fun name) |
			       Rule (Abs (Decl _ cat []) [] name) _ <- rules,
			       splitableCats ?= cat ]

          -- all cats that are splitable
          splitableCats = listSet $
			  tracePrt "finite categories to split" prt $
			  (nondepCats <**> depCats) <\\> resultCats

          -- all result cats for some pure function
	  resultCats = nubsort [ cat | Rule (Abs (Decl _ cat _) decls _) _ <- rules,
				 not (null decls) ]

          -- all cats in constants without dependencies
          nondepCats = nubsort [ cat | Rule (Abs (Decl _ cat []) [] _) _ <- rules ]

          -- all cats occurring as some dependency of another cat
	  depCats = nubsort [ cat | Rule (Abs decl decls _) _ <- rules,
			      cat <- varCats [] (decls ++ [decl]) ]

	  varCats _ [] = []
	  varCats env (Decl x xcat args : decls)
	      = varCats ((x,xcat) : env) decls ++
		[ cat | arg <- args, y <- varsInTTerm arg, cat <- lookupList y env ]


----------------------------------------------------------------------
-- utilities
-- mergeing categories

mergeCats :: String -> String -> String -> SCat -> SCat -> SCat
mergeCats before middle after (IC cat) (IC arg) 
    = IC (before ++ cat ++ middle ++ arg ++ after)

mergeFun, mergeArg :: SCat -> SCat -> SCat
mergeFun = mergeCats "{" ":" "}"
mergeArg = mergeCats "" "" ""


