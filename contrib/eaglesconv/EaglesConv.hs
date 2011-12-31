-- Copyright (C) 2011 Nikita Frolov

-- No, we can't pipeline parsing and generation, because there is no guarantee
-- that we have collected all forms for a lemma before we've scanned the
-- complete file.

import qualified Data.Text as T
import qualified Data.Text.IO as UTF8
import System.IO
import System.Environment
import Control.Monad
import Control.Monad.State
import qualified Data.Map as M
import Codec.Text.IConv
import qualified Data.ByteString.Lazy as BS
import qualified Data.ByteString.Internal as BSI

import EaglesMatcher

type Lemmas = M.Map T.Text Forms

main :: IO ()
main = do
  args <- getArgs
  forM_ args $ \ f -> do
    entries <- UTF8.readFile f >>= (return . T.lines)
    lemmas <- return $ execState (collectLemmas entries) (M.empty :: Lemmas)
    mapM_ generateLin (M.assocs lemmas)

collectLemmas entries = do
  forM_ entries $ \ entry -> do
    let ws = T.words entry
        lemma = head ws
        tags = toPairs $ tail ws
    lemmas <- get
    forM_ tags $ \ (form, tag) -> do
      let forms = (case M.lookup lemma lemmas of
                     Just f -> f
                     Nothing -> M.empty) :: Forms
      if isOpenCat . T.unpack $ tag
       then put $ M.insert lemma (M.insert tag form forms) lemmas
       else return ()

generateLin :: (T.Text, Forms) -> IO ()
generateLin (lemma, forms) = do
  let lemma' = myVeryOwnCyrillicRomanizationIConvSucks lemma
  UTF8.putStr $ T.concat [T.pack "lin ", lemma']
  UTF8.putStr $ case T.unpack . head . M.keys $ forms of
                  ('N':_:_:_:g:a:'0':_) ->
                      T.concat $ [T.pack "_N = mkN "]
                               ++ map (quote . noun forms) [ ('N','S'), ('G','S')
                               , ('D','S'), ('F','S'), ('C','S'), ('O','S')
                               , ('L','S'), ('N','P'), ('G','P'), ('D','P')
                               , ('F','P'), ('C','P'), ('O','P') ]
                           ++ [showG g, sp, showAni a, ln]
                  ('N':_:c:n:g:a:_) ->
                      T.concat $ [T.pack "_PN = mkPN "
                       , quote $ noun forms ('N', 'S')
                       , showG g, sp
                       , showN n, sp, showAni a, ln]
                  ('A':_) ->
                      T.concat $ [T.pack "_A = mkA ", quote $ adj forms 'P',
                                   if adj forms 'P' /= adj forms 'C'
                                      then quote $ adj forms 'C'
                                      else T.pack ""
                                   , ln]
                  ('V':t) ->
                      let a = case t of
                                (_:_:_:_:'P':_:a':_) -> a'
                                (_:_:_:_:_:a':_) -> a'
                      in
                        T.concat $ [T.pack "_V = mkV ", showAsp a, sp]
                           ++ map (quote . verbPres forms) [ ('S','1'), ('S','2')
                                                           , ('S','3'), ('P','1')
                                                           , ('P','2'), ('P','3')]
                           ++ [ quote $ verbPast forms ('S', 'M')
                              , quote $ verbImp forms, quote $ verbInf forms, ln]
                  ('D':_) ->
                      T.concat $ [T.pack "_Adv = mkAdv "
                                 , quote . adv $ forms, ln]
  putStrLn ""
  hFlush stdout
      where quote x = T.concat [T.pack "\"", x, T.pack "\" "]
            showG 'F' = T.pack "Fem"
            showG 'A' = T.pack "Neut"
            showG _ = T.pack "Masc"
            showAni 'I' = T.pack "Inanimate"
            showAni _ = T.pack "Animate"
            showN 'P' = T.pack "Pl"
            showN _ = T.pack "Sg"
            showAsp 'F' = T.pack "Perfective"
            showAsp _ = T.pack "Imperfective"
            sp = T.singleton ' '
            ln = T.pack " ;"

toPairs xs = zip (stride 2 xs) (stride 2 (drop 1 xs))
    where stride _ [] = []
          stride n (x:xs) = x : stride n (drop (n-1) xs)

myVeryOwnCyrillicRomanizationIConvSucks s = T.pack . concatMap r . T.unpack $ s
    where r 'а' = "a"
          r 'б' = "b"
          r 'в' = "v"
          r 'г' = "g"
          r 'д' = "d"
          r 'е' = "je"
          r 'ё' = "jo"
          r 'ж' = "zh"
          r 'з' = "z"
          r 'и' = "i"
          r 'й' = "jj"
          r 'к' = "k"
          r 'л' = "l"
          r 'м' = "m"
          r 'н' = "n"
          r 'о' = "o"
          r 'п' = "p"
          r 'р' = "r"
          r 'с' = "s"
          r 'т' = "t"
          r 'у' = "u"
          r 'ф' = "f"
          r 'х' = "kh"
          r 'ц' = "c"
          r 'ч' = "ch"
          r 'ш' = "sh"
          r 'щ' = "shc"
          r 'ъ' = "yy"
          r 'ы' = "y"
          r 'ь' = "q"
          r 'э' = "e"
          r 'ю' = "ju"
          r 'я' = "ja"
          r '-' = "_"
          r o = [o]
