----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module ArchEdit (
  fudlogueEdit, fudlogueWrite, fudlogueWriteUni
 ) where

import CommandF
import UnicodeF

-- architecture/compiler dependent definitions for unix/ghc, if Fudgets works.
-- If not, use the modules in for-ghci

fudlogueEdit font = fudlogueEditF ----
fudlogueWrite = fudlogueWriteU
fudlogueWriteUni _ _ = do
  putStrLn "sorry no unicode available in ghc"


