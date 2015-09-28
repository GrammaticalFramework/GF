module GF.Compile.Compute.Value where
import GF.Grammar.Grammar(Label,Type,MetaId,Patt,QIdent)
import PGF.Internal(BindType)
import GF.Infra.Ident(Ident)
import Text.Show.Functions()
import Data.Ix(Ix)

-- | Self-contained (not quite) representation of values
data Value
  = VApp Predefined [Value] -- from Q, always Predef.x, has a built-in value
  | VCApp QIdent [Value] -- from QC, constructors
  | VGen Int [Value] -- for lambda bound variables, possibly applied
  | VMeta MetaId Env [Value]
-- -- | VClosure Env Term -- used in Typecheck.ConcreteNew
  | VAbs BindType Ident Binding -- used in Compute.ConcreteNew
  | VProd BindType Value Ident Binding -- used in Compute.ConcreteNew
  | VInt Int
  | VFloat Double
  | VString String
  | VSort Ident
  | VImplArg Value
  | VTblType Value Value
  | VRecType [(Label,Value)]
  | VRec [(Label,Value)]
  | VV Type [Value] [Value] -- preserve type for conversion back to Term
  | VT Wild Value [(Patt,Bind Env)]
  | VC Value Value
  | VS Value Value
  | VP Value Label
  | VPatt Patt
  | VPattType Value
  | VFV [Value]
  | VAlts Value [(Value, Value)]
  | VStrs [Value]
-- -- | VGlue Value Value -- hmm
-- --  | VExtR Value Value -- hmm
  | VError String
  deriving (Eq,Show)

type Wild = Bool
type Binding = Bind Value
data Bind a = Bind (a->Value) deriving Show

instance Eq (Bind a) where x==y = False

type Env = [(Ident,Value)]

-- | Predefined functions
data Predefined = Drop | Take | Tk | Dp | EqStr | Occur | Occurs | ToUpper
                | ToLower | IsUpper | Length | Plus | EqInt | LessInt 
             {- | Show | Read | ToStr | MapStr | EqVal -}
                | Error | Trace
                -- Canonical values below:
                | PBool | PFalse | PTrue | Int | Ints | NonExist 
                | BIND | SOFT_BIND | SOFT_SPACE | CAPIT | ALL_CAPIT
                deriving (Show,Eq,Ord,Ix,Bounded,Enum)
