module GF.Command.Abstract where

import PGF.Data

type Ident = String

type CommandLine = [Pipe]

type Pipe = [Command]

data Command
   = Command Ident [Option] Argument
   deriving (Eq,Ord,Show)

data Option
  = OOpt Ident
  | OFlag Ident Value
  deriving (Eq,Ord,Show)

data Value
  = VId  Ident
  | VInt Integer
  | VStr String
  deriving (Eq,Ord,Show)

data Argument
  = ATree Tree
  | ANoArg
  | AMacro Ident
  deriving (Eq,Ord,Show)

valIdOpts :: String -> String -> [Option] -> String
valIdOpts flag def opts = case valOpts flag (VId def) opts of
  VId v -> v
  _     -> def

valIntOpts :: String -> Integer -> [Option] -> Int
valIntOpts flag def opts = fromInteger $ case valOpts flag (VInt def) opts of
  VInt v -> v
  _      -> def

valStrOpts :: String -> String -> [Option] -> String
valStrOpts flag def opts = case valOpts flag (VStr def) opts of
  VStr v -> v
  _      -> def

valOpts :: String -> Value -> [Option] -> Value
valOpts flag def opts = case lookup flag flags of
  Just v -> v
  _ -> def
 where
   flags = [(f,v) | OFlag f v <- opts]

isOpt :: String -> [Option] -> Bool
isOpt o opts = elem o [x | OOpt x <- opts]

isFlag :: String -> [Option] -> Bool
isFlag o opts = elem o [x | OFlag x _ <- opts]

prOpt :: Option -> String
prOpt (OOpt i) = i ----


