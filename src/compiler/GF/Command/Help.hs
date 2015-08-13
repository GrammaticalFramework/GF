module GF.Command.Help where
import GF.Command.Messages
import GF.Command.Abstract(isOpt,getCommandOp,showExpr)
import GF.Command.CommandInfo

import GF.Data.Operations((++++))
import qualified Data.Map as Map


commandHelpAll' allCommands opts = unlines $
  commandHelp' opts (isOpt "full" opts) `map` Map.toList allCommands

commandHelp' opts = if isOpt "t2t" opts then commandHelpTags else commandHelp

--commandHelp :: Bool -> (String,CommandInfo env) -> String
commandHelp full (co,info) = unlines . compact $ [
  co ++ optionally (", " ++) (longname info),
  synopsis info] ++ if full then [
  "",
  optionally (("syntax:" ++++).("  "++).(++"\n")) (syntax info),
  explanation info,
  section "options:"  [" -" ++ o ++ "\t" ++ e | (o,e) <- options info],
  section "flags:"    [" -" ++ o ++ "\t" ++ e | (o,e) <- flags info],
  section "examples:" ["  " ++ o ++ "\t--" ++ e | (o,e) <- examples info]
  ] else []

-- for printing with txt2tags formatting

--commandHelpTags :: Bool -> (String,CommandInfo env) -> String
commandHelpTags full (co,info) = unlines . compact $ [
  "#VSPACE","",
  "===="++hdrname++"====",
  "#NOINDENT",
  name ++ ": " ++
  "//" ++ synopsis info ++ ".//"] ++ if full then [
  "","#TINY","",
  explanation info,
  optionally ("- Syntax: "++) (lit (syntax info)),
  section "- Options:\n"  [" | ``-" ++ o ++ "`` | " ++ e | (o,e) <- options info],
  section "- Flags:\n"    [" | ``-" ++ o ++ "`` | " ++ e | (o,e) <- flags info],
  section "- Examples:\n" [" | ``"  ++ o ++ "`` | " ++ e | (o,e) <- examples info],
  "", "#NORMAL", ""
  ] else []
 where
   hdrname = co ++ equal (longname info)
   name = lit co ++ equal (lit (longname info))

   lit = optionally (wrap "``")
   equal = optionally (" = "++)
-- verbatim = optionally (wrap ["```"])
   wrap d s = d++s++d

section hdr = optionally ((hdr++++).unlines)

optionally f [] = []
optionally f s  = f s

compact [] = []
compact ([]:xs@([]:_)) = compact xs
compact (x:xs) = x:compact xs

helpCommand allCommands =
  ("h", emptyCommandInfo {
     longname = "help",
     syntax = "h (-full)? COMMAND?",
     synopsis = "get description of a command, or a the full list of commands",
     explanation = unlines [
       "Displays information concerning the COMMAND.",
       "Without argument, shows the synopsis of all commands."
       ],
     options = [
       ("changes","give a summary of changes from GF 2.9"),
       ("coding","give advice on character encoding"),
       ("full","give full information of the commands"),
       ("license","show copyright and license information"),
       ("t2t","output help in txt2tags format")
       ],
     exec = \opts ts ->
       let
        msg = case ts of
          _ | isOpt "changes" opts -> changesMsg
          _ | isOpt "coding" opts -> codingMsg
          _ | isOpt "license" opts -> licenseMsg
          [t] -> let co = getCommandOp (showExpr [] t) in
                 case Map.lookup co allCommands of
                   Just info -> commandHelp' opts True (co,info)
                   _ -> "command not found"
          _ -> commandHelpAll' allCommands opts
       in return (fromString msg),
     needsTypeCheck = False
     })
