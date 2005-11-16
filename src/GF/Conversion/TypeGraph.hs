----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/16 10:21:21 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Printing the type hierarchy of an abstract module in GraphViz format
-----------------------------------------------------------------------------


module GF.Conversion.TypeGraph (prtTypeGraph, prtFunctionGraph) where

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Formalism.Utilities
import GF.Conversion.Types

import GF.Data.Operations ((++++), (+++++))
import GF.Infra.Print

----------------------------------------------------------------------
-- | SimpleGFC to TypeGraph
--
-- assumes that the profiles in the Simple GFC names are trivial

prtTypeGraph :: SGrammar -> String
prtTypeGraph rules = "digraph TypeGraph {" ++++ 
                     "concentrate=true;" ++++
                     "node [shape=ellipse];" +++++
                     unlines (map prtTypeGraphRule rules) +++++
                     "}"

prtTypeGraphRule :: SRule -> String
prtTypeGraphRule (Rule abs@(Abs cat cats (Name fun _prof)) _)
    = "// " ++ prt abs ++++
      unlines [ prtSCat c ++ " -> " ++ prtSCat cat ++ ";" | c <- cats ]

prtFunctionGraph :: SGrammar -> String
prtFunctionGraph rules = "digraph FunctionGraph {" ++++ 
                         "node [shape=ellipse];" +++++
                         unlines (map prtFunctionGraphRule rules) +++++
                         "}"

prtFunctionGraphRule :: SRule -> String
prtFunctionGraphRule (Rule abs@(Abs cat cats (Name fun _prof)) _)
    = "// " ++ prt abs ++++
      pfun ++ " [label=\"" ++ prt fun ++ "\", shape=box, style=dashed];" ++++
      pfun ++ " -> " ++ prtSCat cat ++ ";" ++++
      unlines [ prtSCat c ++ " -> " ++ pfun ++ ";" | c <- cats ]
    where pfun = "GF_FUNCTION_" ++ prt fun

prtSCat (Decl var cat args) = prt cat


