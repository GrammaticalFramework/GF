----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG.Old
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:56 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Converting GFC grammars to MCFG grammars. (Old variant)
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-- (also, the conversion might fail if the GFC grammar has dependent or higher-order types)
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertGFCtoMCFG.Old (convertGrammar) where

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm
--import PrintGFC
import qualified GF.Grammar.PrGrammar as PG

import Control.Monad (liftM, liftM2, guard)
-- import Maybe (listToMaybe)
import GF.Infra.Ident (Ident(..))
import GF.Canon.AbsGFC
import GF.Canon.GFC
import GF.Canon.Look
import GF.Data.Operations
import qualified GF.Infra.Modules as M
import GF.Canon.CMacros (defLinType)
import GF.Canon.MkGFC (grammar2canon)
import GF.OldParsing.Utilities
import GF.OldParsing.GrammarTypes 
import GF.OldParsing.MCFGrammar (Rule(..), Lin(..))
import GF.Data.SortedList (nubsort, groupPairs)
import Data.Maybe (listToMaybe)
import Data.List (groupBy, transpose)

----------------------------------------------------------------------
-- old style types

data XMCFCat = XMCFCat Cat [(XPath, Term)] deriving (Eq, Ord, Show)
type XMCFLabel = XPath

cnvXMCFCat :: XMCFCat -> MCFCat
cnvXMCFCat (XMCFCat cat constrs) = MCFCat cat [ (cnvXPath path, cnvTerm term) | 
						(path, term) <- constrs ]

cnvXMCFLabel :: XMCFLabel -> MCFLabel
cnvXMCFLabel = cnvXPath

cnvXMCFLin :: Lin XMCFCat XMCFLabel Tokn -> Lin MCFCat MCFLabel Tokn
cnvXMCFLin (Lin lbl lin) = Lin (cnvXMCFLabel lbl) $
			   map (mapSymbol cnvSym id) lin
    where cnvSym (cat, lbl, nr) = (cnvXMCFCat cat, cnvXMCFLabel lbl, nr)

-- Term -> STerm

cnvTerm (R rec) = SRec [ (lbl, cnvTerm term) | Ass lbl term <- rec ]
cnvTerm (T _ tbl) = STbl [ (cnvPattern pat, cnvTerm term) | 
			   Cas pats term <- tbl, pat <- pats ]
cnvTerm (Con con terms) = SCon con $ map cnvTerm terms
cnvTerm term
    | isArgPath term = cnvArgPath term

cnvPattern (PR rec) = SRec [ (lbl, cnvPattern term) | PAss lbl term <- rec ]
cnvPattern (PC con pats) = SCon con $ map cnvPattern pats
cnvPattern (PW) = SWildcard

isArgPath (Arg _) = True
isArgPath (P _ _) = True
isArgPath (S _ _) = True
isArgPath _ = False

cnvArgPath (Arg (A cat nr)) = SArg (fromInteger nr) cat emptyPath
cnvArgPath (term `P` lbl) = cnvArgPath term +. lbl
cnvArgPath (term `S` sel) = cnvArgPath term +! cnvTerm sel

-- old style paths

newtype XPath = XPath [Either Label Term] deriving (Eq, Ord, Show)

cnvXPath :: XPath -> Path
cnvXPath (XPath path) = Path (map (either Left (Right . cnvTerm)) (reverse path))

emptyXPath :: XPath
emptyXPath = XPath []

(++..) :: XPath -> Label -> XPath 
XPath path ++.. lbl = XPath (Left lbl : path)

(++!!) :: XPath -> Term -> XPath 
XPath path ++!! sel = XPath (Right sel : path)

----------------------------------------------------------------------

-- | combining alg. 1 and alg. 2 from Ljunglöf's PhD thesis
convertGrammar :: (CanonGrammar, Ident) -> MCFGrammar
convertGrammar (gram, lng) = trace2 "language" (prt lng) $
			     trace2 "modules" (prtSep " " modnames) $
			     trace2 "#lin-terms" (prt (length cncdefs)) $
			     tracePrt "#mcf-rules total" (prt.length) $
			     concat $
			     tracePrt "#mcf-rules per fun" 
			     (\rs -> concat [" "++show n++"="++show (length r) | 
					     (n, r) <- zip [1..] rs]) $
			     map (convertDef gram lng) cncdefs
    where Gr mods = grammar2canon gram
	  cncdefs = [ def | Mod (MTCnc modname _) _ _ _ defs <- mods, 
		      modname `elem` modnames, 
		      def@(CncDFun _ _ _ _ _) <- defs ]
	  modnames = M.allExtends gram lng


convertDef :: CanonGrammar -> Ident -> Def -> [MCFRule]
convertDef gram lng (CncDFun fun (CIQ _ cat) args term _)
    = [ Rule (cnvXMCFCat newCat) (map cnvXMCFCat newArgs) (map cnvXMCFLin newTerm) fun |
	let ctype     = lookupCType gram lng cat,
	instArgs     <- mapM (enumerateInsts gram lng) args,
	let instTerm  = substitutePaths gram lng instArgs term,
	newCat       <- emcfCat gram lng cat instTerm,
	newArgs      <- mapM (extractArg gram lng instArgs) args,
	let newTerm   = concatMap (extractLin newArgs) $ strPaths gram lng ctype instTerm
      ]


-- gammalt skräp:
-- mergeArgs = zipWith mergeRec
-- mergeRec (R r1) (R r2) = R (r1 ++ r2)

extractArg :: CanonGrammar -> Ident -> [Term] -> ArgVar -> [XMCFCat]
extractArg gram lng args (A cat nr) = emcfCat gram lng cat (args !!! nr)


emcfCat :: CanonGrammar -> Ident -> Ident -> Term -> [XMCFCat]
emcfCat gram lng cat = map (XMCFCat cat) . parPaths gram lng (lookupCType gram lng cat) 


extractLin :: [XMCFCat] -> (XPath, Term) -> [Lin XMCFCat XMCFLabel Tokn]
extractLin args (path, term) = map (Lin path) (convertLin term)
    where convertLin (t1 `C` t2) = liftM2 (++) (convertLin t1) (convertLin t2)
	  convertLin (E) = [[]]
	  convertLin (K tok) = [[Tok tok]]
	  convertLin (FV terms) = concatMap convertLin terms
	  convertLin term = map (return . Cat) $ flattenTerm emptyXPath term
	  flattenTerm path (Arg (A _ nr)) = [(args !!! nr, path, fromInteger nr)]
	  flattenTerm path (term `P` lbl) = flattenTerm (path ++.. lbl) term
	  flattenTerm path (term `S` sel) = flattenTerm (path ++!! sel) term
	  flattenTerm path (FV terms)     = concatMap (flattenTerm path) terms
	  flattenTerm path term = error $ "flattenTerm: \n  " ++ show path ++ "\n  " ++ prt term 


enumerateInsts :: CanonGrammar -> Ident -> ArgVar -> [Term]
enumerateInsts gram lng arg@(A argCat _) = enumerate (Arg arg) (lookupCType gram lng argCat)
    where enumerate path (TStr) = [ path ]
	  enumerate path (Cn con) = okError $ lookupParamValues gram con
	  enumerate path (RecType r) 
	      = map R $ sequence [ map (lbl `Ass`) $ 
				   enumerate (path `P` lbl) ctype |
				   lbl `Lbg` ctype <- r ]
	  enumerate path (Table s t)
	      = map (T s) $ sequence [ map ([term2pattern sel] `Cas`) $ 
				       enumerate (path `S` sel) t |
				       sel <- enumerate (error "enumerate") s ]



termPaths :: CanonGrammar -> Ident -> CType -> Term -> [(XPath, (CType, Term))]
termPaths gr l (TStr) term = [ (emptyXPath, (TStr, term)) ]
termPaths gr l (RecType rtype) (R record) 
    = [ (path ++.. lbl, value) |
	lbl `Ass` term <- record,
	let ctype = okError $ maybeErr "termPaths/record" $ lookupLabelling lbl rtype,
	(path, value) <- termPaths gr l ctype term ]
termPaths gr l (Table _ ctype) (T _ table)
    = [ (path ++!! pattern2term pat, value) |
	pats `Cas` term <- table, pat <- pats,
	(path, value) <- termPaths gr l ctype term ]
termPaths gr l (Table _ ctype) (V ptype table)
    = [ (path ++!! pat, value) |
	(pat, term) <- zip (okError $ allParamValues gr ptype) table,
	(path, value) <- termPaths gr l ctype term ]
termPaths gr l ctype (FV terms)
    = concatMap (termPaths gr l ctype) terms
termPaths gr l (Cn pc) term = [ (emptyXPath, (Cn pc, term)) ]

{- ^^^ variants are pushed inside (not equivalent -- but see record-variants.txt):
{a=a1; b=b1}  | {a=a2; b=b2}   ==>  {a=a1|a2; b=b1|b2}
[p=>p1;q=>q1] | [p=>p2;q=>q2]  ==>  [p=>p1|p2;q=>q1|q2]
-}

parPaths :: CanonGrammar -> Ident -> CType -> Term -> [[(XPath, Term)]]
parPaths gr l ctype term = mapM (uncurry (map . (,))) (groupPairs paths)
    where paths = nubsort [ (path, value) | (path, (Cn _, value)) <- termPaths gr l ctype term ]

strPaths :: CanonGrammar -> Ident -> CType -> Term -> [(XPath, Term)]
strPaths gr l ctype term = [ (path, evalFV values) | (path, values) <- groupPairs paths ]
    where paths = nubsort [ (path, value) | (path, (TStr, value)) <- termPaths gr l ctype term ]


-- Substitute each instantiated parameter path for its instantiation
substitutePaths :: CanonGrammar -> Ident -> [Term] -> Term -> Term
substitutePaths gr l arguments trm  = subst trm
    where subst (con `Con` terms) = con `Con` map subst terms
	  subst (R record)        = R $ map substAss record
	  subst (term `P` lbl)    = subst term `evalP` lbl
	  subst (T ptype table)   = T ptype $ map substCas table
	  subst (V ptype table)   = T ptype [ [term2pattern pat] `Cas` subst term | 
					      (pat, term) <- zip (okError $ allParamValues gr ptype) table ]
	  subst (term `S` select) = subst term `evalS` subst select
	  subst (term `C` term')  = subst term `C` subst term'
	  subst (FV terms)        = evalFV $ map subst terms
	  subst (Arg (A _ arg))   = arguments !!! arg
	  subst term              = term

          substAss (l `Ass` term) = l `Ass` subst term
	  substCas (p `Cas` term) = p `Cas` subst term


evalP (R record) lbl = okError $ maybeErr errStr $ lookupAssign lbl record
    where errStr = "evalP: " ++ prt (R record `P` lbl)
evalP (FV terms) lbl = evalFV [ evalP term lbl | term <- terms ]
evalP term       lbl = term `P` lbl

evalS t@(T _ tbl) sel = maybe (t `S` sel) id $ lookupCase sel tbl
evalS (FV terms)  sel = evalFV [ term `evalS` sel | term <- terms ]
evalS term   (FV sels)= evalFV [ term `evalS` sel | sel <- sels ]
evalS term        sel = term `S` sel

evalFV terms0 = case nubsort (concatMap flattenFV terms0) of
	          [term] -> term
		  terms  -> FV terms
    where flattenFV (FV ts) = ts
	  flattenFV  t      = [t]


----------------------------------------------------------------------
-- utilities 

-- lookup a CType for an Ident
lookupCType :: CanonGrammar -> Ident -> Ident -> CType
lookupCType gr lng c = errVal defLinType $ lookupLincat gr (CIQ lng c)

-- lookup a label in a (record / record ctype / table)
lookupAssign    :: Label -> [Assign]    -> Maybe Term
lookupLabelling :: Label -> [Labelling] -> Maybe CType
lookupCase      :: Term  -> [Case]      -> Maybe Term

lookupAssign    lbl rec  = listToMaybe [ term | lbl' `Ass` term <- rec, lbl == lbl' ] 
lookupLabelling lbl rtyp = listToMaybe [ ctyp | lbl' `Lbg` ctyp <- rtyp, lbl == lbl' ]
lookupCase      sel tbl  = listToMaybe [ term | pats `Cas` term <- tbl, sel `matchesPats` pats ]

matchesPats :: Term -> [Patt] -> Bool
matchesPats term patterns = or [ term == pattern2term pattern | pattern <- patterns ]

-- converting between patterns and terms
pattern2term :: Patt -> Term
term2pattern :: Term -> Patt

pattern2term (con `PC` patterns) = con `Con` map pattern2term patterns
pattern2term (PR record) = R [ lbl `Ass` pattern2term pattern | 
			       lbl `PAss` pattern <- record ]

term2pattern (con `Con` terms) = con `PC` map term2pattern terms
term2pattern (R record) = PR [ lbl `PAss` term2pattern term |
			       lbl `Ass` term <- record ]

-- list lookup for Integers instead of Ints
(!!!) :: [a] -> Integer -> a
xs !!! n = xs !! fromInteger n
