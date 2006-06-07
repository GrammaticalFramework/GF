---------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/13 12:40:19 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- MCFG parsing, parser information
-----------------------------------------------------------------------------

module GF.Parsing.MCFG.PInfo where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Data.SortedList
import GF.Data.Assoc
import GF.Parsing.MCFG.Range

----------------------------------------------------------------------
-- type declarations

-- | the list of categories = possible starting categories
type MCFParser c n l t = MCFPInfo c n l t 
		       -> [c]
		       -> Input t
		       -> MCFChart c n l

type MCFChart  c n l   = [Abstract (c, RangeRec l) n]

makeFinalEdge :: c -> l -> (Int, Int) -> (c, RangeRec l)
makeFinalEdge cat lbl bnds = (cat, [(lbl, makeRange bnds)])


------------------------------------------------------------
-- parser information

data MCFPInfo c n l t
    = MCFPInfo { grammarTokens :: SList t
	       , nameRules     :: Assoc n (SList (MCFRule c n l t))
	       , topdownRules  :: Assoc c (SList (MCFRule c n l t))
		 -- ^ used in 'GF.Parsing.MCFG.Active' (Earley):
	       , epsilonRules    :: [MCFRule c n l t]
		 -- ^ used in 'GF.Parsing.MCFG.Active' (Kilbury):
	       , leftcornerCats :: Assoc c (SList (MCFRule c n l t))
	       , leftcornerTokens :: Assoc t (SList (MCFRule c n l t))
		 -- ^ used in 'GF.Parsing.MCFG.Active' (Kilbury):
	       , grammarCats   :: SList c
		 -- ^ used when calculating starting categories
	       , rulesByToken  :: Assoc t (SList (MCFRule c n l t, SList t))
	       , rulesWithoutTokens :: SList (MCFRule c n l t)
		 -- ^ used by 'rulesMatchingInput' 
	       , allRules :: MCFGrammar c n l t
		 -- ^ used by any unoptimized algorithm

		 --bottomupRules        :: Assoc (Symbol c t) (SList (CFRule c n t)),
		 --emptyLeftcornerRules :: Assoc c            (SList (CFRule c n t)),
		 --emptyCategories      :: Set c,
	       }


rangeRestrictPInfo :: (Ord c, Ord n, Ord l, Ord t) => 
		      MCFPInfo c n l t -> Input t -> MCFPInfo c n l Range
rangeRestrictPInfo (pinfo{-::MCFPInfo c n l t-}) inp =
    tracePrt "MCFG.PInfo - Restricting the parser information" (prt . grammarTokens)
    MCFPInfo { grammarTokens = nubsort (map edgeRange (inputEdges inp))
	     , nameRules = rrAssoc (nameRules pinfo)
	     , topdownRules = rrAssoc (topdownRules pinfo)
	     , epsilonRules = rrRules (epsilonRules pinfo)
	     , leftcornerCats = rrAssoc (leftcornerCats pinfo)
	     , leftcornerTokens = lctokens
	     , grammarCats = grammarCats pinfo
	     , rulesByToken = emptyAssoc -- error "MCFG.PInfo.rulesByToken - no range restriction"
	     , rulesWithoutTokens = [] -- error "MCFG.PInfo.rulesByToken - no range restriction"
	     , allRules = allrules -- rrRules (allRules pinfo)
	     }

    where lctokens = accumAssoc id 
		     [ (rng, rule) | (tok, rules) <- aAssocs (leftcornerTokens pinfo),
		       inputToken inp ?= tok,
		       rule@(Rule _ (Cnc _ _ (Lin _ (Tok rng:_) : _))) 
		           <- concatMap (rangeRestrictRule inp) rules ]

          allrules = rrRules $ rulesMatchingInput pinfo inp

	  rrAssoc assoc = filterNull $ fmap rrRules assoc
	  filterNull assoc = assocFilter (not . null) assoc
	  rrRules rules = concatMap (rangeRestrictRule inp) rules


buildMCFPInfo :: (Ord c, Ord n, Ord l, Ord t) => MCFGrammar c n l t -> MCFPInfo c n l t
buildMCFPInfo grammar = 
    traceCalcFirst grammar $
    tracePrt "MCFG.PInfo - parser info" (prt) $
    MCFPInfo { grammarTokens = grammartokens
	     , nameRules = namerules
	     , topdownRules = topdownrules
	     , epsilonRules = epsilonrules
	     , leftcornerCats = leftcorncats
	     , leftcornerTokens = leftcorntoks
	     , grammarCats = grammarcats
	     , rulesByToken = rulesbytoken
	     , rulesWithoutTokens = ruleswithouttokens
	     , allRules = allrules
	     }

    where allrules      = concatMap expandVariants grammar
	  grammartokens = union (map fst ruletokens)
	  namerules     = accumAssoc id 
			  [ (name, rule) | rule@(Rule (Abs _ _ name) _) <- allrules ]
	  topdownrules  = accumAssoc id
			  [ (cat, rule) | rule@(Rule (Abs cat _ _) _) <- allrules ]
	  epsilonrules    = [ rule | rule@(Rule _ (Cnc _ _ (Lin _ [] : _))) <- allrules ]
	  leftcorncats  = accumAssoc id 
			  [ (cat, rule) | 
			    rule@(Rule _ (Cnc _ _ (Lin _ (Cat(cat,_,_):_) : _))) <- allrules ]
	  leftcorntoks  = accumAssoc id 
			  [ (tok, rule) | 
			    rule@(Rule _ (Cnc _ _ (Lin _ (Tok tok:_) : _))) <- allrules ]
	  grammarcats   = aElems topdownrules
	  ruletokens    = [ (toksoflins lins, rule) | 
			    rule@(Rule _ (Cnc _ _ lins)) <- allrules ]
	  toksoflins lins = nubsort [ tok | Lin _ syms <- lins, Tok tok <- syms ]
	  rulesbytoken  = accumAssoc id 
			  [ (tok, (rule, toks)) | (tok:toks, rule) <- ruletokens ]
	  ruleswithouttokens = nubsort [ rule | ([], rule) <- ruletokens ]


-- | return only the rules for which all tokens are in the input string
rulesMatchingInput :: Ord t => MCFPInfo c n l t -> Input t -> [MCFRule c n l t]
rulesMatchingInput pinfo inp =
    [ rule | tok <- toks,
      (rule, ruletoks) <- rulesByToken pinfo ? tok,
      ruletoks `subset` toks ]
    ++ rulesWithoutTokens pinfo
    where toks = aElems (inputToken inp)


----------------------------------------------------------------------
-- pretty-printing of statistics

instance (Ord c, Ord n, Ord l, Ord t) => Print (MCFPInfo c n l t) where
    prt pI = "[ tokens=" ++ sl grammarTokens ++
	     "; categories=" ++ sl grammarCats ++ 
	     "; nameRules=" ++ sla nameRules ++ 
	     "; tdRules=" ++ sla topdownRules ++
	     "; epsilonRules=" ++ sl epsilonRules ++ 
	     "; lcCats=" ++ sla leftcornerCats ++
	     "; lcTokens=" ++ sla leftcornerTokens ++
	     "; byToken=" ++ sla rulesByToken ++
	     "; noTokens=" ++ sl rulesWithoutTokens ++
	     "; allRules=" ++ sl allRules ++
	     " ]"

	where sl  f = show $ length $ f pI
	      sla f = let (as, bs) = unzip $ aAssocs $ f pI
		       in show (length as) ++ "/" ++ show (length (concat bs))

