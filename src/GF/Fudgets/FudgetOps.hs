----------------------------------------------------------------------
-- |
-- Module      : FudgetOps
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:14 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- auxiliary Fudgets for GF syntax editor
-----------------------------------------------------------------------------

module FudgetOps where

import Fudgets

-- save and display

showAndSaveF fud = (writeFileF >+< textWindowF) >==< saveF fud

saveF :: F a String -> F (Either String a) (Either (String,String) String)
saveF fud = 
  absF (saveSP "EMPTY") 
    >==< 
  (popupStringInputF "Save" "foo.tmp" "Save to file:" >+< fud)

saveSP :: String -> SP (Either String String) (Either (String,String) String)
saveSP contents = getSP $ \msg -> case msg of
  Left  file   -> putSP (Left (file,contents)) (saveSP contents)
  Right string -> putSP (Right string)         (saveSP string)

textWindowF = writeOutputF

-- | to replace stringInputF by a pop-up slot behind a button
popupStringInputF :: String -> String -> String -> F String String
popupStringInputF label deflt msg =
  mapF snd 
      >==<
  (popupSizeP $ stringPopupF deflt)
      >==<
  mapF (\_ -> (Just msg,Nothing)) 
      >==<
  decentButtonF label
      >==<
  mapF (\_ -> Click)

decentButtonF = spacerF (sizeS (Point 80 20)) . buttonF

popupSizeP = spacerF (sizeS (Point 240 100))

--- the Unicode stuff should be inserted here

writeOutputF = moreF >==< mapF lines

writeInputF = stringInputF


