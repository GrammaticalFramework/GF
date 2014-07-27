module GF.Infra.Location where
import GF.Text.Pretty

class HasSourcePath a where sourcePath :: a -> FilePath

data Location 
  = NoLoc
  | Local Int Int
  | External FilePath Location
  deriving (Show,Eq,Ord)

-- | Attaching location information
data L a = L Location a deriving Show

instance Functor L where fmap f (L loc x) = L loc (f x)

unLoc :: L a -> a
unLoc (L _ x) = x

noLoc = L NoLoc

ppLocation :: FilePath -> Location -> Doc
ppLocation fpath NoLoc          = pp fpath
ppLocation fpath (External p l) = ppLocation p l
ppLocation fpath (Local b e)
  | b == e    = fpath <> ":" <> b
  | otherwise = fpath <> ":" <> b <> "-" <> e


ppL (L loc x) msg = hang (ppLocation "" loc<>":") 4
                         ("In"<+>x<>":"<+>msg)
