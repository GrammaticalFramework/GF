----------------------------------------------------------------------
-- |
-- Module      : ConvertGrammar
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:17:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- All (?) grammar conversions which are used in GF
-----------------------------------------------------------------------------


module GF.Parsing.ConvertGrammar
    (pInfo, emptyPInfo,
     module GF.Parsing.GrammarTypes
    ) where

import GFC (CanonGrammar)
import MkGFC (grammar2canon)
import GF.Parsing.GrammarTypes
import Ident (Ident(..))
import Option
import GF.System.Tracing

-- import qualified GF.Parsing.FiniteTypes.Calc  as Fin
import qualified GF.Parsing.ConvertGFCtoMCFG  as G2M
import qualified GF.Parsing.ConvertMCFGtoCFG  as M2C
import qualified GF.Parsing.MCFGrammar        as MCFG
import qualified GF.Parsing.CFGrammar         as CFG

pInfo :: Options -> CanonGrammar -> Ident -> PInfo 
pInfo opts canon lng = PInfo mcfg cfg mcfp cfp
    where mcfg = G2M.convertGrammar cnv (canon, lng)
	  cnv  = maybe "nondet" id $ getOptVal opts gfcConversion 
	  cfg  = M2C.convertGrammar mcfg
	  mcfp = MCFG.pInfo mcfg
	  cfp  = CFG.pInfo cfg

emptyPInfo :: PInfo
emptyPInfo = PInfo [] [] (MCFG.pInfo []) (CFG.pInfo [])

