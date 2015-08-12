-- | Commands requiring source grammar in env
module GF.Command.SourceCommands(sourceCommands) where
import Prelude hiding (putStrLn)
import qualified Prelude as P(putStrLn)
import Data.List(nub,isInfixOf)
import qualified Data.ByteString.UTF8 as UTF8(fromString)
import qualified Data.Map as Map

import GF.Infra.SIO
import GF.Infra.Option(noOptions)
import GF.Data.Operations (chunks,err,raise)
import GF.Text.Pretty(render)

import GF.Grammar hiding (Ident,isPrefixOf)
import GF.Grammar.Analyse
import GF.Grammar.Parser (runP, pExp)
import GF.Grammar.ShowTerm
import GF.Grammar.Lookup (allOpers,allOpersTo)
import GF.Compile.Rename(renameSourceTerm)
import qualified GF.Compile.Compute.ConcreteNew as CN(normalForm,resourceValues)
import GF.Compile.TypeCheck.RConcrete as TC(inferLType,ppType)
import GF.Infra.Dependencies(depGraph)
import GF.Infra.CheckM(runCheck)

import GF.Command.Abstract(Option(..),isOpt,listFlags,valueString,valStrOpts)
import GF.Command.CommandInfo

sourceCommands = Map.fromList [
  ("cc", emptyCommandInfo {
     longname = "compute_concrete",
     syntax = "cc (-all | -table | -unqual)? TERM",
     synopsis = "computes concrete syntax term using a source grammar",
     explanation = unlines [
       "Compute TERM by concrete syntax definitions. Uses the topmost",
       "module (the last one imported) to resolve constant names.",
       "N.B.1 You need the flag -retain when importing the grammar, if you want",
       "the definitions to be retained after compilation.",
       "N.B.2 The resulting term is not a tree in the sense of abstract syntax",
       "and hence not a valid input to a Tree-expecting command.",
       "This command must be a line of its own, and thus cannot be a part",
       "of a pipe."
       ],
     options = [
       ("all","pick all strings (forms and variants) from records and tables"),
       ("list","all strings, comma-separated on one line"),
       ("one","pick the first strings, if there is any, from records and tables"),
       ("table","show all strings labelled by parameters"),
       ("unqual","hide qualifying module names")
       ],
     needsTypeCheck = False, -- why not True?
     exec = withStrings compute_concrete
     }),
  ("dg",  emptyCommandInfo {
     longname = "dependency_graph",
     syntax = "dg (-only=MODULES)?",
     synopsis = "print module dependency graph",
     explanation = unlines [
       "Prints the dependency graph of source modules.",
       "Requires that import has been done with the -retain flag.",
       "The graph is written in the file _gfdepgraph.dot",
       "which can be further processed by Graphviz (the system command 'dot').",
       "By default, all modules are shown, but the -only flag restricts them",
       "by a comma-separated list of patterns, where 'name*' matches modules",
       "whose name has prefix 'name', and other patterns match modules with",
       "exactly the same name. The graphical conventions are:",
       "  solid box = abstract, solid ellipse = concrete, dashed ellipse = other",
       "  solid arrow empty head = of, solid arrow = **, dashed arrow = open",
       "  dotted arrow = other dependency"
       ],
     flags = [
       ("only","list of modules included (default: all), literally or by prefix*")
       ],
     examples = [
       mkEx "dg -only=SyntaxEng,Food*  -- shows only SyntaxEng, and those with prefix Food"
       ],
     needsTypeCheck = False,
     exec = withStrings dependency_graph
     }),
  ("sd", emptyCommandInfo {
     longname = "show_dependencies",
     syntax = "sd QUALIFIED_CONSTANT+",
     synopsis = "show all constants that the given constants depend on",
     explanation = unlines [
       "Show recursively all qualified constant names, by tracing back the types and definitions",
       "of each constant encountered, but just listing every name once.",
       "This command requires a source grammar to be in scope, imported with 'import -retain'.",
       "Notice that the accuracy is better if the modules are compiled with the flag -optimize=noexpand.",
       "This command must be a line of its own, and thus cannot be a part of a pipe."
       ],
     options = [
       ("size","show the size of the source code for each constants (number of constructors)")
       ],
     examples = [
       mkEx "sd ParadigmsEng.mkV ParadigmsEng.mkN  -- show all constants on which mkV and mkN depend",
       mkEx "sd -size ParadigmsEng.mkV    -- show all constants on which mkV depends, together with size"
       ],
     needsTypeCheck = False,
     exec = withStrings show_deps
     }),

  ("so", emptyCommandInfo {
     longname = "show_operations",
     syntax = "so (-grep=STRING)* TYPE?",
     synopsis = "show all operations in scope, possibly restricted to a value type",
     explanation = unlines [
       "Show the names and type signatures of all operations available in the current resource.",
       "This command requires a source grammar to be in scope, imported with 'import -retain'.",
       "The operations include the parameter constructors that are in scope.",
       "The optional TYPE filters according to the value type.",
       "The grep STRINGs filter according to other substrings of the type signatures."{-,
       "This command must be a line of its own, and thus cannot be a part",
       "of a pipe."-}
       ],
     flags = [
       ("grep","substring used for filtering (the command can have many of these)")
       ],
     options = [
       ("raw","show the types in computed forms (instead of category names)")
       ],
     examples = [
         mkEx "so Det -- show all opers that create a Det",
         mkEx "so -grep=Prep -- find opers relating to Prep",
         mkEx "so | wf -file=/tmp/opers -- write the list of opers to a file"
       ],
     needsTypeCheck = False,
     exec = withStrings show_operations
     }),

  ("ss", emptyCommandInfo {
     longname = "show_source",
     syntax = "ss (-strip)? (-save)? MODULE*",
     synopsis = "show the source code of modules in scope, possibly just headers",
     explanation = unlines [
       "Show compiled source code, i.e. as it is included in GF object files.",
       "This command requires a source grammar to be in scope, imported with 'import -retain'.",
       "The optional MODULE arguments cause just these modules to be shown.",
       "The -size and -detailedsize options show code size as the number of constructor nodes.",
       "This command must be a line of its own, and thus cannot be a part of a pipe."
       ],
     options = [
       ("detailedsize", "instead of code, show the sizes of all judgements and modules"),
       ("save", "save each MODULE in file MODULE.gfh instead of printing it on terminal"),
       ("size", "instead of code, show the sizes of all modules"),
       ("strip","show only type signatures of oper's and lin's, not their definitions")
       ],
     examples = [
       mkEx "ss                         -- print complete current source grammar on terminal",
       mkEx "ss -strip -save MorphoFin  -- print the headers in file MorphoFin.gfh"
       ],
     needsTypeCheck = False,
     exec = withStrings show_source
     })
  ]
  where
    withStrings exec sgr opts = do exec sgr opts . toStrings

    compute_concrete sgr opts ws =
      case runP pExp (UTF8.fromString s) of
        Left (_,msg) -> return $ pipeMessage msg
        Right t      -> return $ err pipeMessage
                                     (fromString . showTerm sgr style q)
                                 $ checkComputeTerm sgr t
      where
        (style,q) = pOpts TermPrintDefault Qualified opts
        s = unwords ws

        pOpts style q []     = (style,q)
        pOpts style q (o:os) =
          case o of
            OOpt "table"   -> pOpts TermPrintTable   q           os
            OOpt "all"     -> pOpts TermPrintAll     q           os
            OOpt "list"    -> pOpts TermPrintList    q           os
            OOpt "one"     -> pOpts TermPrintOne     q           os
            OOpt "default" -> pOpts TermPrintDefault q           os
            OOpt "unqual"  -> pOpts style            Unqualified os
            OOpt "qual"    -> pOpts style            Qualified   os
            _              -> pOpts style            q           os

    show_deps sgr os xs = do
          ops <- case xs of
             _:_ -> do
               let ts = [t | Right t <- map (runP pExp . UTF8.fromString) xs]
               err error (return . nub . concat) $ mapM (constantDepsTerm sgr) ts
             _   -> error "expected one or more qualified constants as argument"
          let prTerm = showTerm sgr TermPrintDefault Qualified
          let size = sizeConstant sgr
          let printed
                | isOpt "size" os =
                    let sz = map size ops in
                    unlines $ ("total: " ++ show (sum sz)) :
                              [prTerm f ++ "\t" ++ show s | (f,s) <- zip ops sz]
                | otherwise = unwords $ map prTerm ops
          return $ fromString printed

    show_operations sgr os ts =
      case greatestResource sgr of
        Nothing -> return $ fromString "no source grammar in scope; did you import with -retain?"
        Just mo -> do
          let greps = map valueString (listFlags "grep" os)
          let isRaw = isOpt "raw" os
          ops <- case ts of
             _:_ -> do
               let Right t = runP pExp (UTF8.fromString (unwords ts))
               ty <- err error return $ checkComputeTerm sgr t
               return $ allOpersTo sgr ty
             _   -> return $ allOpers sgr
          let sigs = [(op,ty) | ((mo,op),ty,pos) <- ops]
          let printer = if isRaw
                          then showTerm sgr TermPrintDefault Qualified
                          else (render . TC.ppType)
          let printed = [unwords [showIdent op, ":", printer ty] | (op,ty) <- sigs]
          return . fromString $ unlines [l | l <- printed, all (`isInfixOf` l) greps]

    show_source sgr os ts = do
      let strip = if isOpt "strip" os then stripSourceGrammar else id
      let mygr = strip $ case ts of
            _:_ -> mGrammar [(i,m) | (i,m) <- modules sgr, elem (render i) ts]
            [] -> sgr
      case () of
        _ | isOpt "detailedsize" os ->
               return . fromString $ printSizesGrammar mygr
        _ | isOpt "size" os -> do
               let sz = sizesGrammar mygr
               return . fromStrings $
                 ("total\t" ++ show (fst sz)):
                 [render j ++ "\t" ++ show (fst k) | (j,k) <- snd sz]
        _ | isOpt "save" os ->
              do mapM_ saveModule (modules mygr)
                 return void
              where
                saveModule m@(i,_) =
                  let file = (render i ++ ".gfh")
                  in restricted $
                        do writeFile file (render (ppModule Qualified m))
                           P.putStrLn ("wrote " ++ file)

        _ -> return . fromString $ render mygr

    dependency_graph sgr opts ws =
      do let stop = case valStrOpts "only" "" opts of
                      "" -> Nothing
                      fs -> Just $ chunks ',' fs
         restricted $
            do writeFile "_gfdepgraph.dot" (depGraph stop sgr)
               P.putStrLn "wrote graph in file _gfdepgraph.dot"
         return void

checkComputeTerm sgr t = do
                 mo <- maybe (raise "no source grammar in scope") return $ greatestResource sgr
                 ((t,_),_) <- runCheck $ do t <- renameSourceTerm sgr mo t
                                            inferLType sgr [] t
                 t1 <- return (CN.normalForm (CN.resourceValues noOptions sgr) (L NoLoc identW) t)
                 checkPredefError t1
