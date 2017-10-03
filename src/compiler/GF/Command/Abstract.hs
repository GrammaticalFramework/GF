module GF.Command.Abstract(module GF.Command.Abstract,Expr,showExpr,Term) where

import PGF(CId,mkCId,Expr,showExpr)
import GF.Grammar.Grammar(Term)

type Ident = String

type CommandLine = [Pipe]

type Pipe = [Command]

data Command
   = Command Ident [Option] Argument
   deriving Show

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
  = AExpr Expr
  | ATerm Term
  | ANoArg
  | AMacro Ident
  deriving Show

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
  case listFlags flag opts of
    v:_ -> valueString v
    _   -> def

maybeCIdOpts :: String -> a -> (CId -> a) -> [Option] -> a
maybeCIdOpts flag def fn opts =
  case [v | OFlag f (VId v) <- opts, f == flag] of
    (v:_) -> fn (mkCId v)
    _     -> def

maybeIntOpts :: String -> a -> (Int -> a) -> [Option] -> a
maybeIntOpts flag def fn opts =
  case [v | OFlag f (VInt v) <- opts, f == flag] of
    (v:_) -> fn v
    _     -> def

maybeStrOpts :: String -> a -> (String -> a) -> [Option] -> a
maybeStrOpts flag def fn opts =
  case listFlags flag opts of
    v:_ -> fn (valueString v)
    _   -> def

listFlags flag opts = [v | OFlag f v <- opts, f == flag]

valueString v =
  case v of
    VStr v -> v
    VId  v -> v
    VInt v -> show v

isOpt :: String -> [Option] -> Bool
isOpt o opts = elem (OOpt o) opts

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

