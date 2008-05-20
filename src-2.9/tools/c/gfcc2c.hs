import GFCC.Abs
import GFCC.ErrM
import GFCC.Lex
import GFCC.Par

import Control.Monad
import Data.Char
import Data.List
import Numeric
import System.Environment
import System.Exit
import System.IO

constrType :: Grammar -> String
constrType g = unlines $ 
    ["typedef enum { "]
 ++ map (\x -> "  " ++ x ++ "," ) ds
 ++ ["} Fun;"]
  where fs = [id2c n | (n,_) <- constructors g ]
        ds = case fs of
                     [] -> []
                     (x:xs) -> (x ++ " = ATOM_FIRST_FUN"):xs

mkFunSigs :: Grammar -> String
mkFunSigs g = unlines [mkFunSig n ats | (n,(ats,_)) <- constructors g]

mkFunSig :: CId -> [CId] -> String
mkFunSig n ats = 
    "extern Tree *mk_" ++ id2c n ++ "(" ++ commaSep adecls ++ ");"
  where 
  adecls = map ("Tree *" ++) args
  args = [ "x" ++ show x | x <- [0..c-1] ]
  c = length ats

mkFuns :: Grammar -> String
mkFuns g = unlines [mkFun n ats | (n,(ats,_)) <- constructors g]

mkFun :: CId -> [CId] -> String
mkFun n ats = unlines $
    ["extern Tree *mk_" ++ id2c n ++ "(" ++ commaSep adecls ++ ") {",
     "  Tree *t = tree_fun(" ++ id2c n ++ "," ++ show c ++ ");"]
 ++ ["  tree_set_child(" ++ commaSep ["t",show i, args!!i] ++ ");" | i <- [0..c-1]]
 ++ ["  return t;",
     "}"]
  where 
  adecls = map ("Tree *" ++) args
  args = [ "x" ++ show x | x <- [0..c-1] ]
  c = length ats

doDie :: String -> [String] -> [String]
doDie s args = ["fprintf(" ++ commaSep ("stderr":show s':args) ++ ");",
                "exit(1);"]
  where s' = "Error: " ++ s ++ "\n"

mkLin :: Grammar -> CId -> String
mkLin g l = unlines $
    ["extern Term *" ++ langLinName_ l ++ "(Tree *t) {",
     "  Term **cs = NULL;",
     "  int n = arity(t);",
     "  if (n > 0) {",
     "    int i;",
     "    cs = (Term**)term_alloc(n * sizeof(Term *));", -- FIXME: handle failure
     "    for (i = 0; i < n; i++) {",
     "      cs[i] = " ++ langLinName_ l ++ "(tree_get_child(t,i));",
     "    }",
     "  }",
     "",
     "  switch (t->type) {",
     "  case ATOM_STRING:  return term_str(t->value.string_value);",
--     "  case ATOM_INTEGER: return NULL;", -- FIXME!
--     "  case ATOM_DOUBLE:  return NULL;", -- FIXME!
     "  case ATOM_META:    return term_meta();"]
 ++ ["  case " ++ id2c n ++ ": return " ++ linFunName n ++ "(cs);"  
           | (n,_) <- constructors g]
 ++ ["  default: "]
 ++ map ("    " ++) (doDie (langLinName_ l ++ " %d") ["t->type"])
 ++ ["    return NULL;",
     "  }",
     "}",
     "",
     "extern Term *" ++ langLinName l ++ "(Tree *t) {",
     "  Term *r;",
     "  term_alloc_pool(1000000);", -- FIXME: size?
     "  r = " ++ langLinName_ l ++ "(t);",
     "  /* term_free_pool(); */", -- FIXME: copy term?
     "  return r;",
     "}"]

langLinName :: CId -> String
langLinName n = id2c n ++ "_lin"

langLinName_ :: CId -> String
langLinName_ n = id2c n ++ "_lin_"

linFunName :: CId -> String
linFunName n = "lin_" ++ id2c n


mkLinFuns :: [CncDef] -> String
mkLinFuns cs = unlines $ map mkLinFunSig cs ++ [""] ++ map mkLinFun cs

mkLinFunSig :: CncDef -> String
mkLinFunSig (Lin n t) =
  "static Term *" ++ linFunName n ++ "(Term **cs);"

mkLinFun :: CncDef -> String
mkLinFun (Lin (CId n) t) | "__" `isPrefixOf` n = ""
mkLinFun (Lin n t) = unlines [
  "static Term *" ++ linFunName n ++ "(Term **cs) {",
  "  return " ++ term2c t ++ ";",
  "}"
                             ]

term2c :: Tree a -> String
term2c t = case t of
  -- terms
  R terms        -> fun "term_array" terms
    -- an optimization of t!n where n is a constant int
  P term0 (C n)  -> "term_sel_int("++ term2c term0 ++ "," ++ show n ++ ")"
  P term0 term1  -> "term_sel(" ++ term2c term0 ++ "," ++ term2c term1 ++ ")"
  S terms        -> fun "term_seq" terms
  K tokn         -> term2c tokn
  V n            -> "cs[" ++ show n ++ "]"
  C n            -> "term_int(" ++ show n ++ ")"
  F cid          -> linFunName cid ++ "(cs)"
  FV terms       -> fun "term_variants" terms
  W str term     -> "term_suffix(" ++ string2c str ++ "," ++ term2c term ++ ")"
  RP term0 term1 -> "term_rp(" ++ term2c term0 ++ "," ++ term2c term1 ++ ")"
  TM             -> "term_meta()"
  -- tokens
  KS s           -> "term_str(" ++ string2c s ++ ")"
  KP strs vars   -> error $ show t -- FIXME: pre token
  _              -> error $ show t 
 where fun f ts = f ++ "(" ++ commaSep (show (length ts):map term2c ts) ++ ")"

commaSep = concat . intersperse ","


id2c :: CId -> String
id2c (CId s) = s -- FIXME: convert ticks

string2c :: String -> String
string2c s = "\"" ++ concatEsc (map esc s) ++ "\""
  where 
    esc c | isAscii c && isPrint c = [c]
    esc '\n' = "\\n"
    esc c = "\\x" ++ map toUpper (showHex (ord c) "")
    concatEsc [] = ""
    concatEsc (x:xs) | length x <= 2 = x ++ concatEsc xs
                     | otherwise = x ++ "\" \"" ++ concatEsc xs

lang2file :: CId -> String -> String
lang2file n ext = id2c n ++ "." ++ ext

constructors :: Grammar -> [(CId, ([CId],CId))]
constructors (Grm _ (Abs ads) _) = [(n,(ats,rt)) | Fun n (Typ ats rt) _ <- ads]

absHFile :: Grammar -> FilePath
absHFile (Grm (Hdr a _) _ _) = lang2file a "h"

cncHFile :: Concrete -> FilePath
cncHFile (Cnc l _) = lang2file l "h"

mkAbsH :: Grammar -> String
mkAbsH g = unlines ["#include \"gfcc-tree.h\"",
                    "#include \"gfcc-term.h\"",
                    constrType g,
                    "",
                    mkFunSigs g]

mkAbsC :: Grammar -> String
mkAbsC g = unlines [include (absHFile g),
                    "",
                    mkFuns g]

mkCncH :: Grammar -> Concrete -> String
mkCncH g (Cnc l _) = unlines
    [include (absHFile g),
     "",
     "extern Term *" ++ langLinName l ++ "(Tree *);"]

mkCncC :: Grammar -> Concrete -> String
mkCncC g c@(Cnc l cds) = unlines $ 
     ["#include <stdio.h>",
      "#include <stdlib.h>",
      include (cncHFile c),
      ""]
  ++ [mkLinFuns cds, mkLin g l]

mkH :: FilePath -> String -> (FilePath, String)
mkH f c = (f, c')
  where c' = unlines ["#ifndef " ++ s, "#define " ++ s, "", c, "#endif"]
        s = [if x=='.' then '_' else toUpper x | x <- f]

include :: FilePath -> String
include f = "#include " ++ show f

-- returns list of file name, file contents
gfcc2c :: Grammar -> [(FilePath, String)]
gfcc2c g@(Grm (Hdr a _) _ cs) = 
  [mkH (absHFile g) (mkAbsH g), (lang2file a "c", mkAbsC g)]
  ++ concat [[mkH (cncHFile cnc) (mkCncH g cnc),(lang2file c "c", mkCncC g cnc)] | cnc@(Cnc c _) <- cs]

parse :: String -> Err Grammar
parse = pGrammar . myLexer

die :: String -> IO ()
die s = do hPutStrLn stderr "Usage: gfcc2c <gfcc file>"
           exitFailure

createFile :: FilePath -> String -> IO ()
createFile f c = do hPutStrLn stderr $ "Writing " ++ f ++ "..."
                    writeFile f c

main :: IO ()
main = do args <- getArgs
          case args of
            [file] -> do c <- readFile file 
                         case parse c of
                           Bad err -> die err
                           Ok g    -> do let fs = gfcc2c g
                                         mapM_ (uncurry createFile) fs
            _      -> die "Usage: gfcc2c <gfcc file>"
