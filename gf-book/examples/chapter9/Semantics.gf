abstract Semantics = Grammar, Logic ** {
fun
  iS     : S     -> Prop ;
  iCl    : Cl    -> Prop ;
  iNP    : NP    -> (Ind -> Prop) -> Prop ;
  iVP    : VP    -> Ind -> Prop ;
  iAP    : AP    -> Ind -> Prop ;
  iCN    : CN    -> Ind -> Prop ;
  iDet   : Det   -> (Ind -> Prop) -> (Ind -> Prop) -> Prop ;
  iN     : N     -> Ind -> Prop ;
  iA     : A     -> Ind -> Prop ;
  iV     : V     -> Ind -> Prop ;
  iV2    : V2    -> Ind -> Ind -> Prop ;
  iAdA   : AdA   -> (Ind -> Prop) -> Ind -> Prop ;
  iTense : Tense -> Prop -> Prop ;
  iPol   : Pol   -> Prop -> Prop ;
  iConj  : Conj  -> Prop -> Prop -> Prop ;
def
  iS  (UseCl t p cl) = iTense t (iPol p (iCl cl)) ;
  iCl (PredVP np vp) = iNP np (iVP vp) ;
  iVP (ComplV2 v2 np) i = iNP np (iV2 v2 i) ;
  iNP (DetCN det cn) f = iDet det (iCN cn) f ;
  iCN (ModCN ap cn) i = And (iAP ap i) (iCN cn i) ;
  iVP (CompAP ap) i = iAP ap i ;
  iAP (AdAP ada ap) i = iAdA ada (iAP ap) i ;
  iS  (ConjS conj x y) = iConj conj (iS x) (iS y) ;
  iNP (ConjNP conj x y) f = iConj conj (iNP x f) (iNP y f) ;
  iVP (UseV v) i = iV v i ;
  iAP (UseA a) i = iA a i ;
  iCN (UseN n) i = iN n i ;
  iDet a_Det d f = Exist (\x -> And (d x) (f x)) ;
  iDet every_Det d f = All (\x -> If (d x) (f x)) ;
  iPol Pos t = t ;
  iPol Neg t = Not t ;
  iTense Pres t = t ;
  iTense Perf t = Past t ;
  iConj and_Conj a b = And a b ;
  iConj or_Conj  a b = Or a b ;
}
