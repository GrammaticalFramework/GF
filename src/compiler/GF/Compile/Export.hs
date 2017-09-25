module GF.Compile.Export where

import PGF
import GF.Compile.PGFtoHaskell
import GF.Compile.PGFtoJava
import GF.Compile.PGFtoProlog
import GF.Compile.PGFtoJS
import GF.Compile.PGFtoPython
import GF.Infra.Option
--import GF.Speech.CFG
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
import GF.Text.Pretty

-- top-level access to code generation

-- | Export a PGF to the given 'OutputFormat'. For many output formats,
-- additional 'Options' can be used to control the output.
exportPGF :: Options
          -> OutputFormat 
          -> PGF 
          -> [(FilePath,String)] -- ^ List of recommended file names and contents.
exportPGF opts fmt pgf = 
    case fmt of
      FmtPGFPretty    -> multi "txt" (showPGF)
      FmtJavaScript   -> multi "js"  pgf2js
      FmtPython       -> multi "py"  pgf2python
      FmtHaskell      -> multi "hs"  (grammar2haskell opts name)
      FmtJava         -> multi "java" (grammar2java opts name)
      FmtProlog       -> multi "pl"  grammar2prolog
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
   name = fromMaybe (showCId (abstractName pgf)) (flag optName opts)

   multi :: String -> (PGF -> String) -> [(FilePath,String)]
   multi ext pr = [(name <.> ext, pr pgf)]

   single :: String -> (PGF -> CId -> String) -> [(FilePath,String)]
   single ext pr = [(showCId cnc <.> ext, pr pgf cnc) | cnc <- languages pgf]

-- | Get the name of the concrete syntax to generate output from.
-- FIXME: there should be an option to change this.
outputConcr :: PGF -> CId
outputConcr pgf = case languages pgf of
                    []     -> error "No concrete syntax."
                    cnc:_  -> cnc
