module BatchTranslate where

import API
import GetMyTree (file2tree)

-- translate OCL, etc, files in batch mode

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