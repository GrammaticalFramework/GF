----------------------------------------------------------------------
-- |
-- Module      : ConvertGrammar
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 22:31:46 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- All (?) grammar conversions which are used in GF
-----------------------------------------------------------------------------


module GF.Parsing.ConvertGrammar
    (pInfo, emptyPInfo,
     module GF.Parsing.GrammarTypes
    ) where

import GFC (CanonGrammar)
import GF.Parsing.GrammarTypes
import Ident (Ident(..))
import Option
import Tracing

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

