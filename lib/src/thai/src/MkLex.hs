main = interact (unlines . map mkOne . lines)

mkOne s = case tabs s of
  _:eng:tha:_ -> mkEntry eng tha
  _ -> ""

tabs s = case break (=='\t') s of
  ([], _:ws) -> tabs ws
  (w , _:ws) -> w:tabs ws
  _ -> [s]

-- rough approximation of POS
mkEntry eng tha = unwords [" ",ident,"=",mk,def,";"] where
  (ident,mk) = case words eng of
    "to":w:_ -> (w ++ "_V", "mkV")
    w:_      -> (w ++ "_N", "mkN")
  def = "(thbind \"" ++ takeWhile (/=',') tha ++ "\")"


