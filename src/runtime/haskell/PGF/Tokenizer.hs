{-
GF Tokenizer.

In this module are implemented function that build a fst-based tokenizer
from a Concrete grammar.

-}
{-# LANGUAGE CPP #-}
module PGF.Tokenizer 
       ( mkTokenizer
       ) where

#if MIN_VERSION_base(4,8,0)
import Prelude hiding ((<*>))
#endif
--import Data.List (intercalate)
--import Test.QuickCheck
import FST.TransducerInterface
import PGF.Morphology (fullFormLexicon, buildMorpho)
import PGF.Data (PGF, Language)



data LexSymbol = Tok String
    deriving (Show, Read)

type Lexicon = [LexSymbol]

-- | This is the construction function. Given a PGF and a Language, it 
-- extract the lexicon for this language and build a tokenization fst
-- from it.
mkTokenizer :: PGF -> Language -> (String -> Maybe [String])
mkTokenizer pgf lang = mkTrans lexicon
  where lexicon = map (Tok . fst) lexicon'
        lexicon' = fullFormLexicon $ buildMorpho pgf lang

mkTrans :: Lexicon -> (String -> Maybe [String])
mkTrans = applyDown . lexiconTrans

lexiconTrans :: Lexicon -> Transducer Char
lexiconTrans lexicon = compile (words |> star ((spaces <|> glue) |> words)) "abcdefghijklmnopqrstuvwxyz "
  where words = foldr (<|>) (empty) $ map tokToRR lexicon
        glue = eps <*> stringReg " &+ "

stringReg :: String -> Reg Char
stringReg str = foldr (\x y -> s x |> y) eps str 

tokToRR:: LexSymbol -> RReg Char
tokToRR (Tok str) = foldr ((|>) . idR . s) (idR eps) str

spaces :: RReg Char
spaces = idR $ s ' '



-- TESTING

-- verry small test lexicon
-- testLexicon :: Lexicon
-- testLexicon
--   = [ Tok "car"
--     , Tok "elf"
--     ]

-- myTrans :: String -> Maybe [String]
-- myTrans = mkTrans testLexicon

-- data TestCase = TestCase String String
--     deriving (Show, Read)

-- instance Arbitrary TestCase where
--     arbitrary     = arbitraryTestCase
--     --coarbitrary c = variant (ord c `rem` 4)

-- arbitraryTestCase:: Gen TestCase
-- arbitraryTestCase = do
--   words <- listOf1 $ elements [t | Tok t <- testLexicon]
--   tokens <- intercalateSometime "+&+" words
--   return $ TestCase (linearize tokens) (intercalate " " tokens)
--   where intercalateSometime :: a -> [a] -> Gen [a]
--         intercalateSometime x (x1:x2:xs) = do 
--           b <- arbitrary
--           let pre = case b of 
--                 True -> x1:x:[]
--                 False -> x1:[]
--           suf <- intercalateSometime x (x2:xs)
--           return (pre++suf)
--         intercalateSometime _ xs = return xs

-- linearize :: [String] -> String
-- linearize = linearize' False
--   where linearize' _ [] = ""  -- boolean indicate if the last token was a real word and not +&+
--         linearize' _  ("+&+":ss) = linearize' False ss
--         linearize' True (s:ss) = ' ':s ++ linearize' True ss
--         linearize' False (s:ss) = s ++ linearize' True ss

-- testTrans :: (String -> Maybe [String]) -> TestCase -> Bool
-- testTrans t (TestCase s1 s2) =
--   case t s1 of
--     Nothing -> False
--     Just l -> elem s2 l 

-- main :: IO ()
-- main = do
--   putStrLn "\n=== Transducer ==="
--   print $ lexiconTrans lexicon
--   putStrLn "\n=== example output ==="
--   putStrLn $ "Input:  " ++ show "car elfcar elf"
--   putStrLn $ "Output: " ++ (show $ mkTrans lexicon "car elfcar elf")
--   putStrLn "\n=== QuickCheck tests ==="
--   quickCheck (testTrans myTrans)
--   putStrLn "\n=== Examples of test cases ==="
--   sample (arbitrary :: Gen TestCase)
