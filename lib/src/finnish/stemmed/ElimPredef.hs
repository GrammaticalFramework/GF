import qualified Data.Set as S

-- comment out words that are predefined in another lexicon
-- runghc ElimPredef.hs <DictEngFin.gf
removeFile = "todo.txt"
removeMsg = "WWWW"

-- also used for temporarily eliminating whatever from compilation
--removeFile = "commentOut"
--removeMsg = "POSTPONE"

main = do
  predefs <- readFile removeFile >>= return . S.fromList . map (head . words) . lines
  interact (unlines . map (elimPredef predefs) . lines)

elimPredef predefs line = case words line of
  w:_ | S.member w predefs -> "--" ++ removeMsg ++ " " ++ line
  _ -> line

