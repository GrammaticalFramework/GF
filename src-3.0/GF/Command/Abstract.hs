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
  deriving (Eq,Ord,Show)

data Argument
  = AExp Exp
  | ANoArg
  deriving (Eq,Ord,Show)
