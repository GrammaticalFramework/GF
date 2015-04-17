-- | pgf-shell: A simple shell to illustrate the use of the Haskell binding
--   to the C implementation of the PGF run-time system.
--
--   The shell has 4 commands:
--
--     * parse: p <lang> <text>
--     * linearize: l <lang> <tree>
--     * translate: t <lang> <lang> <text> 
--     * import: i <path to pgf>

import Control.Monad(forever)
import Control.Monad.State(evalStateT,put,get,gets,liftIO)
import Control.Exception.Lifted as L(catch)
import Data.Char(isSpace)
import qualified Data.Map as M
import System.IO(hFlush,stdout)
import System.Environment
import PGF2
import qualified Data.Map as Map

main = getPGF =<< getArgs

getPGF [path] = pgfShell =<< readPGF path
getPGF _ = putStrLn "Usage: pgf-shell <path to pgf>"

pgfShell pgf =
  do putStrLn . unwords . M.keys $ languages pgf
     flip evalStateT (pgf,[]) $ forever $ do puts "> "; liftIO $ hFlush stdout
                                             execute =<< liftIO readLn

execute cmd =
  case cmd of
    L lang tree -> do pgf <- gets fst
                      c <- getConcr' pgf lang
                      put (pgf,[])
                      putln $ linearize c tree
    P lang s    -> do pgf <- gets fst
                      c <- getConcr' pgf lang
                      case parse c (startCat pgf) s of
                        Left tok -> do put (pgf,[])
                                       putln ("Parse error: "++tok)
                        Right ts -> do put (pgf,map show ts)
                                       pop
    T from to s -> do pgf <- gets fst
                      cfrom <- getConcr' pgf from
                      cto   <- getConcr' pgf to
                      case parse cfrom (startCat pgf) s of
                        Left tok -> do put (pgf,[])
                                       putln ("Parse error: "++tok)
                        Right ts -> do put (pgf,map (linearize cto.fst) ts)
                                       pop
    I path -> do pgf <- liftIO (readPGF path)
                 putln . unwords . M.keys $ languages pgf
                 put (pgf,[])
    Empty -> pop
    Unknown s -> putln ("Unknown command: "++s)       
  `L.catch` (liftIO . print . (id::IOError->IOError))

pop = do (pgf,ls) <- get
         let (ls1,ls2) = splitAt 1 ls
         putl ls1
         put (pgf,ls2)

getConcr' pgf lang =
    maybe (fail $ "Concrete syntax not found: "++show lang) return $
    Map.lookup lang (languages pgf)

printl xs = liftIO $ putl $ map show xs
putl ls = liftIO . putStr $ unlines ls
putln s = liftIO $ putStrLn s
puts s = liftIO $ putStr s

-- | Abstracy syntax of shell commands
data Command = P String String | L String Expr | T String String String
             | I FilePath | Empty | Unknown String
             deriving Show

-- | Shell command parser
instance Read Command where
  readsPrec _ s =
      take 1 $
          [(P l r2,"") | ("p",r1)<-lex s, (l,r2) <- lex r1]
       ++ [(L l t,"") | ("l",r1)<-lex s, (l,r2)<- lex r1, Just t<-[readExpr r2]]
       ++ [(T l1 l2 r3,"") | ("t",r1)<-lex s, (l1,r2)<-lex r1, (l2,r3)<-lex r2]
       ++ [(I (dropWhile isSpace r),"") | ("i",r)<-lex s]
       ++ [(Empty,"") | ("","") <- lex s]
       ++ [(Unknown s,"")]
