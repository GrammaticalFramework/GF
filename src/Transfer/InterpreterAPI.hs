module Transfer.InterpreterAPI (Env, load, loadFile, evaluateString) where

import Transfer.Core.Abs
import Transfer.Core.Lex
import Transfer.Core.Par
import Transfer.Core.Print
import Transfer.Interpreter
import Transfer.ErrM

-- | Read a transfer module in core format from a string.
load :: Monad m => 
        String -- ^ Input source name, for error messages.
     -> String -- ^ Module contents.
     -> m Env
load n s = case pModule (myLexer s) of
              Bad e -> fail $ "Parse error in " ++ n ++ ": " ++ e
              Ok  m -> return $ addModuleEnv builtin m

-- | Read a transfer module in core format from a file.
loadFile :: FilePath -> IO Env
loadFile f = readFile f >>= load f

-- | Read a transfer expression from a string and evaluate it.
--   Returns the result as a string.
evaluateString :: Monad m => Env -> String -> m String
evaluateString env s = 
    case pExp (myLexer s) of
        Bad e -> fail $ "Parse error: " ++ e
        Ok  e -> do
                 let v = eval env e
                 return $ printValue v
