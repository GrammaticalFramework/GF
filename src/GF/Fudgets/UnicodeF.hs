----------------------------------------------------------------------
-- |
-- Module      : UnicodeF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:16 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module UnicodeF (fudlogueWriteU) where
import Fudgets

import Operations
import Unicode

-- AR 12/4/2000, 18/9/2001 (added font parameter)

fudlogueWriteU :: String -> (String -> String) -> IO ()
fudlogueWriteU fn trans = 
  fudlogue $
  shellF "GF Unicode Output" (writeF fn trans >+< quitButtonF)

writeF fn trans = writeOutputF fn >==< mapF trans >==< writeInputF fn

displaySizeP = placerF (spacerP (sizeS (Point 440 500)) verticalP)

writeOutputF fn = moreF' (setFont fn) >==< justWriteOutputF

justWriteOutputF = mapF (map (wrapLines 0) . filter (/=[]) . map mkUnicode . lines)

writeInputF fn = stringInputF' (setShowString mkUnicode . setFont fn)

