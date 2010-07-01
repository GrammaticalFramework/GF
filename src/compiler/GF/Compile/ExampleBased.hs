module GF.Compile.ExampleBased (
  parseExamplesInGrammar,
  configureExBased
  ) where

import PGF
import PGF.Probabilistic
import PGF.Morphology

import Data.List

parseExamplesInGrammar :: ExConfiguration -> FilePath -> IO (FilePath,[String])
parseExamplesInGrammar conf file = do
  src <- readFile file                             -- .gfe
  let file' = take (length file - 3) file ++ "gf"  -- .gf
  ws <- convertFile conf src file'
  return (file',ws)

convertFile :: ExConfiguration -> String -> FilePath -> IO [String]
convertFile conf src file = do
  writeFile file "" -- "-- created by example-based grammar writing in GF\n"
  conv [] src
 where
  conv ws s = do
    (cex,end) <- findExample s
    if null end then return (nub (sort ws)) else do
      ws2 <- convEx cex
      conv (ws2 ++ ws) end
  findExample s = case s of
    '%':'e':'x':cs -> return $ getExample cs
    c:cs -> appf [c] >> findExample cs
    _ -> return (undefined,s)
  getExample s = 
    let 
      (cat,exend) = break (=='"') s
      (ex,   end) = break (=='"') (tail exend)
    in ((unwords (words cat),ex), tail end)  -- quotes ignored
  pgf = resource_pgf conf
  morpho = resource_morpho conf
  lang = language conf 
  convEx (cat,ex) = do
    appn "("
    let typ = maybe (error "no valid cat") id $ readType cat
    ws <- case fst (parse_ pgf lang typ ex) of
      ParseFailed _ -> do
        let ws = morphoMissing morpho (words ex)
        appv ("WARNING: cannot parse example " ++ ex) 
        case ws of
          [] -> return ()
          _  -> appv ("  missing words: " ++ unwords ws)
        return ws
      TypeError _ _ ->
        return []
      ParseOk ts ->
        case rank ts of
          (t:tt) -> appv ("WARNING: ambiguous example " ++ ex) >>
                    appn t >> mapM_ (appn . ("  --- " ++)) tt >> return []
    appn ")"
    return ws
  rank ts = case probs conf of
    Just probs -> [showExpr [] t ++ "  -- " ++ show p | (t,p) <- rankTreesByProbs probs ts]
    _ -> map (showExpr []) ts
  appf = appendFile file
  appn s = appf s >> appf "\n"
  appv s = appn ("--- " ++ s) >> putStrLn s

data ExConfiguration = ExConf {
  resource_pgf    :: PGF,
  resource_morpho :: Morpho,
  probs    :: Maybe Probabilities,
  verbose  :: Bool,
  language :: Language
  }

configureExBased :: PGF -> Morpho -> Maybe Probabilities -> Language -> ExConfiguration
configureExBased pgf morpho mprobs lang = ExConf pgf morpho mprobs False lang

