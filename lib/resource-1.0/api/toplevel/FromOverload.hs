import Monad

main = do
  ss <- readFile src >>= return . map words . lines
  writeFile abstr "abstract OverGrammar = Structural,Numeral,Conjunction[ListS,ListNP,ListAP,ListAdv] ** {\n"
  appendFile abstr "cat ImpForm ; Punct ;\n"
  writeFile concr "concrete OverGrammarEng of OverGrammar = StructuralEng,NumeralEng,ConjunctionEng[ListS,ListNP,ListAP,ListAdv] ** open GrammarEng in {\n"
  mapM_ (appendFile concr) [
    "lincat ImpForm = {p : PImpForm ; s : Str} ;\n",
    "lincat Punct = {p : PPunct ; s : Str} ;\n",
    "param PImpForm = IFSg | IFPl | IFPol ;\n",
    "param PPunct = PFullStop | PExclMark | PQuestMark ;\n",
    "oper  mkUttImp : PImpForm -> Str -> Pol -> Imp -> Utt = \\f,s,p,i -> {s = s ++ (case f of {\n",
    "  IFSg  => UttImpSg p i ; IFPl  => UttImpPl p i ; IFPol => UttImpPol p i}).s ; lock_Utt = <>} ;\n",
    "oper  mkPhrPunct : Phr -> PPunct -> Str -> Text -> Text = \\p,f,s,t -> {s = s ++ (case f of {\n",
    "  PFullStop => TFullStop p t ; PExclMark => TExclMark p t ; PQuestMark => TQuestMark p t}).s ;\n", 
    "  lock_Text = <>} ;\n"
    ]

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

