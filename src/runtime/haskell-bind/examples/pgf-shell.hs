{-# LANGUAGE CPP #-}
-- | pgf-shell: A simple shell to illustrate the use of the Haskell binding
--   to the C implementation of the PGF run-time system.
--
--   The shell has 3 commands:
--
--     * parse: p <lang> <text>
--     * linearize: l <lang> <tree>
--     * translate: t <lang> <lang> <text> 

import Control.Monad(forever)
import Data.Char(isSpace)
import qualified Data.Map as M
import System.IO(hFlush,stdout)
import qualified System.IO.Error as S
import System.Environment
import PGF2
import System.Mem(performGC)
import qualified Data.Map as Map

main = getPGF =<< getArgs

getPGF [path] = pgfShell =<< readPGF path
getPGF _ = putStrLn "Usage: pgf-shell <path to pgf>"

pgfShell pgf =
  do putStrLn . unwords . M.keys $ languages pgf
     forever $ do performGC
                  putStr "> "; hFlush stdout
                  execute pgf =<< readLn

execute pgf cmd =
  case cmd of
    L lang tree -> do c <- getConcr' pgf lang
                      putStrLn $ linearize c tree
    P lang s    -> do c <- getConcr' pgf lang
                      printl $ parse c (startCat pgf) s
    T from to s -> do cfrom <- getConcr' pgf from
                      cto   <- getConcr' pgf to
                      putl [linearize cto t|(t,_)<-parse cfrom (startCat pgf) s]
    _ -> putStrLn "Huh?"
  `catch` print

getConcr' pgf lang =
    maybe (fail $ "Concrete syntax not found: "++show lang) return $
    Map.lookup lang (languages pgf)

printl xs = putl $ map show xs
putl = putStr . unlines

-- | Abstracy syntax of shell commands
data Command = P String String | L String Expr | T String String String deriving Show

-- | Shell command parser
instance Read Command where
  readsPrec _ s =
          [(P l r2,"") | ("p",r1)<-lex s,
                         (l,r2) <- lex r1]
       ++ [(L l t,"") | ("l",r1)<-lex s,
                        (l,r2)<- lex r1,
                        Just t<-[readExpr r2]]
       ++ [(T l1 l2 r3,"") | ("t",r1)<-lex s,
                             (l1,r2)<-lex r1,
                             (l2,r3)<-lex r2]

#if MIN_VERSION_base(4,6,0)
catch = S.catchIOError
#endif
