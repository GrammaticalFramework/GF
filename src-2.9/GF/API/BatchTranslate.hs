----------------------------------------------------------------------
-- |
-- Module      : BatchTranslate
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:05 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- translate OCL, etc, files in batch mode
-----------------------------------------------------------------------------

module GF.API.BatchTranslate (translate) where

import GF.API
import GetMyTree (file2tree)

translate :: FilePath -> FilePath -> IO ()
translate fgr txt = do
  gr <- file2grammar fgr
  s  <- file2tree txt
  putStrLn $ linearize gr s


{- headers for model-specific grammars:

abstract userDefined = oclLibrary ** {

--# -path=.:abstract:prelude:English:ExtraEng
concrete userDefinedEng of userDefined = oclLibraryEng ** open externalOperEng in {

--# -path=.:abstract:prelude:German:ExtraGer
concrete userDefinedGer of userDefined = oclLibraryGer ** open
externalOperGer in {


It seems we should add open 

   ParadigmsX, ResourceExtX, PredicationX

-}
