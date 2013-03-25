-- lookup the Kotus list

import qualified Data.Map as M

main = do
  kotus <- readFile "kotus-sanalista_v1.xml" >>= return . mkKotus . lines
  mapM_ print $ take 6 $ M.toList kotus -- debug
  interact $ unlines . map (look kotus) . lines

look :: Kotus -> String -> String
look kotus w = case M.lookup w kotus of
  Just ["NOPAR"] -> lookCompound "INCOMPOUND" kotus w
  Just descr -> unwords $ w : descr
  _ -> lookCompound "OUTCOMPOUND" kotus w

lookCompound :: String -> Kotus -> String -> String
lookCompound pref kotus w = case concatMap looks (splits w) of
  descr:_ -> unwords $ w : [descr] 
  _ -> unwords $ w : pref : ["NOTFOUND"]
 where
   splits s = reverse [splitAt n s | n <- [3 .. length s - 3]]
   looks (x,y) = case M.lookup y kotus of 
     Just descr | elem x compPrefixes || any isCompPrefix (compForms x) -> [unwords $ pref : x : y : descr]
     _ -> []
   isCompPrefix x = case M.lookup x kotus of
     Just _ -> True
     _ -> False
   compForms x = let (initx,lastx) = (init x,last x) in 
                 x : [initx ++ "nen" | lastx == 's'] ++ [initx | elem lastx "n-" ] -- pakkas-, pakkanen
   compPrefixes = ["epä","ylä"]
     

type Kotus = M.Map String [String]

mkKotus :: [String] -> Kotus
mkKotus = M.fromList . map oneKotusLine . filter isWord

isWord = (=="<st>") . take 4

oneKotusLine :: String -> (String,[String])
oneKotusLine s = case untag s of w:ws -> (w,ws) 

-- <st><s>yhdesti</s><t><tn>99</tn></t></st>
--        yhdesti    <t><tn>99</tn></t></st>

untag s = case break (=='<') (drop 7 s) of 
  (w,d) -> case drop 4 d of
    '<':'t':'>':_ -> [w, take 2 (drop 11 d), drop 18 d]  -- 99, </st>
    _ -> [w, "NOPAR"]  -- no paradigm given



