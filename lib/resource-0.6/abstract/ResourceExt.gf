incomplete resource ResourceExt = open Resource in {

-- Mostly for compatibility with old API (v 0.4). Also for
-- special cases of plural determiners without numerals.
-- AR 12/1/2004

oper

  PosV : V -> VP = \x -> PosVG (PredV x) ;
  NegV : V -> VP = \x -> NegVG (PredV x) ;
  PosTV : TV -> NP -> VP = \x,y -> PosVG (PredTV x y) ;
  NegTV : TV -> NP -> VP = \x,y -> NegVG (PredTV x y) ;
  PosA : AP -> VP = \x -> PosVG (PredAP x) ;
  NegA : AP -> VP = \x -> NegVG (PredAP x) ;
  PosCN : CN -> VP = \x -> PosVG (PredCN x) ;
  NegCN : CN -> VP = \x -> NegVG (PredCN x) ;

  IndefManyNP : CN -> NP = IndefNumNP NoNum ;
  DefManyNP : CN -> NP = DefNumNP NoNum ;
  ModGenMany : NP -> CN -> NP = ModGenNum NoNum ;

  WeNP : NP = WeNumNP NoNum ;
  YeNP : NP = YeNumNP NoNum ;

  TheseNP : NP = TheseNumNP NoNum ;
  ThoseNP : NP = ThoseNumNP NoNum ;

  AllDet : Det = AllNumDet NoNum ;
  WhichsDet : Det = WhichNumDet NoNum ;
  SomesDet : Det = SomeNumDet NoNum ;
  AnysDet : Det = AnyNumDet NoNum ;
  NosDet : Det = NoNumDet NoNum ;
  TheseDet : Det = TheseNumDet NoNum ;
  ThoseDet : Det = ThoseNumDet NoNum ;

} ;
