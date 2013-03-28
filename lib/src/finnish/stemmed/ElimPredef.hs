import qualified Data.Set as S

-- comment out words that are predefined in another lexicon
-- runghc ElimPredef.hs <DictEngFin.gf

main = do
  predefs <- readFile "predef.txt" >>= return . S.fromList . map (head . words) . lines
  interact (unlines . map (elimPredef predefs) . lines)

elimPredef predefs line = case words line of
  w:_ | S.member w predefs -> "--PREDEF " ++  line
  _ -> line

