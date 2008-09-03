module GF.Compile.Export where

import PGF.CId
import PGF.Data (PGF(..))
import PGF.Raw.Print (printTree)
import PGF.Raw.Convert (fromPGF)
import GF.Compile.GFCCtoHaskell
import GF.Compile.GFCCtoProlog
import GF.Compile.GFCCtoJS
import GF.Infra.Option
import GF.Speech.CFG
import GF.Speech.PGFToCFG
import GF.Speech.SRGS_XML
import GF.Speech.JSGF
import GF.Speech.GSL
import GF.Speech.VoiceXML
import GF.Speech.SLF
import GF.Speech.PrRegExp
import GF.Text.UTF8

import Data.Maybe
import System.FilePath

-- top-level access to code generation

exportPGF :: Options
          -> OutputFormat 
          -> PGF 
          -> [(FilePath,String)] -- ^ List of recommended file names and contents.
exportPGF opts fmt pgf = 
    case fmt of
      FmtPGF          -> multi "pgf" printPGF
      FmtJavaScript   -> multi "js"  pgf2js
      FmtHaskell      -> multi "hs"  (grammar2haskell hsPrefix name)
      FmtHaskell_GADT -> multi "hs"  (grammar2haskellGADT hsPrefix name)
      FmtProlog       -> multi "pl"  grammar2prolog 
      FmtProlog_Abs   -> multi "pl"  grammar2prolog_abs 
      FmtBNF          -> single "bnf"   bnfPrinter
      FmtSRGS_XML     -> single "grxml" (srgsXmlPrinter sisr)
      FmtSRGS_XML_NonRec -> single "grxml" srgsXmlNonRecursivePrinter
      FmtJSGF         -> single "jsgf"  (jsgfPrinter sisr)
      FmtGSL          -> single "gsl"   gslPrinter
      FmtVoiceXML     -> single "vxml"  grammar2vxml
      FmtSLF          -> single "slf"  slfPrinter
      FmtRegExp       -> single "rexp" regexpPrinter
      FmtFA           -> single "dot"  slfGraphvizPrinter
 where
   name = fromMaybe (prCId (absname pgf)) (moduleFlag optName opts)
   sisr = flag optSISR opts
   hsPrefix = flag optHaskellPrefix opts

   multi :: String -> (PGF -> String) -> [(FilePath,String)]
   multi ext pr = [(name <.> ext, pr pgf)]

   single :: String -> (PGF -> CId -> String) -> [(FilePath,String)]
   single ext pr = [(prCId cnc <.> ext, pr pgf cnc) | cnc <- cncnames pgf]

-- | Get the name of the concrete syntax to generate output from.
-- FIXME: there should be an option to change this.
outputConcr :: PGF -> CId
outputConcr pgf = case cncnames pgf of
                    []     -> error "No concrete syntax."
                    cnc:_  -> cnc

printPGF :: PGF -> String
printPGF = encodeUTF8 . printTree . fromPGF
