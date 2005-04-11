----------------------------------------------------------------------
-- |
-- Module      : ConvertGrammar
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:52 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- All (?) grammar conversions which are used in GF
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertGrammar
    (pInfo, emptyPInfo,
     module GF.OldParsing.GrammarTypes
    ) where

import GFC (CanonGrammar)
import MkGFC (grammar2canon)
import GF.OldParsing.GrammarTypes
import Ident (Ident(..))
import Option
import GF.System.Tracing

-- import qualified GF.OldParsing.FiniteTypes.Calc  as Fin
import qualified GF.OldParsing.ConvertGFCtoMCFG  as G2M
import qualified GF.OldParsing.ConvertMCFGtoCFG  as M2C
import qualified GF.OldParsing.MCFGrammar        as MCFG
import qualified GF.OldParsing.CFGrammar         as CFG

pInfo :: Options -> CanonGrammar -> Ident -> PInfo 
pInfo opts canon lng = PInfo mcfg cfg mcfp cfp
    where mcfg = G2M.convertGrammar cnv (canon, lng)
	  cnv  = maybe "nondet" id $ getOptVal opts gfcConversion 
	  cfg  = M2C.convertGrammar mcfg
	  mcfp = MCFG.pInfo mcfg
	  cfp  = CFG.pInfo cfg

emptyPInfo :: PInfo
emptyPInfo = PInfo [] [] (MCFG.pInfo []) (CFG.pInfo [])

