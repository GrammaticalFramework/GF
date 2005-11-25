module Main where

import Transfer.Syntax.Lex
import Transfer.Syntax.Par
import Transfer.Syntax.Print
import Transfer.Syntax.Abs
import Transfer.Syntax.Layout

import Transfer.ErrM
import Transfer.SyntaxToCore

import Transfer.PathUtil

import System.Environment
import System.Exit
import System.IO

import Debug.Trace

myLLexer = resolveLayout True . myLexer

compile :: Monad m => [Decl] -> m String
compile m = return (printTree $ declsToCore m)

loadModule :: FilePath -> IO [Decl]
loadModule f = 
    do
    s <- readFile f
    Module is ds <- case pModule (myLLexer s) of
                     Bad e    -> die $ "Parse error in " ++ f ++ ": " ++ e
                     Ok  m    -> return m 
    let dir = directoryOf f
        deps = [ replaceFilename f i ++ ".tr" | Import (Ident i) <- is ]
    dss <- mapM loadModule deps
    return $ concat (ds:dss)

die :: String -> IO a
die s = do
        hPutStrLn stderr s
        exitFailure

coreFile :: FilePath -> FilePath
coreFile f = replaceFilenameSuffix f "trc"

compileFile :: FilePath -> IO String
compileFile f = loadModule f >>= compile

main :: IO ()
main = do args <- getArgs
          case args of
            [f] -> compileFile f >>= writeFile (coreFile f)
            _   -> die "Usage: compile_to_core <file>"
