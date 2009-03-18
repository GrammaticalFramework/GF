module GF.Command.Abstract where

import PGF.CId
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
  | VInt Int
  | VStr String
  deriving (Eq,Ord,Show)

data Argument
  = ATree Tree
  | ANoArg
  | AMacro Ident
  deriving (Eq,Ord,Show)

valCIdOpts :: String -> CId -> [Option] -> CId
valCIdOpts flag def opts =
  case [v | OFlag f (VId v) <- opts, f == flag] of
    (v:_) -> mkCId v
    _     -> def

valIntOpts :: String -> Int -> [Option] -> Int
valIntOpts flag def opts =
  case [v | OFlag f (VInt v) <- opts, f == flag] of
    (v:_) -> v
    _     -> def

valStrOpts :: String -> String -> [Option] -> String
valStrOpts flag def opts =
  case [v | OFlag f v <- opts, f == flag] of
    (VStr v:_) -> v
    (VId  v:_) -> v
    (VInt v:_) -> show v
    _          -> def

isOpt :: String -> [Option] -> Bool
isOpt o opts = elem o [x | OOpt x <- opts]

isFlag :: String -> [Option] -> Bool
isFlag o opts = elem o [x | OFlag x _ <- opts]

optsAndFlags :: [Option] -> ([Option],[Option])
optsAndFlags = foldr add ([],[]) where
  add o (os,fs) = case o of
    OOpt _    -> (o:os,fs)
    OFlag _ _ -> (os,o:fs)

prOpt :: Option -> String
prOpt o = case o of
  OOpt i    -> i
  OFlag f x -> f ++ "=" ++ show x

mkOpt :: String -> Option
mkOpt = OOpt

-- abbreviation convention from gf commands
getCommandOp s = case break (=='_') s of
     (a:_,_:b:_) -> [a,b]  -- axx_byy --> ab
     _ -> case s of
       [a,b] -> s          -- ab  --> ab
       a:_ -> [a]          -- axx --> a

