----------------------------------------------------------------------
-- |
-- Module      : IOGrammar
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/31 19:02:35 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.19 $
--
-- for reading grammars and terms from strings and files
-----------------------------------------------------------------------------

module GF.API.IOGrammar (shellStateFromFiles,
		  getShellStateFromFiles) where

import GF.Grammar.Abstract
import qualified GF.Canon.GFC as GFC
import GF.Compile.PGrammar
import GF.Grammar.TypeCheck
import GF.Compile.Compile
import GF.Compile.ShellState
import GF.Probabilistic.Probabilistic

import GF.Infra.Modules
import GF.Infra.ReadFiles (isOldFile)
import GF.Infra.Option
import GF.Data.Operations
import GF.Infra.UseIO
import GF.System.Arch

import Control.Monad (liftM)

-- | a heuristic way of renaming constants is used
string2absTerm :: String -> String -> Term 
string2absTerm m = renameTermIn m . pTrm

renameTermIn :: String -> Term -> Term
renameTermIn m = refreshMetas [] . rename [] where
  rename vs t = case t of
    Abs x b -> Abs x (rename (x:vs) b)
    Vr c    -> if elem c vs then t else Q (zIdent m) c
    App f a -> App (rename vs f) (rename vs a)
    _ -> t

string2annotTree :: GFC.CanonGrammar -> Ident -> String -> Err Tree
string2annotTree gr m = annotate gr . string2absTerm (prt m) ---- prt

----string2paramList :: ConcreteST -> String -> [Term]
---string2paramList st = map (renameTrm (lookupConcrete st) . patt2term) . pPattList

shellStateFromFiles :: Options -> ShellState -> FilePath -> IOE ShellState
shellStateFromFiles opts st file = do
 let top = identC $ justModuleName file
 sh <- case fileSuffix file of
  "gfcm" -> do
     cenv <- compileOne opts (compileEnvShSt st []) file
     ioeErr $ updateShellState opts Nothing st cenv
  s | elem s ["cf","ebnf"] -> do
     let osb = addOptions (options []) opts
     grts <- compileModule osb st file
     ioeErr $ updateShellState opts Nothing st grts
  _ -> do
     b <- ioeIO $ isOldFile file
     let opts' = if b then (addOption showOld opts) else opts

     let osb = if oElem showOld opts' 
                 then addOptions (options []) opts' -- for old no emit
                 else addOptions (options [emitCode]) opts'
     grts <- compileModule osb st file
     let mtop = if oElem showOld opts' then Nothing else Just top
     ioeErr $ updateShellState opts' mtop st grts
 if (isSetFlag opts probFile || oElem (iOpt "prob") opts)
       then do 
         probs <- ioeIO $ getProbsFromFile opts file
         let lang = maybe top id $ concrete sh --- to work with cf, too
         ioeErr $ addProbs (lang,probs) sh
       else return sh

getShellStateFromFiles :: Options -> FilePath -> IO ShellState
getShellStateFromFiles os = 
  useIOE emptyShellState . 
  shellStateFromFiles os emptyShellState
