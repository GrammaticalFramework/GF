module GF.Compile.Compute.Value where
import GF.Grammar.Grammar(Label,Type,TInfo,MetaId,Patt,QIdent)
import PGF.Data(BindType)
import GF.Infra.Ident(Ident)
import Text.Show.Functions

-- | Self-contained (not quite) representation of values
data Value
  = VApp QIdent [Value] -- from Q, always Predef.x, has a built-in value
  | VCApp QIdent [Value] -- from QC, constructors
  | VGen Int [Value] -- for lambda bound variables, possibly applied
  | VMeta MetaId Env [Value]
-- | VClosure Env Term -- used in Typecheck.ConcreteNew
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
  | VV Type [Value]
  | VT TInfo [(Patt,Bind Env)]
  | VC Value Value
  | VS Value Value
  | VP Value Label
  | VPatt Patt
  | VPattType Value
  | VFV [Value]
  | VAlts Value [(Value, Value)]
  | VStrs [Value]
-- | VGlue Value Value -- hmm
  | VExtR Value Value -- hmm
  | VError String
  deriving (Eq,Show)

type Binding = Bind Value
data Bind a = Bind (a->Value) deriving Show

instance Eq (Bind a) where x==y = False

type Env = [(Ident,Value)]
