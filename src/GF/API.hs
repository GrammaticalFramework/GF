----------------------------------------------------------------------
-- |
-- Module      : API
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/14 16:03:40 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.39 $
--
-- Application Programmer's Interface to GF; also used by Shell. AR 10/11/2001
-----------------------------------------------------------------------------

module GF.API where

import qualified GF.Source.AbsGF as GF
import qualified GF.Canon.AbsGFC as A
import qualified GF.Compile.Rename as R
import GF.UseGrammar.GetTree
import GF.Canon.GFC
--- import qualified Values as V
import GF.Grammar.Values

-----import GetGrammar
import GF.Compile.Compile
import GF.API.IOGrammar
import GF.UseGrammar.Linear
import GF.UseGrammar.Parsing
import GF.UseGrammar.Morphology
import GF.CF.PPrCF
import GF.CF.CFIdent
import GF.Compile.PGrammar
import GF.UseGrammar.Randomized (mkRandomTree)

import GF.Grammar.MMacros
import qualified GF.Grammar.Macros as M
import GF.Grammar.TypeCheck
import GF.Canon.CMacros
import GF.UseGrammar.Transfer
import qualified GF.UseGrammar.Generate as Gen

import GF.Text.Text (untokWithXML)
import GF.Infra.Option
import GF.UseGrammar.Custom
import GF.Compile.ShellState
import GF.UseGrammar.Linear
import GF.Canon.GFC
import qualified GF.Grammar.Grammar as G
import GF.Infra.Modules
import GF.Grammar.PrGrammar
import qualified GF.Grammar.Compute as Co
import qualified GF.Grammar.AbsCompute as AC
import qualified GF.Infra.Ident as I
import qualified GF.Compile.GrammarToCanon as GC
import qualified GF.Canon.CanonToGrammar as CG
import qualified GF.Canon.MkGFC as MC
import qualified GF.Embed.EmbedAPI as EA

import GF.UseGrammar.Editing

----import GrammarToXML 

----import GrammarToMGrammar as M

import qualified Transfer.InterpreterAPI as T

import GF.System.Arch (myStdGen)

import GF.Text.UTF8
import GF.Data.Operations
import GF.Infra.UseIO
import GF.Data.Zipper

import Data.List (nub)
import Control.Monad (liftM)
import System (system)

type GFGrammar = StateGrammar
type GFCat     = CFCat
type Ident     = I.Ident
--- type Tree      = V.Tree

-- these are enough for many simple applications

file2grammar :: FilePath -> IO GFGrammar
file2grammar file = do
  egr <- appIOE $ optFile2grammar (iOpts [beSilent]) file
  err (\s -> putStrLn s >> return emptyStateGrammar) return egr

linearize :: GFGrammar -> Tree -> String
linearize sgr = err id id . optLinearizeTree opts sgr where
  opts = addOption firstLin $ stateOptions sgr

term2tree :: GFGrammar -> G.Term -> Tree
term2tree gr = errVal uTree . annotate (grammar gr) . qualifTerm (absId gr)

tree2term :: Tree -> G.Term
tree2term = tree2exp

linearizeToAll :: [GFGrammar] -> Tree -> [String]
linearizeToAll grs t = [linearize gr t | gr <- grs]

parse :: GFGrammar -> GFCat -> String -> [Tree]
parse sgr cat = errVal [] . parseString noOptions sgr cat

parseAny :: [GFGrammar] -> GFCat -> String -> [Tree]
parseAny grs cat s = concat [parse gr cat s | gr <- grs]

translate :: GFGrammar -> GFGrammar -> GFCat -> String -> [String]
translate ig og cat = map (linearize og) . parse ig cat

translateToAll :: GFGrammar -> [GFGrammar] -> GFCat -> String -> [String]
translateToAll ig ogs cat = concat . map (linearizeToAll ogs) . parse ig cat

translateFromAny :: [GFGrammar] -> GFGrammar -> GFCat -> String -> [String]
translateFromAny igs og cat s = concat [translate ig og cat s | ig <- igs]

translateBetweenAll :: [GFGrammar] -> GFCat -> String -> [String]
translateBetweenAll grs cat = concat . map (linearizeToAll grs) . parseAny grs cat

homonyms :: GFGrammar -> GFCat -> Tree -> [Tree]
homonyms gr cat = nub . parse gr cat . linearize gr

hasAmbiguousLin :: GFGrammar -> GFCat -> Tree -> Bool
hasAmbiguousLin gr cat t = case (homonyms gr cat t) of
  _:_:_ -> True
  _ -> False

{- ----
-- returns printname if one exists; othewrise linearizes with metas
printOrLin :: GFGrammar -> Fun -> String
printOrLin gr = printOrLinearize (stateGrammarST gr)

-- reads a syntax file and writes it in a format wanted
transformGrammarFile :: Options -> FilePath -> IO String
transformGrammarFile opts file = do
  sy <- useIOE GF.emptySyntax $ getSyntax opts file
  return $ optPrintSyntax opts sy
-}

prIdent :: Ident -> String
prIdent = prt

string2GFCat :: String -> String -> GFCat
string2GFCat = string2CFCat

-- then stg for customizable and internal use

optFile2grammar :: Options -> FilePath -> IOE GFGrammar
optFile2grammar os f  
  | fileSuffix f == "gfcm" = ioeIO $ liftM firstStateGrammar $ EA.file2grammar f
  | otherwise = do
      ((_,_,gr),_) <- compileModule os emptyShellState f
      ioeErr $ grammar2stateGrammar os gr

optFile2grammarE :: Options -> FilePath -> IOE GFGrammar
optFile2grammarE = optFile2grammar


string2treeInState :: GFGrammar -> String -> State -> Err Tree
string2treeInState gr s st = do
  let metas = allMetas st
      xs    = map fst $ actBinds st
  t0 <- pTerm s
  let t = qualifTerm (absId gr) $ M.mkAbs xs $ refreshMetas metas $ t0
  annotateExpInState (grammar gr) t st 

string2srcTerm :: G.SourceGrammar -> I.Ident -> String -> Err G.Term
string2srcTerm gr m s = do
  t <- pTerm s
  R.renameSourceTerm gr m t

randomTreesIO :: Options -> GFGrammar -> Int -> IO [Tree]
randomTreesIO opts gr n = do
  gen <- myStdGen mx
  t   <- err (\s -> putS s >> return []) 
             (return . singleton) $ 
                mkRandomTree gen mx g catfun
  ts  <- if n==1 then return [] else randomTreesIO opts gr (n-1)
  return $ t ++ ts
 where
   catfun = case getOptVal opts withFun of
     Just fun -> Right $ (absId gr, I.identC fun)
     _ -> Left $ firstAbsCat opts gr
   g   = grammar gr
   mx  = optIntOrN opts flagDepth 41
   putS s = if oElem beSilent opts then return () else putStrLnFlush s


generateTrees :: Options -> GFGrammar -> Maybe Tree -> [Tree]
generateTrees opts gr mt =
  optIntOrAll opts flagNumber  
    [tr | t <- Gen.generateTrees opts gr' cat dpt mn mt, Ok tr <- [mkTr t]]
  where
    mkTr = annotate gr' . qualifTerm (absId gr) 
    gr' = grammar gr
    cat = firstAbsCat opts gr
    dpt = maybe 3 id $ getOptInt opts flagDepth
    mn  = getOptInt opts flagAlts

speechGenerate :: Options -> String -> IO ()
speechGenerate opts str = do
  let lan = maybe "" (" --language" +++) $ getOptVal opts speechLanguage
  system ("flite" +++ "\" " ++ str ++ "\"")
---  system ("echo" +++ "\"" ++ str ++ "\" | festival --tts" ++ lan)
  return ()

optLinearizeTreeVal :: Options -> GFGrammar -> Tree -> String
optLinearizeTreeVal opts gr = err id id . optLinearizeTree opts gr

optLinearizeTree :: Options -> GFGrammar -> Tree -> Err String
optLinearizeTree opts0 gr t = case getOptVal opts transferFun of
  Just m -> useByTransfer flin g (I.identC m) t
  _ -> flin t
 where
  opts = addOptions opts0 (stateOptions gr)
  flin = case getOptVal opts markLin of
    Just mk
     | mk == markOptXML    -> lin markXML
     | mk == markOptJava   -> lin markXMLjgf
     | mk == markOptStruct -> lin markBracket
     | mk == markOptFocus  -> lin markFocus
     | otherwise           -> lin noMark
    _ -> lin noMark

  lin mk
    | oElem showRecord opts = liftM prt . linearizeNoMark g c
    | oElem tableLin opts   = liftM (unlines . map untok . prLinTable True) . 
                                allLinTables g c
    | oElem showFields opts = liftM (unlines . map untok) .
                                allLinBranchFields g c
    | oElem showAll opts    = liftM (unlines . map untok . prLinTable False) . 
                                allLinTables g c
    | otherwise = return . unlines . map untok . optIntOrOne . linTree2strings mk g c
  g = grammar gr
  c = cncId gr
  untok = if False ---- oElem (markLin markOptXML) opts 
            then untokWithXML unt
            else unt  
  unt = customOrDefault opts useUntokenizer customUntokenizer gr
  optIntOrOne = take $ optIntOrN opts flagNumber 1

{- ----
        untoksl . lin where
  gr = concreteOf (stateGrammarST sgr)
  lin -- options mutually exclusive, with priority: struct, rec, table, one
   | oElem showStruct opts = markedLinString True gr . tree2loc
   | oElem showRecord opts = err id prt                  . linTerm gr
   | oElem tableLin opts   = err id (concatMap prLinTable)  . allLinsAsStrs gr
   | oElem firstLin opts   = unlines . map sstr . take 1 . allLinStrings gr
   | otherwise = unlines . map sstr . optIntOrAll opts flagNumber . allLinStrings gr
  untoks = customOrDefault opts' useUntokenizer customUntokenizer sgr
  opts' = addOptions opts $ stateOptions sgr
  untoksl = unlines . map untoks . lines
-}

{-
optLinearizeArgForm :: Options -> StateGrammar -> [Term] -> Term -> String
optLinearizeArgForm opts sgr fs ts0 = untoksl $ lin ts where
  gr = concreteOf (stateGrammarST sgr) 
  ts = annotateTrm sgr ts0
  ms = map (renameTrm (lookupConcrete gr)) fs
  lin -- options mutually exclusive, with priority: struct, rec, table
   | oElem tableLin opts = err id (concatMap prLinTable) . allLinsForForms gr ms
   | otherwise = err id (unlines . map sstr . tkStrs . concat) . allLinsForForms gr ms
  tkStrs = concat . map snd . concat . map snd
  untoks = customOrDefault opts' useUntokenizer customUntokenizer sgr
  opts' = addOptions opts $ stateOptions sgr
  untoksl = unlines . map untoks . lines
-}

optParseArg :: Options -> GFGrammar -> String -> [Tree]
optParseArg opts gr =  err (const []) id . optParseArgErr opts gr

optParseArgAny :: Options -> [GFGrammar] -> String -> [Tree]
optParseArgAny opts grs s = concat [pars gr s | gr <- grs] where
  pars gr = optParseArg opts gr --- grammar options!

optParseArgErr :: Options -> GFGrammar -> String -> Err [Tree]
optParseArgErr opts gr = liftM fst . optParseArgErrMsg opts gr

optParseArgErrMsg :: Options -> GFGrammar -> String -> Err ([Tree],String)
optParseArgErrMsg opts gr s = do
  let cat = firstCatOpts opts gr
      g   = grammar gr
  (ts,m) <- parseStringMsg opts gr cat s
  ts' <- case getOptVal opts transferFun of
    Just m -> mkByTransfer (const $ return ts) g (I.identC m) s
    _ -> return ts
  return (ts',m)

-- | analyses word by word
morphoAnalyse :: Options -> GFGrammar -> String -> String
morphoAnalyse opts gr 
  | oElem beShort opts = morphoTextShort mo 
  | otherwise = morphoText mo 
 where
  mo = morpho gr

isKnownWord :: GFGrammar -> String -> Bool
isKnownWord gr s = case morphoAnalyse (options [beShort]) gr s of
  a@(_:_:_) -> last (init a) /= '*'  -- [word *]
  _ -> False

{-
prExpXML :: StateGrammar -> Term -> [String]
prExpXML gr = prElementX . term2elemx (stateAbstract gr) 

prMultiGrammar :: Options -> ShellState -> String
prMultiGrammar opts = M.showMGrammar (oElem optimizeCanon opts)
-}
-- access to customizable commands

optPrintGrammar :: Options -> StateGrammar -> String
optPrintGrammar opts = customOrDefault opts grammarPrinter customGrammarPrinter

optPrintMultiGrammar :: Options -> CanonGrammar -> String
optPrintMultiGrammar opts = encodeId . pmg opts . encode
    where 
    pmg = customOrDefault opts grammarPrinter customMultiGrammarPrinter
    -- if -utf8 was given, convert from language specific codings
    encode = if oElem useUTF8 opts then mapModules moduleToUTF8 else id
    -- if -utf8id was given, convert non-literals to UTF8
    encodeId = if oElem useUTF8id opts then nonLiteralsToUTF8 else id
    moduleToUTF8 m = 
	m{ jments = mapTree (onSnd (mapInfoTerms code)) (jments m),
	   flags = setFlag "coding" "utf8" (flags m) }
	where code = onTokens (anyCodingToUTF8 (moduleOpts m))
	      moduleOpts = Opts . okError . mapM CG.redFlag . flags

optPrintSyntax :: Options -> GF.Grammar -> String
optPrintSyntax opts = customOrDefault opts grammarPrinter customSyntaxPrinter

optPrintTree :: Options -> GFGrammar -> Tree -> String
optPrintTree opts = customOrDefault opts grammarPrinter customTermPrinter

-- | look for string command (-filter=x)
optStringCommand :: Options -> GFGrammar -> String -> String
optStringCommand opts g = 
  optIntOrAll opts flagLength .  
  customOrDefault opts filterString customStringCommand g

optTermCommand :: Options -> GFGrammar -> Tree -> [Tree]
optTermCommand opts st = 
  optIntOrAll opts flagNumber .  
  customOrDefault opts termCommand customTermCommand st


-- wraps term in a function and optionally computes the result

wrapByFun :: Options -> GFGrammar -> Ident -> Tree -> Tree
wrapByFun opts gr f t = 
  if oElem doCompute opts 
  then err (const t) id $ AC.computeAbsTerm (grammar gr) t' >>= annotate g
  else err (const t) id $ annotate g t'
 where
   t' = qualifTerm (absId gr) $ M.appCons f [tree2exp t]
   g = grammar gr

applyTransfer :: Options -> GFGrammar -> [(Ident,T.Env)] ->
                 (Maybe Ident,Ident) -> Tree -> Tree
applyTransfer opts gr trs (mm,f) t = 
  err (const t) id $ annotate g t'
 where
   t' = qualifTerm (absId gr) $ trans tr f $ tree2exp t
   g = grammar gr
   tr = case mm of
     Just m -> maybe empty id $ lookup m trs
     _ -> ifNull empty (snd . head) trs

   -- these are missing
   trans = error "no transfer yet" 
           ----- core2exp . T.appTransfer tr . exp2core
   empty = error "emptyEnv" 
           ---- T.emptyEnv

{-
optTransfer :: Options -> StateGrammar -> G.Term -> G.Term
optTransfer opts g = case getOptVal opts transferFun of
  Just f -> wrapByFun (addOption doCompute opts) g (M.zIdent f)
  _ -> id
-}

optTokenizer :: Options -> GFGrammar -> String -> String
optTokenizer opts gr = show . customOrDefault opts useTokenizer customTokenizer gr

-- performs UTF8 if the language does not have flag coding=utf8; replaces name*U

-- | convert a Unicode string into a UTF8 encoded string
optEncodeUTF8 :: GFGrammar -> String -> String
optEncodeUTF8 gr = case getOptVal (stateOptions gr) uniCoding of
  Just "utf8" -> id
  _ -> encodeUTF8

-- | convert a UTF8 encoded string into a Unicode string
optDecodeUTF8 :: GFGrammar -> String -> String
optDecodeUTF8 gr = case getOptVal (stateOptions gr) uniCoding of
  Just "utf8" -> decodeUTF8 
  _ -> id

-- | convert a string encoded with some coding given by the coding flag to UTF8
anyCodingToUTF8 :: Options -> String -> String
anyCodingToUTF8 opts = 
    encodeUTF8 . customOrDefault opts uniCoding customUniCoding


-- | Convert all text not inside double quotes to UTF8
nonLiteralsToUTF8 :: String -> String
nonLiteralsToUTF8 "" = ""
nonLiteralsToUTF8 ('"':cs) = '"' : l ++ nonLiteralsToUTF8 rs
    where 
    (l,rs) = takeStringLit cs
    -- | Split off an initial string ended by double quotes
    takeStringLit :: String -> (String,String)
    takeStringLit "" = ("","")
    takeStringLit ('"':cs) = (['"'],cs)
    takeStringLit ('\\':'"':cs) = ('\\':'"':xs,ys)
      where (xs,ys) = takeStringLit cs 
    takeStringLit (c:cs) = (c:xs,ys)
      where (xs,ys) = takeStringLit cs
nonLiteralsToUTF8 (c:cs) = encodeUTF8 [c] ++ nonLiteralsToUTF8 cs 
