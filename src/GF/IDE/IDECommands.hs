----------------------------------------------------------------------
-- |
-- Module      : IDECommands
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/09 22:34:01 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.1 $
--
-- Commands usable in grammar-writing IDE.
-----------------------------------------------------------------------------

module GF.IDE.IDECommands where

import GF.Infra.Ident (Ident, identC)
import GF.Compile.ShellState
import qualified GF.Shell.ShellCommands as S
import qualified GF.Shell.Commands as E
import qualified GF.Shell.CommandL as PE
import GF.UseGrammar.Session
import GF.UseGrammar.Custom
import GF.Grammar.PrGrammar

import GF.Infra.Option
import GF.Data.Operations
import GF.Infra.Modules
import GF.Infra.UseIO

data IDEState = IDE {
  ideShellState :: ShellState, 
  ideAbstract   :: Maybe Ident,
  ideConcretes  :: [Ident],
  ideCurrentCnc :: Maybe Ident,
  ideCurrentLin :: Maybe Ident, -- lin or lincat
  ideSState     :: Maybe SState
  }

emptyIDEState :: ShellState -> IDEState
emptyIDEState shst = IDE shst Nothing [] Nothing Nothing Nothing

data IDECommand =
    IDEInit
  | IDEAbstract Ident
  | IDEConcrete Ident
  | IDELin      Ident
  | IDEShell    String -- S.Command
  | IDEEdit     String -- E.Command
  | IDEQuit
  | IDEVoid     String -- the given command itself maybe


execIDECommand :: IDECommand -> IDEState -> IOE IDEState
execIDECommand c state = case c of
  IDEInit -> 
    return $ emptyIDEState env
  IDEAbstract a -> 
    return $ state {ideAbstract = Just a} ---- check a exists or import it
  IDEEdit s ->
    execEdit s
  IDEShell s ->
    execShell s
  IDEVoid s  -> ioeErr $ fail s
  _ -> ioeErr $ fail "command not implemented"

 where
   env = ideShellState state
   sstate = maybe initSState id $ ideSState state

   execShell s = execEdit $ "gf" +++ s

   execEdit s = ioeIO $ do
     (env',sstate') <- E.execCommand env (PE.pCommand s) sstate
     return $ state {ideShellState = env', ideSState = Just sstate'}

   putMsg = putStrLn ---- XML

pCommands :: String -> [IDECommand]
pCommands = map pCommand . concatMap (chunks ";;" . words) . lines

pCommand :: [String] -> IDECommand
pCommand ws = case ws of
  "gf"       : s     -> IDEShell $ unwords s
  "edit"     : s     -> IDEEdit  $ unwords s
  "abstract" : a : _ -> IDEAbstract $ identC a
  "concrete" : a : _ -> IDEConcrete $ identC a
  "lin"      : a : _ -> IDELin      $ identC a
  "empty"    : _     -> IDEInit
  "quit"     : _     -> IDEQuit
  _                  -> IDEVoid $ unwords ws
