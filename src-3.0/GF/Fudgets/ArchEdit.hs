----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:46:05 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.4 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Fudgets.ArchEdit (
  fudlogueEdit, fudlogueWrite, fudlogueWriteUni
 ) where

import GF.Fudgets.CommandF
import GF.Fudgets.UnicodeF

-- architecture/compiler dependent definitions for unix/ghc, if Fudgets works.
-- If not, use the modules in for-ghci

fudlogueEdit font = fudlogueEditF ----
fudlogueWrite = fudlogueWriteU
fudlogueWriteUni _ _ = do
  putStrLn "sorry no unicode available in ghc"


