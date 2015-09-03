module GF.Command.CommandInfo where
import GF.Command.Abstract(Option,Expr)
import qualified PGF as H(showExpr)
import qualified PGF.Internal as H(Literal(LStr),Expr(ELit)) ----

data CommandInfo m = CommandInfo {
  exec     :: [Option] -> [Expr] -> m CommandOutput,
  synopsis :: String,
  syntax   :: String,
  explanation :: String,
  longname :: String,
  options  :: [(String,String)],
  flags    :: [(String,String)],
  examples :: [(String,String)],
  needsTypeCheck :: Bool
  }

mapCommandExec f c = c { exec = \ opts ts -> f (exec c opts ts) }

--emptyCommandInfo :: CommandInfo env
emptyCommandInfo = CommandInfo {
  exec = error "command not implemented",
  synopsis = "",
  syntax = "",
  explanation = "",
  longname = "",
  options = [],
  flags = [],
  examples = [],
  needsTypeCheck = True
  }
--------------------------------------------------------------------------------

class Monad m => TypeCheckArg m where typeCheckArg :: Expr -> m Expr

--------------------------------------------------------------------------------

newtype CommandOutput  = Piped {fromPipe :: ([Expr],String)} ---- errors, etc

-- ** Converting command output
fromStrings ss         = Piped (map stringAsExpr ss, unlines ss)
fromExprs   es         = Piped (es,unlines (map (H.showExpr []) es))
fromString  s          = Piped ([stringAsExpr s], s)
pipeWithMessage es msg = Piped (es,msg)
pipeMessage msg        = Piped ([],msg)
pipeExprs   es         = Piped (es,[]) -- only used in emptyCommandInfo
void                   = Piped ([],"")

stringAsExpr = H.ELit . H.LStr -- should be a pattern macro

-- ** Converting command input

toStrings = map showAsString
  where
    showAsString t = case t of
      H.ELit (H.LStr s) -> s
      _ -> "\n" ++ H.showExpr [] t ---newline needed in other cases than the first

-- ** Creating documentation

mkEx s = let (command,expl) = break (=="--") (words s) in (unwords command, unwords (drop 1 expl))
