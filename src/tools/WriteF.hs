module Main where
import Fudgets
import System

import Operations

import Greek (mkGreek)
import Arabic (mkArabic)
import Hebrew (mkHebrew)
import Russian (mkRussian)

-- AR 12/4/2000

main = do
  xx <- getArgs
  (case xx of
     "HELP" : _ -> putStrLn usageWriteF
     "FILE" : file : _ -> do
            str <- readFileIf file
            fudlogueWrite (Just str)
     w:_ -> fudlogueWrite (Just (unwords xx)) 
     _   -> fudlogueWrite Nothing)

usageWriteF =
  "Usage: WriteF [-H20Mg -A5M] [FILE <filename> | <inputstring> | HELP]" ++++
  "Without arguments, an interactive display is opened." ++++
  "Prefix your string with / for Greek, - for Arabic, + for Hebrew, _ for Russian."

fudlogueWrite mbstr = 
  fudlogue $
  shellF "Unicode Output" (writeF mbstr >+< quitButtonF)

writeF Nothing = writeOutputF >==< writeInputF
writeF (Just str) = startupF [str] writeOutputF 

displaySizeP = placerF (spacerP (sizeS (Point 440 500)) verticalP)

writeOutputF = 
  displaySizeP (moreF' (setFont myFont))
---  displaySizeP (scrollF (displayF' (setFont myFont)))
---    >=^<
---  vboxD' 0 . map g 
    >==< 
  mapF (map mkUnicode . lines)

writeInputF = stringInputF' (setShowString mkUnicode . setFont myFont)

mkUnicode s = case s of
 '/':cs -> mkGreek cs
 '+':cs -> mkHebrew cs
 '-':cs -> mkArabic cs
 '_':cs -> mkRussian cs
 _      -> s

myFont = "-mutt-clearlyu-medium-r-normal--17-120-100-100-p-101-iso10646-1"
--- myFont = "-arabic-newspaper-medium-r-normal--32-246-100-100-p-137-iso10646-1"
--- myFont = "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso10646-1"
