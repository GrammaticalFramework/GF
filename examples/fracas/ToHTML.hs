import Data.Char(isSpace)

main = interact (unlines.wrap "dl".concatMap conv.paras.lines)

conv (('@':n):ls) = (tag_class aname "dt"++(fmtnum n++": "++vt abs++" "++abs)):map conc concs
  where
    (aname,abs):concs = map (apSnd (dropWhile isSpace.drop 1).break (==':')) ls
    conc (lang,s) = tag_class lang "dd"++vp abs lang++" "++s

vt abs = tag' "img" ("src=\"http://cloud.grammaticalframework.org/minibar/tree-btn.png\""++a)
  where
    a = " onclick=\"vt(this,'"++abs++"')\""

vp abs lang = tag' "img" ("src=\"http://cloud.grammaticalframework.org/minibar/tree-btn.png\""++a)
  where
    a = " onclick=\"vp(this,'"++lang++"','"++abs++"')\""

fmtnum n =
    case words (map u2s n) of
      [_,n1,n2,_] -> dropWhile (=='0') n1++"."++n2
      _ -> n
  where
    u2s '_' = ' '
    u2s c   = c
    
--------------------------------------------------------------------------------

paras ls =
  case dropWhile null ls of
    [] -> []
    ls -> case break null ls of
            (ls1,ls2) -> ls1:paras ls2

wrap t ls = tag t:ls++[endtag t]

tag_class cls t = tag' t ("class="++cls)

tag' t a = '<':t++" "++a++">"

tag t = '<':t++">"
endtag t = tag ('/':t)

apSnd f (x,y) = (x,f y)
