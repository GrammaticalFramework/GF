module GF.Compile.Export where

import PGF.CId
import PGF.Data (PGF(..))
import PGF.Raw.Print (printTree)
import PGF.Raw.Convert (fromPGF)
import GF.Compile.GFCCtoHaskell
import GF.Compile.GFCCtoJS
import GF.Infra.Option
import GF.Speech.CFG
import GF.Speech.PGFToCFG
import GF.Speech.SRGS_XML
import GF.Speech.JSGF
import GF.Speech.VoiceXML
import GF.Text.UTF8

-- top-level access to code generation

prPGF :: Options
      -> OutputFormat 
      -> PGF 
      -> String -- ^ Output name, for example used for generated Haskell
                -- module name.
      -> String
prPGF opts fmt gr name = case fmt of
  FmtPGF          -> printPGF gr
  FmtJavaScript   -> pgf2js gr
  FmtHaskell      -> grammar2haskell gr name
  FmtHaskell_GADT -> grammar2haskellGADT gr name
  FmtBNF          -> prCFG $ pgfToCFG gr (outputConcr gr)
  FmtSRGS_XML     -> srgsXmlPrinter (flag optSISR opts) gr (outputConcr gr)
  FmtJSGF         -> jsgfPrinter (flag optSISR opts) gr (outputConcr gr)
  FmtVoiceXML     -> grammar2vxml gr (outputConcr gr)



-- | Get the name of the concrete syntax to generate output from.
-- FIXME: there should be an option to change this.
outputConcr :: PGF -> CId
outputConcr pgf = case cncnames pgf of
                    []     -> error "No concrete syntax."
                    cnc:_  -> cnc

printPGF :: PGF -> String
printPGF = encodeUTF8 . printTree . fromPGF
