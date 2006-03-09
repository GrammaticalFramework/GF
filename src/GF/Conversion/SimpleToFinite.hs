----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/01 09:53:19 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.7 $
--
-- Calculating the finiteness of each type in a grammar
-----------------------------------------------------------------------------

module GF.Conversion.SimpleToFinite
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Formalism.Utilities 
import GF.Conversion.Types

import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.BacktrackM
import GF.Data.Utilities (lookupList)

import GF.Infra.Ident (Ident(..))

type CnvMonad a = BacktrackM () a

convertGrammar :: SGrammar -> SGrammar
convertGrammar rules = tracePrt "SimpleToFinie - nr. 'finite' rules" (prt . length) $
		       solutions cnvMonad ()
    where split = calcSplitable rules
	  cnvMonad = member rules >>= convertRule split

convertRule :: Splitable -> SRule -> CnvMonad SRule
convertRule split (Rule abs cnc) 
    = do newAbs <- convertAbstract split abs
	 return $ Rule newAbs cnc

{-
-- old code
convertAbstract :: Splitable -> Abstract SDecl Name
		-> CnvMonad (Abstract SDecl Name)
convertAbstract split (Abs decl decls name)
    = case splitableFun split (name2fun name) of
        Just cat' -> return $ Abs (Decl anyVar (mergeFun (name2fun name) cat') []) decls name
	Nothing -> expandTyping split name [] decl decls []


expandTyping :: Splitable -> Name -> [(Var, SCat)] -> SDecl -> [SDecl] -> [SDecl] 
	     -> CnvMonad (Abstract SDecl Name)
expandTyping split name env (Decl x cat args) [] decls 
    = return $ Abs decl (reverse decls) name
    where decl = substArgs split x env cat args []
expandTyping split name env typ (Decl x xcat xargs : declsToDo) declsDone
    = do (x', xcat', env') <- calcNewEnv
         let decl = substArgs split x' env xcat' xargs []
	 expandTyping split name env' typ declsToDo (decl : declsDone)
    where calcNewEnv = case splitableCat split xcat of
		         Just newFuns -> do newFun <- member newFuns
                                            let newCat  = mergeFun newFun xcat
		         -- Just newCats -> do newCat <- member newCats
					    return (anyVar, newCat, (x,newCat) : env)
			 Nothing -> return (x, xcat, env)
-}

-- new code
convertAbstract :: Splitable -> Abstract SDecl Name
		-> CnvMonad (Abstract SDecl Name)
convertAbstract split (Abs decl decls name)
    = case splitableFun split fun of
        Just cat' -> return $ Abs (Decl anyVar (mergeFun fun cat') []) decls name
	Nothing -> expandTyping split [] fun profiles [] decl decls []
    where Name fun profiles = name

expandTyping :: Splitable -> [(Var, SCat)]
             -> Fun -> [Profile (SyntaxForest Fun)] -> [Profile (SyntaxForest Fun)] 
             -> SDecl -> [SDecl] -> [SDecl] 
	     -> CnvMonad (Abstract SDecl Name)
expandTyping split env fun [] profiles (Decl x cat args) [] decls 
    = return $ Abs decl (reverse decls) (Name fun (reverse profiles))
    where decl = substArgs split x env cat args []
expandTyping split env fun (prof:profiles) profsDone typ (Decl x xcat xargs : declsToDo) declsDone
    = do (x', xcat', env', prof') <- calcNewEnv
         let decl = substArgs split x' env xcat' xargs []
	 expandTyping split env' fun profiles (prof':profsDone) typ declsToDo (decl : declsDone)
    where calcNewEnv = case splitableCat split xcat of
		         Just newFuns -> do newFun <- member newFuns
                                            let newCat  = mergeFun newFun xcat
                                                newProf = Constant (FNode newFun [[]])
                                            -- should really be using some kind of
                                            -- "profile unification"
					    return (anyVar, newCat, (x,newCat) : env, newProf)
			 Nothing -> return (x, xcat, env, prof)


substArgs :: Splitable -> Var -> [(Var, SCat)] -> SCat -> [TTerm] -> [TTerm] -> SDecl
substArgs split x env cat [] args = Decl x cat (reverse args)
substArgs split x env cat (arg:argsToDo) argsDone
    = case argLookup split env arg of
        Just newCat -> substArgs split x env (mergeArg cat newCat) argsToDo argsDone
	Nothing     -> substArgs split x env cat argsToDo (arg : argsDone)

argLookup split env (TVar x)   = lookup x env 
argLookup split env (con :@ _) = fmap (mergeFun fun) (splitableFun split fun)
    where fun = constr2fun con
      

----------------------------------------------------------------------
-- splitable categories (finite, no dependencies)
-- they should also be used as some dependency

type Splitable = (Assoc SCat [Fun], Assoc Fun SCat)

splitableCat :: Splitable -> SCat -> Maybe [Fun]
splitableCat = lookupAssoc . fst 

splitableFun :: Splitable -> Fun -> Maybe SCat
splitableFun = lookupAssoc . snd

calcSplitable :: [SRule] -> Splitable
calcSplitable rules = (listAssoc splitableCat2Funs, listAssoc splitableFun2Cat)
    where splitableCat2Funs = groupPairs $ nubsort splitableCatFuns

	  splitableFun2Cat = nubsort
			     [ (fun, cat) | (cat, fun) <- splitableCatFuns ]

          -- cat-fun pairs that are splitable
	  splitableCatFuns = tracePrt "SimpleToFinite - splitable functions" prt $
                             [ (cat, name2fun name) |
			       Rule (Abs (Decl _ cat []) [] name) _ <- rules,
			       splitableCats ?= cat ]

          -- all cats that are splitable
          splitableCats = listSet $
			  tracePrt "SimpleToFinite - finite categories to split" prt $
			  (nondepCats <**> depCats) <\\> resultCats

          -- all result cats for some pure function
	  resultCats = tracePrt "SimpleToFinite - result cats" prt $
                       nubsort [ cat | Rule (Abs (Decl _ cat _) decls _) _ <- rules,
				 not (null decls) ]

          -- all cats in constants without dependencies
          nondepCats = tracePrt "SimpleToFinite - nondep cats" prt $
                       nubsort [ cat | Rule (Abs (Decl _ cat []) [] _) _ <- rules ]

          -- all cats occurring as some dependency of another cat
	  depCats = tracePrt "SimpleToFinite - dep cats" prt $
                    nubsort [ cat | Rule (Abs decl decls _) _ <- rules,
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


