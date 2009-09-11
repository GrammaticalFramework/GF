module GF.Compile.Export where

import PGF.CId
import PGF.Data (PGF(..))
import GF.Compile.GFCCtoHaskell
import GF.Compile.GFCCtoProlog
import GF.Compile.GFCCtoJS
import GF.Compile.PGFPretty
import GF.Infra.Option
import GF.Speech.CFG
import GF.Speech.PGFToCFG
import GF.Speech.SRGS_ABNF
import GF.Speech.SRGS_XML
import GF.Speech.JSGF
import GF.Speech.GSL
import GF.Speech.SRG
import GF.Speech.VoiceXML
import GF.Speech.SLF
import GF.Speech.PrRegExp

import Data.Maybe
import System.FilePath

-- top-level access to code generation

exportPGF :: Options
          -> OutputFormat 
          -> PGF 
          -> [(FilePath,String)] -- ^ List of recommended file names and contents.
exportPGF opts fmt pgf = 
    case fmt of
      FmtPGFPretty    -> multi "txt" prPGFPretty
      FmtPMCFGPretty  -> single "pmcfg" prPMCFGPretty
      FmtJavaScript   -> multi "js"  pgf2js
      FmtHaskell      -> multi "hs"  (grammar2haskell opts name)
      FmtProlog       -> multi "pl"  grammar2prolog 
      FmtProlog_Abs   -> multi "pl"  grammar2prolog_abs 
      FmtBNF          -> single "bnf"   bnfPrinter
      FmtEBNF         -> single "ebnf"  (ebnfPrinter opts)
      FmtSRGS_XML     -> single "grxml" (srgsXmlPrinter opts)
      FmtSRGS_XML_NonRec -> single "grxml" (srgsXmlNonRecursivePrinter opts)
      FmtSRGS_ABNF    -> single "gram" (srgsAbnfPrinter opts)
      FmtSRGS_ABNF_NonRec -> single "gram" (srgsAbnfNonRecursivePrinter opts)
      FmtJSGF         -> single "jsgf"  (jsgfPrinter opts)
      FmtGSL          -> single "gsl"   (gslPrinter opts)
      FmtVoiceXML     -> single "vxml"  grammar2vxml
      FmtSLF          -> single "slf"  slfPrinter
      FmtRegExp       -> single "rexp" regexpPrinter
      FmtFA           -> single "dot"  slfGraphvizPrinter
 where
   name = fromMaybe (showCId (absname pgf)) (flag optName opts)

   multi :: String -> (PGF -> String) -> [(FilePath,String)]
   multi ext pr = [(name <.> ext, pr pgf)]

   single :: String -> (PGF -> CId -> String) -> [(FilePath,String)]
   single ext pr = [(showCId cnc <.> ext, pr pgf cnc) | cnc <- cncnames pgf]

-- | Get the name of the concrete syntax to generate output from.
-- FIXME: there should be an option to change this.
outputConcr :: PGF -> CId
outputConcr pgf = case cncnames pgf of
                    []     -> error "No concrete syntax."
                    cnc:_  -> cnc
