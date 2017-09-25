module GF.Command.CommandInfo where
import GF.Command.Abstract(Option,Expr,Term)
import GF.Text.Pretty(render)
import GF.Grammar.Printer() -- instance Pretty Term
import GF.Grammar.Macros(string2term)
import PGF(mkStr,unStr,showExpr)

data CommandInfo m = CommandInfo {
  exec     :: [Option] -> CommandArguments -> m CommandOutput,
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

data CommandArguments = Exprs [Expr] | Strings [String] | Term Term

newtype CommandOutput = Piped (CommandArguments,String) ---- errors, etc

-- ** Converting command output
fromStrings ss         = Piped (Strings ss, unlines ss)
fromExprs   es         = Piped (Exprs es,unlines (map (showExpr []) es))
fromString  s          = Piped (Strings [s], s)
pipeWithMessage es msg = Piped (Exprs es,msg)
pipeMessage msg        = Piped (Exprs [],msg)
pipeExprs   es         = Piped (Exprs es,[]) -- only used in emptyCommandInfo
void                   = Piped (Exprs [],"")

-- ** Converting command input

toStrings args =
    case args of
      Strings ss -> ss
      Exprs es -> zipWith showAsString (True:repeat False) es
      Term t -> [render t]
  where
    showAsString first t =
      case unStr t of
        Just s  -> s
        Nothing -> ['\n'|not first] ++
                   showExpr [] t ---newline needed in other cases than the first

toExprs args =
  case args of
    Exprs es -> es
    Strings ss -> map mkStr ss
    Term t -> [mkStr (render t)]

toTerm args =
  case args of
    Term t -> t
    Strings ss -> string2term $ unwords ss -- hmm
    Exprs es -> string2term $ unwords $ map (showExpr []) es -- hmm

-- ** Creating documentation

mkEx s = let (command,expl) = break (=="--") (words s) in (unwords command, unwords (drop 1 expl))
