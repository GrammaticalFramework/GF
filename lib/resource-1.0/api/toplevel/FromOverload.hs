import Monad

main = do
  ss <- readFile src >>= return . map words . lines
  writeFile abstr "abstract OverGrammar = Structural,Numeral,Conjunction[ListS,ListNP,ListAP,ListAdv] ** {\n"
  appendFile abstr "cat ImpForm ; Punct ;\n"
  writeFile concr "concrete OverGrammarEng of OverGrammar = StructuralEng,NumeralEng,ConjunctionEng[ListS,ListNP,ListAP,ListAdv] ** open GrammarEng in {\n"
  foldM process ("",0) ss
  appendFile abstr "}\n"
  appendFile concr "}\n"
  return ()

src = "constr.gf"
abstr = "OverGrammar.gf"
concr = "OverGrammarEng.gf"


process env@(mk,count) line = case line of
  ('-':'-':_) : _ -> return env
  _:rest | elem "=" rest && notElem "overload" rest -> do
    let (fun,lin) = span (/="=") line
    env2 <- process env fun
    process env2 lin
  mk1 : ":" : typ -> do
    let mk2 = withCount count mk1
    put abstr $ "fun" : mk2 : ":" : takeWhile (/="--") typ ++ [";\n"] 
    return $ (mk2,count)
  "=" : trm -> do
    put concr $ "lin" : mk : "=" : takeWhile (/=";") trm ++ [";\n"] 
    return $ (mk,count + 1)
  _ -> return env

put file ws = appendFile file $ unwords ws

withCount count mk = "ovrld" ++ show count ++ "_" ++ mk

