-- | Pretty printing with class
module GF.Text.Pretty(module GF.Text.Pretty,module PP) where
import qualified Text.PrettyPrint as PP
import Text.PrettyPrint as PP(Doc,Style(..),Mode(..),style,empty,isEmpty)

class Pretty a where
  pp :: a -> Doc
  ppList :: [a] -> Doc
  ppList = fsep . map pp -- hmm

instance Pretty Doc where pp = id
instance Pretty Int where pp = PP.int
instance Pretty Integer where pp = PP.integer
instance Pretty Float where pp = PP.float
instance Pretty Double where pp = PP.double
instance Pretty Char where pp = PP.char; ppList = PP.text

instance Pretty a => Pretty [a] where
  pp = ppList
  ppList = fsep . map pp -- hmm

render x = PP.render (pp x)
renderStyle s x = PP.renderStyle s (pp x)

infixl 5 $$,$+$
infixl 6 <>,<+>

x $$ y = pp x PP.$$ pp y
x $+$ y = pp x PP.$+$ pp y
x <+> y = pp x PP.<+> pp y
x <> y = pp x PP.<> pp y

braces x = PP.braces (pp x)
brackets x = PP.brackets (pp x)
cat xs = PP.cat (map pp xs)
doubleQuotes x = PP.doubleQuotes (pp x)
fcat xs = PP.fcat (map pp xs)
fsep xs = PP.fsep (map pp xs)
hang x d y = PP.hang (pp x) d (pp y)
hcat xs = PP.hcat (map pp xs)
hsep xs = PP.hsep (map pp xs)
nest d x = PP.nest d (pp x)
parens x = PP.parens (pp x)
punctuate x ys = PP.punctuate (pp x) (map pp ys)
quotes x = PP.quotes (pp x)
sep xs = PP.sep (map pp xs)
vcat xs = PP.vcat (map pp xs)
