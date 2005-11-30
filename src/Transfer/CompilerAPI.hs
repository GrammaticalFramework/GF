module Transfer.CompilerAPI where

import Transfer.Syntax.Lex
import Transfer.Syntax.Par
import Transfer.Syntax.Print
import Transfer.Syntax.Abs
import Transfer.Syntax.Layout

import Transfer.ErrM
import Transfer.SyntaxToCore

import Transfer.PathUtil

import System.Directory


-- | Compile a source module file to a a code file.
compileFile :: [FilePath]  -- ^ directories to look for imported modules in
            -> FilePath    -- ^ source module file
            -> IO FilePath -- ^ path to the core file that was written
compileFile path f = do
                     ds <- loadModule path f
                     s <- compile ds
                     writeFile coreFile s
                     return coreFile
  where coreFile = replaceFilenameSuffix f "trc"

-- | Compile a self-contained list of declarations to a core program.
compile :: Monad m => [Decl] -> m String
compile m = return (printTree $ declsToCore m)

-- | Load a source module file and all its dependencies.
loadModule :: [FilePath] -- ^ directories to look for imported modules in
           -> FilePath   -- ^ source module file
           -> IO [Decl]
loadModule path f = 
    do
    s <- readFile f
    Module is ds <- case pModule (myLLexer s) of
                     Bad e    -> fail $ "Parse error in " ++ f ++ ": " ++ e
                     Ok  m    -> return m 
    let deps = [ i | Import (Ident i) <- is ]
    let path' = directoryOf f : path
    files <- mapM (findFile path' . (++".tr")) deps
    dss <- mapM (loadModule path) files
    return $ concat (dss++[ds])

myLLexer :: String -> [Token]
myLLexer = resolveLayout True . myLexer

-- | Find a file in one of the given directories.
--   Fails if the file was not found.
findFile :: [FilePath] -- ^ directories to look in
          -> FilePath   -- ^ file name to find
          -> IO FilePath
findFile path f = 
    do
    mf <- findFileM path f
    case mf of
        Nothing -> fail $ f ++ " not found in path: " ++ show path
        Just f' -> return f'

-- | Find a file in one of the given directories.             
findFileM :: [FilePath] -- ^ directories to look in
          -> FilePath   -- ^ file name to find
          -> IO (Maybe FilePath)
findFileM []     _ = return Nothing
findFileM (p:ps) f = 
    do
    let f' = p ++ "/" ++ f
    e <- doesFileExist f'
    if e then return (Just f') else findFileM ps f
