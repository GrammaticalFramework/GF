module GF.Compile.ExampleBased (parseExamplesInGrammar,configureExBased) where

import PGF
import PGF.Probabilistic

parseExamplesInGrammar :: ExConfiguration -> FilePath -> IO FilePath
parseExamplesInGrammar conf file = do
  src <- readFile file                             -- .gfe
  let file' = take (length file - 3) file ++ "gf"  -- .gf
  convertFile conf src file'
  return file'

convertFile :: ExConfiguration -> String -> FilePath -> IO ()
convertFile conf src file = do
  writeFile file "" -- "-- created by example-based grammar writing in GF\n"
  conv src
 where
  conv s = do
    (cex,end) <- findExample s
    if null end then return () else do
      convEx cex
      conv end
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
  lang = language conf 
  convEx (cat,ex) = do
    appn "("
    let typ = maybe (error "no valid cat") id $ readType cat
    let ts = rank $ parse pgf lang typ ex
    case ts of
      []   -> appv ("WARNING: cannot parse example " ++ ex)
      t:tt -> appn t >> mapM_ (appn . ("  --- " ++)) tt 
    appn ")"
  rank ts = case probs conf of
    Just probs -> [showExpr [] t ++ "  -- " ++ show p | (t,p) <- rankTreesByProbs probs ts]
    _ -> map (showExpr []) ts
  appf = appendFile file
  appn s = appf s >> appf "\n"
  appv s = appn s >> putStrLn s

data ExConfiguration = ExConf {
  resource_file :: FilePath,
  resource_pgf  :: PGF,
  probs    :: Maybe Probabilities,
  verbose  :: Bool,
  language :: Language
  }

configureExBased :: PGF -> Maybe Probabilities -> Language -> ExConfiguration
configureExBased pgf mprobs lang = ExConf [] pgf mprobs False lang

